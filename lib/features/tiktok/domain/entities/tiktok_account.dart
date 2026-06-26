import 'package:freezed_annotation/freezed_annotation.dart';

part 'tiktok_account.freezed.dart';

@freezed
abstract class TiktokAccount with _$TiktokAccount {
  const factory TiktokAccount({
    String? username,
    String? displayName,
    String? avatarUrl,
    int? followerCount,
    int? followingCount,
    int? likesCount,
    int? videoCount,
    DateTime? verifiedAt,
    DateTime? lastSyncedAt,
  }) = _TiktokAccount;
}
