import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/core/notifications/fcm.dart';
import 'package:orbit/core/theme/theme_controller.dart' show sharedPreferencesProvider;
import 'package:orbit/features/notification/presentation/providers/notification_providers.dart';

part 'push_pref_controller.g.dart';

/// Outcome of toggling the push preference, so the UI can react (e.g. show a
/// "turn it on in Settings" dialog when iOS has permanently denied it).
enum PushToggleResult { on, off, blocked }

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
    await registerFcmToken(ref.read(notificationRepositoryProvider));
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

  /// Reconciles the stored toggle with the actual OS permission — call when the
  /// profile appears or the app resumes (e.g. after returning from Settings).
  Future<void> syncFromSystem() async {
    final status = await Permission.notification.status;
    final granted = status.isGranted || status.isProvisional;
    if (granted != state) {
      if (granted) await _register();
      await _persist(granted);
    }
  }

  /// Profile toggle. On → request permission + register. Off → unregister the
  /// token so pushes stop. Returns [PushToggleResult.blocked] when iOS has
  /// permanently denied the permission (the UI then offers to open Settings).
  Future<PushToggleResult> setEnabled(bool enabled) async {
    if (!enabled) {
      await _persist(false);
      await unregisterFcmToken(ref.read(notificationRepositoryProvider));
      return PushToggleResult.off;
    }

    var status = await Permission.notification.status;
    if (status.isDenied) {
      status = await Permission.notification.request();
    }
    if (status.isPermanentlyDenied || status.isRestricted) {
      return PushToggleResult.blocked; // iOS won't re-prompt — needs Settings
    }
    final granted = status.isGranted || status.isProvisional;
    if (granted) await _register();
    await _persist(granted);
    return granted ? PushToggleResult.on : PushToggleResult.off;
  }

  /// Opens the OS settings page so the user can flip the permission manually.
  Future<void> openSettings() => openAppSettings();
}
