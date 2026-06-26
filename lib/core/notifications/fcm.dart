import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:orbit/features/notification/domain/repositories/notification_repository.dart';

bool _refreshHooked = false;

/// Requests notification permission, grabs the FCM token, and registers it with
/// the backend (profiles.fcm_tokens) so a specific user can be pushed later.
/// Also keeps the token fresh via onTokenRefresh. Returns whether notifications
/// are authorized (so the caller can persist the on/off state).
///
/// On iOS the token only resolves once an APNs key is configured in Firebase;
/// until then getToken throws and we return the permission result anyway.
Future<bool> registerFcmToken(NotificationRepository repo) async {
  try {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    final granted =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
            settings.authorizationStatus == AuthorizationStatus.provisional;
    if (!granted) return false;

    final platform = Platform.isIOS ? 'ios' : 'android';

    // Hook refresh FIRST so a late-arriving token still registers even if the
    // getToken() below races the APNs token and throws.
    if (!_refreshHooked) {
      _refreshHooked = true;
      messaging.onTokenRefresh.listen((t) {
        repo.registerDevice(t, platform: platform);
      });
    }

    // On iOS the FCM token can't be minted until the APNs token has arrived;
    // calling getToken() too early throws "apns-token-not-set". Wait for it
    // (up to ~6s) so the very first launch after permission registers cleanly.
    if (Platform.isIOS) {
      for (var i = 0; i < 12; i++) {
        if (await messaging.getAPNSToken() != null) break;
        await Future<void>.delayed(const Duration(milliseconds: 500));
      }
    }

    final token = await messaging.getToken();
    if (token != null) {
      await repo.registerDevice(token, platform: platform);
    }
    return true;
  } catch (_) {
    // Transient — onTokenRefresh will still fire when the token resolves.
    return false;
  }
}

/// Removes this device's token server-side so it stops receiving pushes.
Future<void> unregisterFcmToken(NotificationRepository repo) async {
  try {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) await repo.unregisterDevice(token);
  } catch (_) {
    // No token / transient — nothing to remove.
  }
}
