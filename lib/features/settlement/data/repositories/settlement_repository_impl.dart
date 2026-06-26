import 'package:orbit/core/network/network_guard.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/settlement/data/datasources/settlement_api.dart';
import 'package:orbit/features/settlement/data/models/settlement_model.dart';
import 'package:orbit/features/settlement/domain/entities/settlement.dart';
import 'package:orbit/features/settlement/domain/repositories/settlement_repository.dart';

class SettlementRepositoryImpl implements SettlementRepository {
  SettlementRepositoryImpl(this._api);

  final SettlementApi _api;

  List<Settlement> _parseList(dynamic res) =>
      ((res['data']['settlements']) as List)
          .cast<Map<String, dynamic>>()
          .map((j) => SettlementModel.fromJson(j).toEntity())
          .toList();

  @override
  Future<Result<void>> create(
    String applicationId, {
    required int amount,
    bool paid = true,
  }) =>
      guard(() async {
        await _api.create({
          'application_id': applicationId,
          'amount': amount,
          'status': paid ? 'paid' : 'pending',
        });
      });

  @override
  Future<Result<void>> markPaid(String id) =>
      guard(() => _api.updateStatus(id, {'status': 'paid'}));

  @override
  Future<Result<List<Settlement>>> mine() =>
      guard(() async => _parseList(await _api.list({'scope': 'mine'})));

  @override
  Future<Result<List<Settlement>>> ofCampaign(String campaignId) =>
      guard(() async =>
          _parseList(await _api.list({'campaign_id': campaignId})));
}
