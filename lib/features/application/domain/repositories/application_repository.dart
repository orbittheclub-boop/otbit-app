import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/application/domain/entities/application.dart';

abstract interface class ApplicationRepository {
  Future<Result<Application>> apply(String campaignId, {String? message});

  /// Withdraws a still-pending application.
  Future<Result<void>> cancel(String applicationId);

  Future<Result<List<Application>>> myApplications();
  Future<Result<List<Application>>> applicantsOf(String campaignId);
  Future<Result<Application>> decide(String id, {required bool accept});
  Future<Result<void>> submitContent(
    String id, {
    required String contentUrl,
    String? screenshotUrl,
    String? note,
  });
}
