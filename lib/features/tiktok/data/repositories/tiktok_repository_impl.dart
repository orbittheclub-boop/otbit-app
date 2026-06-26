import 'package:orbit/core/network/network_guard.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/tiktok/data/datasources/tiktok_api.dart';
import 'package:orbit/features/tiktok/data/models/tiktok_account_model.dart';
import 'package:orbit/features/tiktok/domain/entities/tiktok_account.dart';
import 'package:orbit/features/tiktok/domain/repositories/tiktok_repository.dart';

class TiktokRepositoryImpl implements TiktokRepository {
  TiktokRepositoryImpl(this._api);

  final TiktokApi _api;

  TiktokAccount? _parse(dynamic res) {
    final t = res['data']['tiktok'];
    return t == null
        ? null
        : TiktokAccountModel.fromJson(t as Map<String, dynamic>).toEntity();
  }

  @override
  Future<Result<TiktokAccount?>> getAccount() =>
      guard(() async => _parse(await _api.getAccount()));

  @override
  Future<Result<String>> authorizeUrl() => guard(() async {
        final res = await _api.authorizeUrl();
        return res['data']['url'] as String;
      });

  @override
  Future<Result<TiktokAccount>> linkWithCode(String code) =>
      guard(() async => _parse(await _api.callback({'code': code}))!);

  @override
  Future<Result<TiktokAccount>> refreshStats() =>
      guard(() async => _parse(await _api.refreshStats())!);

  @override
  Future<Result<void>> unlink() => guard(() => _api.unlink());
}
