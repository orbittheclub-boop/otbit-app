// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompanyBrief _$CompanyBriefFromJson(Map<String, dynamic> json) =>
    _CompanyBrief(
      companyName: json['company_name'] as String?,
      verified: json['verified'] as bool? ?? false,
    );

Map<String, dynamic> _$CompanyBriefToJson(_CompanyBrief instance) =>
    <String, dynamic>{
      'company_name': instance.companyName,
      'verified': instance.verified,
    };

_CampaignModel _$CampaignModelFromJson(Map<String, dynamic> json) =>
    _CampaignModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      category: json['category'] as String?,
      type: json['type'] as String? ?? 'delivery',
      rewardType: json['reward_type'] as String?,
      rewardAmount: (json['reward_amount'] as num?)?.toInt(),
      recruitCount: (json['recruit_count'] as num?)?.toInt() ?? 1,
      contentGuide: json['content_guide'] as String?,
      minFollowers: (json['min_followers'] as num?)?.toInt() ?? 0,
      thumbnailUrl: json['thumbnail_url'] as String?,
      applyDeadline: json['apply_deadline'] as String?,
      status: json['status'] as String? ?? 'draft',
      createdAt: json['created_at'] as String?,
      bookmarked: json['bookmarked'] as bool? ?? false,
      applicantCount: (json['applicant_count'] as num?)?.toInt(),
      applied: json['applied'] as bool? ?? false,
      applicationId: json['application_id'] as String?,
      applicationStatus: json['application_status'] as String?,
      company: json['company'] == null
          ? null
          : CompanyBrief.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CampaignModelToJson(_CampaignModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.companyId,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'type': instance.type,
      'reward_type': instance.rewardType,
      'reward_amount': instance.rewardAmount,
      'recruit_count': instance.recruitCount,
      'content_guide': instance.contentGuide,
      'min_followers': instance.minFollowers,
      'thumbnail_url': instance.thumbnailUrl,
      'apply_deadline': instance.applyDeadline,
      'status': instance.status,
      'created_at': instance.createdAt,
      'bookmarked': instance.bookmarked,
      'applicant_count': instance.applicantCount,
      'applied': instance.applied,
      'application_id': instance.applicationId,
      'application_status': instance.applicationStatus,
      'company': instance.company,
    };
