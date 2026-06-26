import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/widgets/app_toast.dart';
import 'package:orbit/features/auth/presentation/controllers/auth_controller.dart';

/// Account deletion entry (App Store 5.1.1(v)). Asks for confirmation, then
/// permanently deletes the account; on success the router redirects to /welcome.
class DeleteAccountTile extends ConsumerWidget {
  const DeleteAccountTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading:
          const Icon(Icons.person_remove_outlined, color: AppColors.danger),
      title: Text(
        context.l10n.deleteAccount,
        style: const TextStyle(color: AppColors.danger),
      ),
      onTap: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(context.l10n.deleteAccount),
            content: Text(context.l10n.deleteAccountWarning),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(context.l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: TextButton.styleFrom(foregroundColor: AppColors.danger),
                child: Text(context.l10n.withdraw),
              ),
            ],
          ),
        );
        if (confirmed != true || !context.mounted) return;

        final err =
            await ref.read(authControllerProvider.notifier).deleteAccount();
        if (err != null && context.mounted) {
          showAppToast(context, err, type: AppToastType.error);
        }
      },
    );
  }
}
