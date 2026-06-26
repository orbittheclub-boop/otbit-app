// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tiktok_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TiktokAccountModel _$TiktokAccountModelFromJson(Map<String, dynamic> json) =>
    _TiktokAccountModel(
      username: json['username'] as String?,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      followerCount: (json['follower_count'] as num?)?.toInt(),
      followingCount: (json['following_count'] as num?)?.toInt(),
      likesCount: (json['likes_count'] as num?)?.toInt(),
      videoCount: (json['video_count'] as num?)?.toInt(),
      verifiedAt: json['verified_at'] as String?,
      lastSyncedAt: json['last_synced_at'] as String?,
    );

Map<String, dynamic> _$TiktokAccountModelToJson(_TiktokAccountModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'display_name': instance.displayName,
      'avatar_url': instance.avatarUrl,
      'follower_count': instance.followerCount,
      'following_count': instance.followingCount,
      'likes_count': instance.likesCount,
      'video_count': instance.videoCount,
      'verified_at': instance.verifiedAt,
      'last_synced_at': instance.lastSyncedAt,
    };
