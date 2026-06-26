import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbit/features/home/presentation/widgets/dark_mode_tile.dart';
import 'package:orbit/features/home/presentation/widgets/language_tile.dart';
import 'package:orbit/features/home/presentation/widgets/profile_header.dart';
import 'package:orbit/features/home/presentation/widgets/push_notification_tile.dart';

class CompanyProfileScreen extends ConsumerWidget {
  const CompanyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;
    // While signing out the user becomes null; render a blank frame (no content
    // reshuffle) until the router redirects to /login.
    if (user == null) return const Scaffold();
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.navProfile)),
      body: ListView(
        children: [
          ProfileHeader(
            name: user.displayName ?? '회사',
            subtitle: user.email,
            icon: Icons.business_rounded,
            avatarUrl: user.avatarUrl,
            role: user.role,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.edit_rounded, color: AppColors.primary),
            title: Text(context.l10n.editProfile),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push('/profile/edit'),
          ),
          const Divider(height: 1),
          const LanguageTile(),
          const Divider(height: 1),
          const DarkModeTile(),
          const Divider(height: 1),
          const PushNotificationTile(),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: AppColors.danger),
            title: Text(context.l10n.logout,
                style: const TextStyle(color: AppColors.danger)),
            onTap: () => ref.read(authControllerProvider.notifier).signOut(),
          ),
        ],
      ),
    );
  }
}
