import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/notification/presentation/providers/push_pref_controller.dart';

/// Profile toggle for push notifications. Reads the persisted preference
/// synchronously so it renders instantly with the correct state.
class PushNotificationTile extends ConsumerWidget {
  const PushNotificationTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(pushPrefControllerProvider);
    return SwitchListTile(
      secondary:
          const Icon(Icons.notifications_outlined, color: AppColors.primary),
      title: Text(context.l10n.pushNotifications),
      value: enabled,
      activeThumbColor: AppColors.primary,
      onChanged: (v) =>
          ref.read(pushPrefControllerProvider.notifier).setEnabled(v),
    );
  }
}
