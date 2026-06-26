import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// Hide postgrest's `Headers` so dio's `Headers` constants resolve unambiguously.
import 'package:supabase_flutter/supabase_flutter.dart' hide Headers;

import 'package:orbit/core/config/env.dart';
import 'package:orbit/core/network/network_guard.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/auth/data/datasources/profile_api.dart';
import 'package:orbit/features/auth/data/models/profile_model.dart';
import 'package:orbit/features/auth/domain/entities/app_user.dart';
import 'package:orbit/features/auth/domain/entities/onboarding_input.dart';
import 'package:orbit/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._client, this._api, this._dio);

  final SupabaseClient _client;
  final ProfileApi _api;
  final Dio _dio;

  @override
  bool get isAuthenticated => _client.auth.currentSession != null;

  @override
  Future<Result<void>> signUp({
    required String email,
    required String password,
  }) =>
      guard(() async {
        final res =
            await _client.auth.signUp(email: email, password: password);
        // With "Confirm email" enabled there is no session yet — surface a
        // clear message. Disable it in Supabase Auth settings for an instant
        // signup -> onboarding flow.
        if (res.session == null) {
          throw const AuthException('확인 메일을 보냈어요. 메일 인증 후 로그인해주세요.');
        }
      });

  @override
  Future<Result<void>> signIn({
    required String email,
    required String password,
  }) =>
      guard(() => _client.auth
          .signInWithPassword(email: email, password: password));

  static String _nonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final r = Random.secure();
    return List.generate(length, (_) => charset[r.nextInt(charset.length)])
        .join();
  }

  /// Whether a JWT carries a non-empty `nonce` claim. GoTrue rejects an
  /// id-token grant when exactly one of (passed nonce, token nonce) is present
  /// ("...should either both exist or not"), so we only forward the nonce when
  /// the token actually contains one.
  static bool _idTokenHasNonce(String idToken) {
    try {
      final parts = idToken.split('.');
      if (parts.length < 2) return false;
      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      ) as Map<String, dynamic>;
      final n = payload['nonce'];
      return n is String && n.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<Result<void>> signInWithApple() => guard(() async {
        final rawNonce = _nonce();
        final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: hashedNonce,
        );
        final idToken = credential.identityToken;
        if (idToken == null) {
          throw const AuthException('애플 로그인에 실패했어요.');
        }
        await _client.auth.signInWithIdToken(
          provider: OAuthProvider.apple,
          idToken: idToken,
          nonce: _idTokenHasNonce(idToken) ? rawNonce : null,
        );
      });

  @override
  Future<Result<void>> signInWithGoogle() => guard(() async {
        final googleSignIn = GoogleSignIn(
          clientId: Env.googleIosClientId,
          serverClientId: Env.googleWebClientId.isEmpty
              ? null
              : Env.googleWebClientId,
        );
        final account = await googleSignIn.signIn();
        if (account == null) throw const AuthException('로그인이 취소되었어요.');
        final auth = await account.authentication;
        final idToken = auth.idToken;
        if (idToken == null) {
          throw const AuthException('구글 로그인에 실패했어요.');
        }
        await _client.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: auth.accessToken,
        );
      });

  @override
  Future<Result<void>> signOut() => guard(() => _client.auth.signOut());

  @override
  Future<Result<AppUser?>> fetchProfile() => guard(() async {
        final res = await _api.getMe();
        final data = res['data'] as Map<String, dynamic>?;
        final profile = data?['profile'] as Map<String, dynamic>?;
        if (profile == null) return null;
        return ProfileModel.fromJson(profile).toEntity();
      });

  @override
  Future<Result<AppUser>> completeOnboarding(OnboardingInput input) =>
      guard(() async {
        final res = await _api.complete(_toBody(input));
        final profile =
            (res['data'] as Map<String, dynamic>)['profile'] as Map<String, dynamic>;
        return ProfileModel.fromJson(profile).toEntity();
      });

  @override
  Future<Result<AppUser>> updateProfile(Map<String, dynamic> patch) =>
      guard(() async {
        final res = await _api.update(patch);
        final profile =
            (res['data'] as Map<String, dynamic>)['profile'] as Map<String, dynamic>;
        return ProfileModel.fromJson(profile).toEntity();
      });

  @override
  Future<Result<String>> uploadAvatar({
    required Uint8List bytes,
    required String contentType,
  }) =>
      guard(() async {
        // Raw bytes straight to the `avatar` Edge Function (it re-encodes to
        // WebP). Dio streams the body with an explicit content length.
        final res = await _dio.post<Map<String, dynamic>>(
          'avatar',
          data: Stream<List<int>>.value(bytes),
          // Set contentType on Options (not just a header) so it overrides the
          // client's default application/json — the function uses it to pick the
          // PNG vs JPEG decoder.
          options: Options(
            contentType: contentType,
            headers: {Headers.contentLengthHeader: bytes.length},
          ),
        );
        final url = (res.data?['data'] as Map<String, dynamic>?)?['avatar_url'];
        if (url is! String) throw const FormatException('no_avatar_url');
        return url;
      });

  Map<String, dynamic> _toBody(OnboardingInput i) => {
        'role': i.role.name,
        'display_name': i.displayName,
        if (i.phone != null) 'phone': i.phone,
        if (i.role == Role.company) ...{
          'company_name': i.companyName,
          'biz_no': i.bizNo,
          'contact': i.contact,
          'website': i.website,
        },
        if (i.role == Role.influencer) ...{
          'nickname': i.nickname,
          'bio': i.bio,
          'main_platform': i.mainPlatform,
          'categories': i.categories,
        },
      };
}
