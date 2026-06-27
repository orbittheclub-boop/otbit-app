import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/auth/domain/entities/app_user.dart';
import 'package:orbit/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbit/features/home/presentation/widgets/dark_mode_tile.dart';
import 'package:orbit/features/home/presentation/widgets/language_tile.dart';
import 'package:orbit/features/home/presentation/widgets/role_badge.dart';

/// Role-aware side drawer (hamburger menu) for both company and influencer:
/// profile editing, language, theme, sign-out — plus bookmarks/TikTok for
/// influencers.
class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;
    final isInfluencer = user?.role == Role.influencer;

    void go(String path) {
      Navigator.of(context).pop(); // close the drawer first
      context.push(path);
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _DrawerHeader(
            name: user?.displayName ??
                (isInfluencer
                    ? context.l10n.accountTypeInfluencer
                    : context.l10n.accountTypeCompany),
            email: user?.email ?? '',
            avatarUrl: user?.avatarUrl,
            role: user?.role,
          ),
          ListTile(
            leading: const Icon(Icons.edit_rounded, color: AppColors.primary),
            title: Text(context.l10n.editProfile),
            onTap: () => go('/profile/edit'),
          ),
          if (isInfluencer) ...[
            ListTile(
              leading:
                  const Icon(Icons.bookmark_rounded, color: AppColors.primary),
              title: Text(context.l10n.myBookmarks),
              onTap: () => go('/campaign/bookmarks'),
            ),
            ListTile(
              leading: const Icon(Icons.music_note_rounded,
                  color: AppColors.primary),
              title: Text(context.l10n.tiktokConnect),
              subtitle: Text(context.l10n.tiktokConnectDesc),
              onTap: () => go('/tiktok-link'),
            ),
          ],
          const Divider(height: 1),
          const LanguageTile(),
          const DarkModeTile(),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: AppColors.danger),
            title: Text(context.l10n.logout,
                style: const TextStyle(color: AppColors.danger)),
            onTap: () {
              Navigator.of(context).pop();
              ref.read(authControllerProvider.notifier).signOut();
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.role,
  });

  final String name;
  final String email;
  final String? avatarUrl;
  final Role? role;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.brandGradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white.withValues(alpha: 0.9),
                backgroundImage:
                    avatarUrl != null ? NetworkImage(avatarUrl!) : null,
                child: avatarUrl == null
                    ? const Icon(Icons.auto_awesome_rounded,
                        color: AppColors.primary, size: 30)
                    : null,
              ),
              const SizedBox(height: 14),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                email,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.onPrimary.withValues(alpha: 0.7),
                ),
              ),
              if (role != null) ...[
                const SizedBox(height: 12),
                RoleBadge(role: role!, onGradient: true),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
