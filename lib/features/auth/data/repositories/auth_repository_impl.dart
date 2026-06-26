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

  /// The `nonce` claim inside a JWT, or null. GoTrue rejects an id-token grant
  /// when exactly one of (passed nonce, token nonce) is present ("...should
  /// either both exist or not"), so we use this to forward the nonce only when
  /// the token actually carries one.
  static String? _idTokenNonce(String idToken) {
    try {
      final parts = idToken.split('.');
      if (parts.length < 2) return null;
      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      ) as Map<String, dynamic>;
      final n = payload['nonce'];
      return (n is String && n.isNotEmpty) ? n : null;
    } catch (_) {
      return null;
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
          // Apple hashes our nonce into the token; pass the raw nonce back (only
          // if the token actually carries a nonce claim).
          nonce: _idTokenNonce(idToken) != null ? rawNonce : null,
        );
      });

  // google_sign_in 7.x: initialize() must run exactly once per app session and
  // is where the nonce is set. We generate it here (and keep the raw value) so
  // GoTrue can validate the id_token — it hashes the raw nonce and compares it
  // to the token's `nonce` claim (which equals the hashed nonce we pass in).
  static bool _googleInited = false;
  static String? _googleRawNonce;

  @override
  Future<Result<void>> signInWithGoogle() => guard(() async {
        final signIn = GoogleSignIn.instance;
        if (!_googleInited) {
          _googleRawNonce = _nonce();
          final hashedNonce =
              sha256.convert(utf8.encode(_googleRawNonce!)).toString();
          await signIn.initialize(
            clientId: Env.googleIosClientId,
            serverClientId: Env.googleWebClientId.isEmpty
                ? null
                : Env.googleWebClientId,
            nonce: hashedNonce,
          );
          _googleInited = true;
        }

        final GoogleSignInAccount account;
        try {
          account = await signIn.authenticate();
        } on GoogleSignInException catch (e) {
          if (e.code == GoogleSignInExceptionCode.canceled) {
            throw const AuthException('로그인이 취소되었어요.');
          }
          rethrow;
        }
        final idToken = account.authentication.idToken;
        if (idToken == null) {
          throw const AuthException('구글 로그인에 실패했어요.');
        }
        await _client.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          nonce: _googleRawNonce,
        );
      });

  @override
  Future<Result<void>> signOut() => guard(() => _client.auth.signOut());

  @override
  Future<Result<void>> deleteAccount() => guard(() async {
        await _api.deleteAccount();
        // The user no longer exists server-side; clear the local session too.
        await _client.auth.signOut();
      });

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
