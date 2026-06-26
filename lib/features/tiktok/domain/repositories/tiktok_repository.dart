import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/tiktok/domain/entities/tiktok_account.dart';

abstract interface class TiktokRepository {
  Future<Result<TiktokAccount?>> getAccount();
  Future<Result<String>> authorizeUrl();
  Future<Result<TiktokAccount>> linkWithCode(String code);
  Future<Result<TiktokAccount>> refreshStats();
  Future<Result<void>> unlink();
}
