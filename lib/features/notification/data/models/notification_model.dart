import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:orbit/features/notification/domain/entities/app_notification.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
abstract class NotificationModel with _$NotificationModel {
  const NotificationModel._();

  const factory NotificationModel({
    required String id,
    required String type,
    String? title,
    String? body,
    @JsonKey(name: 'read_at') String? readAt,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  AppNotification toEntity() => AppNotification(
        id: id,
        type: type,
        title: title,
        body: body,
        readAt: readAt == null ? null : DateTime.tryParse(readAt!),
        createdAt: createdAt == null ? null : DateTime.tryParse(createdAt!),
      );
}
