// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettlementModel _$SettlementModelFromJson(Map<String, dynamic> json) =>
    _SettlementModel(
      id: json['id'] as String,
      applicationId: json['application_id'] as String,
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'pending',
      method: json['method'] as String?,
      paidAt: json['paid_at'] as String?,
      application: json['application'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SettlementModelToJson(_SettlementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'application_id': instance.applicationId,
      'amount': instance.amount,
      'status': instance.status,
      'method': instance.method,
      'paid_at': instance.paidAt,
      'application': instance.application,
    };
