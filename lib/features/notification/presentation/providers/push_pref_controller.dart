import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/core/notifications/fcm.dart';
import 'package:orbit/core/theme/theme_controller.dart' show sharedPreferencesProvider;
import 'package:orbit/features/notification/presentation/providers/notification_providers.dart';

part 'push_pref_controller.g.dart';

/// Last FCM registration status, for on-screen diagnostics (temporary).
@riverpod
class FcmDebug extends _$FcmDebug {
  @override
  String build() => 'idle';
  void set(String value) => state = value;
}

/// The user's push-notification on/off state, persisted in shared_preferences
/// so the profile screen renders the toggle instantly (synchronous read — no
/// async OS query, no flicker). Backed by the real OS permission via
/// permission_handler + the backend token registration.
@Riverpod(keepAlive: true)
class PushPrefController extends _$PushPrefController {
  static const _key = 'push_enabled';

  @override
  bool build() => ref.read(sharedPreferencesProvider).getBool(_key) ?? false;

  Future<void> _persist(bool value) async {
    state = value;
    await ref.read(sharedPreferencesProvider).setBool(_key, value);
  }

  Future<void> _register() async {
    final status =
        await registerFcmToken(ref.read(notificationRepositoryProvider));
    ref.read(fcmDebugProvider.notifier).set(status);
  }

  /// Called naturally right after onboarding (and on later launches): asks for
  /// permission if undecided, registers the token when granted, and records the
  /// state. iOS only prompts the first time.
  Future<void> ensureRegistered() async {
    final status = await Permission.notification.request();
    final granted = status.isGranted || status.isProvisional;
    if (granted) await _register();
    await _persist(granted);
  }

  /// Reconciles the stored toggle + token registration with the ACTUAL OS
  /// permission — call on launch, when the profile appears, and on app resume
  /// (e.g. after the user flips it in Settings). The OS is the source of truth.
  Future<void> syncFromSystem() async {
    final status = await Permission.notification.status;
    final granted = status.isGranted || status.isProvisional;
    if (granted) {
      await _register();
    } else {
      await unregisterFcmToken(ref.read(notificationRepositoryProvider));
    }
    await _persist(granted);
  }

  /// The profile row was tapped. On iOS the OS owns the notification switch —
  /// the app cannot turn it on/off. So: if the permission hasn't been decided
  /// yet, show the system prompt once; otherwise open the OS Settings page,
  /// which is the only place the user can actually change it. The toggle then
  /// reconciles via [syncFromSystem] when the app resumes.
  Future<void> promptOrOpenSettings() async {
    final status = await Permission.notification.status;
    // Already decided (granted / permanently denied / restricted / limited):
    // only Settings can change it.
    if (status.isGranted ||
        status.isProvisional ||
        status.isLimited ||
        status.isRestricted ||
        status.isPermanentlyDenied) {
      await openAppSettings();
      return;
    }
    // Undecided → ask once.
    final result = await Permission.notification.request();
    final granted = result.isGranted || result.isProvisional;
    if (granted) {
      await _register();
      await _persist(true);
    } else if (result.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
}
