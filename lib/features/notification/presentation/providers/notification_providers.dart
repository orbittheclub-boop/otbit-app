import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/core/providers/app_providers.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/notification/data/datasources/notification_api.dart';
import 'package:orbit/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:orbit/features/notification/domain/repositories/notification_repository.dart';

part 'notification_providers.g.dart';

@Riverpod(keepAlive: true)
NotificationApi notificationApi(Ref ref) =>
    NotificationApi(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) =>
    NotificationRepositoryImpl(ref.watch(notificationApiProvider));

@riverpod
Future<NotificationFeed> notifications(Ref ref) async =>
    unwrap(await ref.watch(notificationRepositoryProvider).list());
