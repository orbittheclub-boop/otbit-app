import 'package:orbit/core/usecase/usecase.dart';

abstract interface class ReviewRepository {
  Future<Result<void>> create(
    String applicationId, {
    required int rating,
    String? comment,
  });
}
