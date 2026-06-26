import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:orbit/features/notification/domain/repositories/notification_repository.dart';

/// Requests notification permission, grabs the FCM token, and registers it with
/// the backend (profiles.fcm_tokens) so a specific user can be pushed later.
/// Also keeps the token fresh via onTokenRefresh.
///
/// On iOS the token only resolves once an APNs key is configured in Firebase;
/// until then getToken throws and we silently skip (Android works immediately).
Future<void> registerFcmToken(NotificationRepository repo) async {
  try {
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();

    final platform = Platform.isIOS ? 'ios' : 'android';

    final token = await messaging.getToken();
    if (token != null) {
      await repo.registerDevice(token, platform: platform);
    }

    messaging.onTokenRefresh.listen((t) {
      repo.registerDevice(t, platform: platform);
    });
  } catch (_) {
    // iOS without an APNs key yet ("apns-token-not-set"), or transient — ignore.
  }
}
