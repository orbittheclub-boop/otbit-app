import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/settlement/domain/entities/settlement.dart';

abstract interface class SettlementRepository {
  Future<Result<void>> create(
    String applicationId, {
    required int amount,
    bool paid,
  });
  Future<Result<void>> markPaid(String id);
  Future<Result<List<Settlement>>> mine();
  Future<Result<List<Settlement>>> ofCampaign(String campaignId);
}
