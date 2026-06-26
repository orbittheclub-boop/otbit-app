import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:orbit/features/campaign/domain/entities/campaign.dart';

part 'campaign_model.freezed.dart';
part 'campaign_model.g.dart';

@freezed
abstract class CompanyBrief with _$CompanyBrief {
  const factory CompanyBrief({
    @JsonKey(name: 'company_name') String? companyName,
    @Default(false) bool verified,
  }) = _CompanyBrief;

  factory CompanyBrief.fromJson(Map<String, dynamic> json) =>
      _$CompanyBriefFromJson(json);
}

@freezed
abstract class CampaignModel with _$CampaignModel {
  const CampaignModel._();

  const factory CampaignModel({
    required String id,
    @JsonKey(name: 'company_id') required String companyId,
    required String title,
    String? description,
    String? category,
    @Default('delivery') String type,
    @JsonKey(name: 'reward_type') String? rewardType,
    @JsonKey(name: 'reward_amount') int? rewardAmount,
    @JsonKey(name: 'recruit_count') @Default(1) int recruitCount,
    @JsonKey(name: 'content_guide') String? contentGuide,
    @JsonKey(name: 'min_followers') @Default(0) int minFollowers,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    @JsonKey(name: 'apply_deadline') String? applyDeadline,
    @Default('draft') String status,
    @JsonKey(name: 'created_at') String? createdAt,
    @Default(false) bool bookmarked,
    @JsonKey(name: 'applicant_count') int? applicantCount,
    @Default(false) bool applied,
    @JsonKey(name: 'application_id') String? applicationId,
    @JsonKey(name: 'application_status') String? applicationStatus,
    CompanyBrief? company,
  }) = _CampaignModel;

  factory CampaignModel.fromJson(Map<String, dynamic> json) =>
      _$CampaignModelFromJson(json);

  Campaign toEntity() => Campaign(
        id: id,
        companyId: companyId,
        title: title,
        description: description,
        category: category,
        type: CampaignType.fromString(type),
        rewardType: rewardType,
        rewardAmount: rewardAmount,
        recruitCount: recruitCount,
        contentGuide: contentGuide,
        minFollowers: minFollowers,
        thumbnailUrl: thumbnailUrl,
        applyDeadline:
            applyDeadline == null ? null : DateTime.tryParse(applyDeadline!),
        status: CampaignStatus.fromString(status),
        createdAt: createdAt == null ? null : DateTime.tryParse(createdAt!),
        companyName: company?.companyName,
        verified: company?.verified ?? false,
        bookmarked: bookmarked,
        applicantCount: applicantCount,
        applied: applied,
        applicationId: applicationId,
        applicationStatus: applicationStatus,
      );
}
