import 'package:orbit/core/network/network_guard.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/notification/data/datasources/notification_api.dart';
import 'package:orbit/features/notification/data/models/notification_model.dart';
import 'package:orbit/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl(this._api);

  final NotificationApi _api;

  @override
  Future<Result<NotificationFeed>> list() => guard(() async {
        final res = await _api.list();
        final items = ((res['data']['notifications']) as List)
            .cast<Map<String, dynamic>>()
            .map((j) => NotificationModel.fromJson(j).toEntity())
            .toList();
        final unread = (res['data']['unread'] as int?) ?? 0;
        return (items: items, unread: unread);
      });

  @override
  Future<Result<void>> markRead({String? id}) =>
      guard(() => _api.markRead({'id': ?id}));

  @override
  Future<Result<void>> registerDevice(String fcmToken, {String? platform}) =>
      guard(() => _api.registerDevice({
            'fcm_token': fcmToken,
            'platform': ?platform,
          }));
}
