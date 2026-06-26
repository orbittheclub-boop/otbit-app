import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/providers/app_providers.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/auth/presentation/controllers/auth_controller.dart';

/// Read-only profile row showing how the user signed in (Email / Google /
/// Apple). Same email across providers is one linked account, so this can list
/// more than one. Reads the providers from the Supabase session metadata.
class LoginMethodTile extends ConsumerWidget {
  const LoginMethodTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authControllerProvider); // rebuild when the session changes
    final user = ref.read(supabaseClientProvider).auth.currentUser;
    final meta = user?.appMetadata ?? const {};
    final providers = <String>[
      ...?(meta['providers'] as List?)?.cast<String>(),
      if ((meta['providers'] == null) && meta['provider'] is String)
        meta['provider'] as String,
    ];
    if (providers.isEmpty) return const SizedBox.shrink();

    String label(String p) => switch (p) {
          'google' => 'Google',
          'apple' => 'Apple',
          'email' => context.l10n.email,
          _ => p.isEmpty ? p : '${p[0].toUpperCase()}${p.substring(1)}',
        };
    final value = providers.map(label).join(', ');

    return ListTile(
      leading: const Icon(Icons.verified_user_outlined, color: AppColors.primary),
      title: Text(context.l10n.loginMethod),
      trailing: Text(
        value,
        style: TextStyle(
          color: context.palette.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
