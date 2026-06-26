import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/notification/presentation/providers/push_pref_controller.dart';

/// Profile toggle for push notifications. On iOS the OS owns the switch, so this
/// row mirrors the real permission and tapping it either asks once (first time)
/// or jumps to the OS Settings page — the only place it can actually be changed.
/// It re-syncs whenever the app resumes (e.g. after returning from Settings).
class PushNotificationTile extends HookConsumerWidget {
  const PushNotificationTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(pushPrefControllerProvider.notifier);
    final lifecycle = useAppLifecycleState();

    // Reconcile with the OS permission on first build and on every resume.
    useEffect(() {
      if (lifecycle == null || lifecycle == AppLifecycleState.resumed) {
        Future.microtask(notifier.syncFromSystem);
      }
      return null;
    }, [lifecycle]);

    final enabled = ref.watch(pushPrefControllerProvider);
    final debug = ref.watch(fcmDebugProvider);
    return SwitchListTile(
      secondary:
          const Icon(Icons.notifications_outlined, color: AppColors.primary),
      title: Text(context.l10n.pushNotifications),
      subtitle: Text('FCM: $debug',
          style: TextStyle(fontSize: 11, color: context.palette.textTertiary)),
      value: enabled,
      activeThumbColor: AppColors.primary,
      onChanged: (_) => notifier.promptOrOpenSettings(),
    );
  }
}
