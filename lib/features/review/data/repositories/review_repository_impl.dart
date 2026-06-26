import 'package:orbit/core/network/network_guard.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/review/data/datasources/review_api.dart';
import 'package:orbit/features/review/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  ReviewRepositoryImpl(this._api);

  final ReviewApi _api;

  @override
  Future<Result<void>> create(
    String applicationId, {
    required int rating,
    String? comment,
  }) =>
      guard(() async {
        await _api.create({
          'application_id': applicationId,
          'rating': rating,
          'comment': ?comment,
        });
      });
}
