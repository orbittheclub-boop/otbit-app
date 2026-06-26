import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

enum Role { company, influencer }

/// Domain user. `role == null` means the account exists but onboarding (role
/// selection) is not finished yet.
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    Role? role,
    String? displayName,
    String? avatarUrl,
    String? phone,
    @Default(false) bool onboarded,
  }) = _AppUser;
}
