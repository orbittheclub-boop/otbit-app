import 'package:orbit/core/network/network_guard.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/application/data/datasources/application_api.dart';
import 'package:orbit/features/application/data/models/application_model.dart';
import 'package:orbit/features/application/domain/entities/application.dart';
import 'package:orbit/features/application/domain/repositories/application_repository.dart';

class ApplicationRepositoryImpl implements ApplicationRepository {
  ApplicationRepositoryImpl(this._api);

  final ApplicationApi _api;

  List<Application> _parseList(dynamic res) =>
      ((res['data']['applications']) as List)
          .cast<Map<String, dynamic>>()
          .map((j) => ApplicationModel.fromJson(j).toEntity())
          .toList();

  Application _parseOne(dynamic res) => ApplicationModel.fromJson(
        res['data']['application'] as Map<String, dynamic>,
      ).toEntity();

  @override
  Future<Result<Application>> apply(String campaignId, {String? message}) =>
      guard(() async => _parseOne(await _api.apply({
            'campaign_id': campaignId,
            'message': ?message,
          })));

  @override
  Future<Result<void>> cancel(String applicationId) =>
      guard(() => _api.cancel(applicationId));

  @override
  Future<Result<List<Application>>> myApplications() =>
      guard(() async => _parseList(await _api.list({'scope': 'mine'})));

  @override
  Future<Result<List<Application>>> applicantsOf(String campaignId) =>
      guard(() async =>
          _parseList(await _api.list({'campaign_id': campaignId})));

  @override
  Future<Result<Application>> decide(String id, {required bool accept}) =>
      guard(() async => _parseOne(
            await _api.decide(id, {'decision': accept ? 'accept' : 'reject'}),
          ));

  @override
  Future<Result<void>> submitContent(
    String id, {
    required String contentUrl,
    String? screenshotUrl,
    String? note,
  }) =>
      guard(() async {
        await _api.submit(id, {
          'content_url': contentUrl,
          'screenshot_url': ?screenshotUrl,
          'note': ?note,
        });
      });
}
