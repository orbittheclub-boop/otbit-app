import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:orbit/core/providers/app_providers.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/auth/domain/entities/app_user.dart';
import 'package:orbit/features/auth/domain/entities/onboarding_input.dart';
import 'package:orbit/features/auth/presentation/providers/auth_providers.dart';

part 'auth_controller.g.dart';

/// Single source of truth for "who is signed in". Returns null when signed out.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<AppUser?> build() async {
    final repo = ref.watch(authRepositoryProvider);
    final client = ref.watch(supabaseClientProvider);

    final sub = client.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedOut && state.value != null) {
        state = const AsyncData(null);
      }
    });
    ref.onDispose(sub.cancel);

    final user = client.auth.currentUser;
    if (user == null) return null;

    final res = await repo.fetchProfile();
    final profile = switch (res) { Ok(:final value) => value, Err() => null };
    if (profile != null) return profile;

    // Authenticated but onboarding not finished — minimal user (role null).
    return AppUser(id: user.id, email: user.email ?? '', onboarded: false);
  }

  Future<String?> signIn(String email, String password) async {
    final res = await ref
        .read(authRepositoryProvider)
        .signIn(email: email, password: password);
    return res.when(
      ok: (_) {
        ref.invalidateSelf();
        return null;
      },
      err: (f) => f.message,
    );
  }

  Future<String?> signUp(String email, String password) async {
    final res = await ref
        .read(authRepositoryProvider)
        .signUp(email: email, password: password);
    return res.when(
      ok: (_) {
        ref.invalidateSelf();
        return null;
      },
      err: (f) => f.message,
    );
  }

  Future<String?> signInWithApple() async {
    final res = await ref.read(authRepositoryProvider).signInWithApple();
    return res.when(
      ok: (_) {
        ref.invalidateSelf();
        return null;
      },
      err: (f) => f.message,
    );
  }

  Future<String?> signInWithGoogle() async {
    final res = await ref.read(authRepositoryProvider).signInWithGoogle();
    return res.when(
      ok: (_) {
        ref.invalidateSelf();
        return null;
      },
      err: (f) => f.message,
    );
  }

  Future<String?> completeOnboarding(OnboardingInput input) async {
    final res =
        await ref.read(authRepositoryProvider).completeOnboarding(input);
    return res.when(
      ok: (_) {
        ref.invalidateSelf();
        return null;
      },
      err: (f) => f.message,
    );
  }

  /// Updates editable profile fields (display name, nickname/company name).
  /// Returns null on success, or an error message.
  Future<String?> updateProfile(Map<String, dynamic> patch) async {
    final res = await ref.read(authRepositoryProvider).updateProfile(patch);
    return res.when(
      ok: (_) {
        ref.invalidateSelf();
        return null;
      },
      err: (f) => f.message,
    );
  }

  /// Uploads a new avatar (raw image bytes) and refreshes the profile.
  Future<String?> changeAvatar(Uint8List bytes, String contentType) async {
    final res = await ref
        .read(authRepositoryProvider)
        .uploadAvatar(bytes: bytes, contentType: contentType);
    return res.when(
      ok: (_) {
        ref.invalidateSelf();
        return null;
      },
      err: (f) => f.message,
    );
  }

  Future<void> signOut() async {
    state = const AsyncData(null);
    await ref.read(authRepositoryProvider).signOut();
  }
}
