import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:orbit/features/tiktok/domain/entities/tiktok_account.dart';

part 'tiktok_account_model.freezed.dart';
part 'tiktok_account_model.g.dart';

@freezed
abstract class TiktokAccountModel with _$TiktokAccountModel {
  const TiktokAccountModel._();

  const factory TiktokAccountModel({
    String? username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'follower_count') int? followerCount,
    @JsonKey(name: 'following_count') int? followingCount,
    @JsonKey(name: 'likes_count') int? likesCount,
    @JsonKey(name: 'video_count') int? videoCount,
    @JsonKey(name: 'verified_at') String? verifiedAt,
    @JsonKey(name: 'last_synced_at') String? lastSyncedAt,
  }) = _TiktokAccountModel;

  factory TiktokAccountModel.fromJson(Map<String, dynamic> json) =>
      _$TiktokAccountModelFromJson(json);

  TiktokAccount toEntity() => TiktokAccount(
        username: username,
        displayName: displayName,
        avatarUrl: avatarUrl,
        followerCount: followerCount,
        followingCount: followingCount,
        likesCount: likesCount,
        videoCount: videoCount,
        verifiedAt: verifiedAt == null ? null : DateTime.tryParse(verifiedAt!),
        lastSyncedAt:
            lastSyncedAt == null ? null : DateTime.tryParse(lastSyncedAt!),
      );
}
