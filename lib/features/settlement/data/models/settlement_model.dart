import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:orbit/features/settlement/domain/entities/settlement.dart';

part 'settlement_model.freezed.dart';
part 'settlement_model.g.dart';

@freezed
abstract class SettlementModel with _$SettlementModel {
  const SettlementModel._();

  const factory SettlementModel({
    required String id,
    @JsonKey(name: 'application_id') required String applicationId,
    @Default(0) int amount,
    @Default('pending') String status,
    String? method,
    @JsonKey(name: 'paid_at') String? paidAt,
    Map<String, dynamic>? application,
  }) = _SettlementModel;

  factory SettlementModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementModelFromJson(json);

  Settlement toEntity() {
    final app = application;
    final campaign = app?['campaign'] as Map<String, dynamic>?;
    final company = campaign?['company'] as Map<String, dynamic>?;
    final influencer = app?['influencer'] as Map<String, dynamic>?;
    return Settlement(
      id: id,
      applicationId: applicationId,
      amount: amount,
      status: SettlementStatus.fromString(status),
      method: method,
      paidAt: paidAt == null ? null : DateTime.tryParse(paidAt!),
      campaignTitle: campaign?['title'] as String?,
      companyName: company?['company_name'] as String?,
      influencerName: influencer?['nickname'] as String?,
    );
  }
}
