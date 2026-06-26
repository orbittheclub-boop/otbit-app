import 'dart:typed_data';

import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/auth/domain/entities/app_user.dart';
import 'package:orbit/features/auth/domain/entities/onboarding_input.dart';

/// Auth boundary. Implemented over Supabase today; swap the impl for AWS Cognito
/// later without touching anything above this interface.
abstract interface class AuthRepository {
  bool get isAuthenticated;

  Future<Result<void>> signUp({required String email, required String password});
  Future<Result<void>> signIn({required String email, required String password});

  /// Native "Sign in with Apple" → Supabase signInWithIdToken.
  Future<Result<void>> signInWithApple();

  /// Native Google sign-in → Supabase signInWithIdToken.
  Future<Result<void>> signInWithGoogle();

  Future<Result<void>> signOut();

  /// Permanently deletes the account (auth user + all cascaded data) via
  /// DELETE /profile, then signs out locally.
  Future<Result<void>> deleteAccount();

  /// Loads the current profile via the `profile` Edge Function. Returns null
  /// when the account has not been onboarded yet.
  Future<Result<AppUser?>> fetchProfile();

  Future<Result<AppUser>> completeOnboarding(OnboardingInput input);

  /// Updates editable profile fields (display name, nickname/company name, …)
  /// via PATCH /profile and returns the refreshed user.
  Future<Result<AppUser>> updateProfile(Map<String, dynamic> patch);

  /// Uploads a new avatar image (raw bytes) to the `avatar` Edge Function,
  /// which compresses it to WebP and stores it. Returns the public URL.
  Future<Result<String>> uploadAvatar({
    required Uint8List bytes,
    required String contentType,
  });
}
