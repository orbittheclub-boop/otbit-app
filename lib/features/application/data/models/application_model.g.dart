// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApplicationModel _$ApplicationModelFromJson(Map<String, dynamic> json) =>
    _ApplicationModel(
      id: json['id'] as String,
      campaignId: json['campaign_id'] as String,
      influencerId: json['influencer_id'] as String,
      status: json['status'] as String? ?? 'pending',
      message: json['message'] as String?,
      appliedAt: json['applied_at'] as String?,
      campaign: json['campaign'] as Map<String, dynamic>?,
      influencer: json['influencer'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ApplicationModelToJson(_ApplicationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'campaign_id': instance.campaignId,
      'influencer_id': instance.influencerId,
      'status': instance.status,
      'message': instance.message,
      'applied_at': instance.appliedAt,
      'campaign': instance.campaign,
      'influencer': instance.influencer,
    };
