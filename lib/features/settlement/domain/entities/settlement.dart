import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement.freezed.dart';

enum SettlementStatus {
  pending,
  processing,
  paid;

  static SettlementStatus fromString(String? s) => switch (s) {
        'processing' => SettlementStatus.processing,
        'paid' => SettlementStatus.paid,
        _ => SettlementStatus.pending,
      };
  // Localized label: see settlementStatusLabel() in core/l10n/enum_labels.dart.
}

@freezed
abstract class Settlement with _$Settlement {
  const factory Settlement({
    required String id,
    required String applicationId,
    @Default(0) int amount,
    @Default(SettlementStatus.pending) SettlementStatus status,
    String? method,
    DateTime? paidAt,
    String? campaignTitle,
    String? companyName,
    String? influencerName,
  }) = _Settlement;
}
