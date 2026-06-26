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
      err: (f) => f.message, // error code → localized in the UI
    );
  }

  Future<String?> signInWithGoogle() async {
    final res = await ref.read(authRepositoryProvider).signInWithGoogle();
    return res.when(
      ok: (_) {
        ref.invalidateSelf();
        return null;
      },
      err: (f) => f.message, // error code → localized in the UI
    );
  }

  // ── Signup wizard: account is created LAST (email or social), then the
  // info collected up-front is submitted — so the role is set before the router
  // can bounce to the standalone /onboarding. Existing accounts just sign in.

  Future<String?> signUpWithEmailAndOnboard({
    required String email,
    required String password,
    required OnboardingInput input,
  }) async {
    final res = await ref
        .read(authRepositoryProvider)
        .signUp(email: email, password: password);
    final err = res.when(ok: (_) => null, err: (f) => f.message);
    if (err != null) return err;
    return _finishOnboarding(input);
  }

  Future<String?> signUpWithAppleAndOnboard(OnboardingInput input) async {
    final res = await ref.read(authRepositoryProvider).signInWithApple();
    final err = res.when(ok: (_) => null, err: (f) => 'Apple: ${f.message}');
    if (err != null) return err;
    return _finishOnboarding(input);
  }

  Future<String?> signUpWithGoogleAndOnboard(OnboardingInput input) async {
    final res = await ref.read(authRepositoryProvider).signInWithGoogle();
    final err = res.when(ok: (_) => null, err: (f) => 'Google: ${f.message}');
    if (err != null) return err;
    return _finishOnboarding(input);
  }

  Future<String?> _finishOnboarding(OnboardingInput input) async {
    final repo = ref.read(authRepositoryProvider);
    // Already onboarded (existing user signing in via the signup screen)? Skip.
    final existing = await repo.fetchProfile();
    final hasRole = existing.when(ok: (u) => u?.role != null, err: (_) => false);
    if (!hasRole) {
      final res = await repo.completeOnboarding(input);
      final err = res.when(ok: (_) => null, err: (f) => f.message);
      if (err != null) return err;
    }
    ref.invalidateSelf();
    return null;
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

  /// Permanently deletes the account. Returns null on success (state becomes
  /// signed-out and the router redirects to /welcome), or an error message.
  Future<String?> deleteAccount() async {
    final res = await ref.read(authRepositoryProvider).deleteAccount();
    return res.when(
      ok: (_) {
        state = const AsyncData(null);
        return null;
      },
      err: (f) => f.message,
    );
  }
}
