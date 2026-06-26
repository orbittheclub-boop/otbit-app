import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:orbit/features/auth/domain/entities/app_user.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

/// DTO mirroring a `profiles` row from the Edge Function envelope.
@freezed
abstract class ProfileModel with _$ProfileModel {
  const ProfileModel._();

  const factory ProfileModel({
    required String id,
    required String email,
    String? role,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? phone,
    @Default(false) bool onboarded,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  AppUser toEntity() => AppUser(
        id: id,
        email: email,
        role: switch (role) {
          'company' => Role.company,
          'influencer' => Role.influencer,
          _ => null,
        },
        displayName: displayName,
        avatarUrl: avatarUrl,
        phone: phone,
        onboarded: onboarded,
      );
}
