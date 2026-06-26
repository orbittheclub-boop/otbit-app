import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/notification/presentation/providers/push_pref_controller.dart';

/// Profile toggle for push notifications. Reads the persisted preference
/// synchronously (instant render) and reconciles it with the real OS
/// permission when shown — so it reflects changes made in Settings.
class PushNotificationTile extends HookConsumerWidget {
  const PushNotificationTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.microtask(
        () => ref.read(pushPrefControllerProvider.notifier).syncFromSystem(),
      );
      return null;
    }, const []);

    final enabled = ref.watch(pushPrefControllerProvider);
    return SwitchListTile(
      secondary:
          const Icon(Icons.notifications_outlined, color: AppColors.primary),
      title: Text(context.l10n.pushNotifications),
      value: enabled,
      activeThumbColor: AppColors.primary,
      onChanged: (v) async {
        final notifier = ref.read(pushPrefControllerProvider.notifier);
        final result = await notifier.setEnabled(v);
        if (result != PushToggleResult.blocked || !context.mounted) return;
        // iOS permanently denied — explain and offer to open Settings.
        final go = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(context.l10n.pushNotifications),
            content: Text(context.l10n.pushBlockedMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(context.l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(context.l10n.openSettings),
              ),
            ],
          ),
        );
        if (go == true) await notifier.openSettings();
      },
    );
  }
}
