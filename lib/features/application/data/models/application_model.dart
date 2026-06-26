import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:orbit/features/application/domain/entities/application.dart';

part 'application_model.freezed.dart';
part 'application_model.g.dart';

/// DTO for an applications row. Joined relations arrive as raw maps and are
/// flattened in [toEntity], avoiding a tree of nested DTO classes.
@freezed
abstract class ApplicationModel with _$ApplicationModel {
  const ApplicationModel._();

  const factory ApplicationModel({
    required String id,
    @JsonKey(name: 'campaign_id') required String campaignId,
    @JsonKey(name: 'influencer_id') required String influencerId,
    @Default('pending') String status,
    String? message,
    @JsonKey(name: 'applied_at') String? appliedAt,
    Map<String, dynamic>? campaign,
    Map<String, dynamic>? influencer,
  }) = _ApplicationModel;

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      _$ApplicationModelFromJson(json);

  Application toEntity() {
    final company = campaign?['company'] as Map<String, dynamic>?;
    final profile = influencer?['profile'] as Map<String, dynamic>?;
    final rawTiktok = influencer?['tiktok'];
    final tiktok = rawTiktok is List && rawTiktok.isNotEmpty
        ? rawTiktok.first as Map<String, dynamic>
        : (rawTiktok is Map<String, dynamic> ? rawTiktok : null);

    return Application(
      id: id,
      campaignId: campaignId,
      influencerId: influencerId,
      status: ApplicationStatus.fromString(status),
      message: message,
      appliedAt: appliedAt == null ? null : DateTime.tryParse(appliedAt!),
      campaignTitle: campaign?['title'] as String?,
      campaignThumbnail: campaign?['thumbnail_url'] as String?,
      companyName: company?['company_name'] as String?,
      influencerName:
          (influencer?['nickname'] ?? profile?['display_name']) as String?,
      influencerAvatar: profile?['avatar_url'] as String?,
      tiktokUsername: tiktok?['username'] as String?,
      followerCount: tiktok?['follower_count'] as int?,
    );
  }
}
