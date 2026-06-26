import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/notification/domain/entities/app_notification.dart';

typedef NotificationFeed = ({List<AppNotification> items, int unread});

abstract interface class NotificationRepository {
  Future<Result<NotificationFeed>> list();
  Future<Result<void>> markRead({String? id});
  Future<Result<void>> registerDevice(String fcmToken, {String? platform});
  Future<Result<void>> unregisterDevice(String fcmToken);
}
