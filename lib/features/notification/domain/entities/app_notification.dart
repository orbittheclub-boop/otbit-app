import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';

@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String type,
    String? title,
    String? body,
    DateTime? readAt,
    DateTime? createdAt,
  }) = _AppNotification;
}
