import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/core/notifications/fcm.dart';
import 'package:orbit/core/theme/theme_controller.dart' show sharedPreferencesProvider;
import 'package:orbit/features/notification/presentation/providers/notification_providers.dart';

part 'push_pref_controller.g.dart';

/// The user's push-notification on/off state, persisted in shared_preferences
/// so the profile screen renders the toggle instantly (synchronous read — no
/// async OS query, no flicker). Kept in sync with the real OS permission and
/// the backend token registration.
@Riverpod(keepAlive: true)
class PushPrefController extends _$PushPrefController {
  static const _key = 'push_enabled';

  @override
  bool build() => ref.read(sharedPreferencesProvider).getBool(_key) ?? false;

  Future<void> _persist(bool value) async {
    state = value;
    await ref.read(sharedPreferencesProvider).setBool(_key, value);
  }

  /// Asks for permission if undecided, registers the token when authorized, and
  /// records the resulting state. Called naturally right after onboarding (when
  /// the user first lands in the app) and silently on later launches (iOS won't
  /// re-prompt once the permission is decided).
  Future<void> ensureRegistered() async {
    final granted =
        await registerFcmToken(ref.read(notificationRepositoryProvider));
    await _persist(granted);
  }

  /// Profile toggle. On → request permission + register the token; Off →
  /// unregister the token server-side so pushes stop.
  Future<void> setEnabled(bool enabled) async {
    if (enabled) {
      await ensureRegistered();
    } else {
      await _persist(false);
      await unregisterFcmToken(ref.read(notificationRepositoryProvider));
    }
  }
}
