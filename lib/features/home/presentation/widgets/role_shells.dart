import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/notification/presentation/providers/notification_providers.dart';

class _NavItem {
  const _NavItem(this.icon, this.label, {this.badge = 0});
  final IconData icon;
  final String label;
  final int badge;
}

/// Frosted-glass bottom navigation (backdrop blur) with a neon glow on the
/// selected tab's icon only.
class _GlassNavBar extends StatelessWidget {
  const _GlassNavBar({
    required this.index,
    required this.onTap,
    required this.items,
  });

  final int index;
  final ValueChanged<int> onTap;
  final List<_NavItem> items;

  @override
  Widget build(BuildContext context) {
    // RepaintBoundary isolates the bar so a heavy previous route (e.g. the Quill
    // editor) can't leave a stale raster bleeding through the BackdropFilter.
    return RepaintBoundary(
      child: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          decoration: BoxDecoration(
            color: context.palette.background.withValues(alpha: 0.6),
            border: Border(
              top: BorderSide(
                color: context.palette.border.withValues(alpha: 0.7),
                width: 0.5,
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 60,
              child: Row(
                children: List.generate(items.length, (i) {
                  return Expanded(
                    child: _GlassNavButton(
                      item: items[i],
                      selected: i == index,
                      onTap: () => onTap(i),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}

class _GlassNavButton extends StatelessWidget {
  const _GlassNavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : context.palette.textTertiary;
    // Neon glow on the icon ONLY.
    final iconGlow = selected
        ? const [
            Shadow(color: AppColors.primary, blurRadius: 18),
            Shadow(color: AppColors.primary, blurRadius: 9),
          ]
        : null;

    Widget icon = Icon(item.icon, size: 25, color: color, shadows: iconGlow);
    if (item.badge > 0) {
      icon = Badge(label: Text('${item.badge}'), child: icon);
    }

    // GestureDetector (not InkWell): the glow IS the selection indicator, so we
    // don't want a material ripple — and a lingering ripple was leaving a pink
    // smear in the home-indicator area after returning from another route.
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 3),
          // One line always: scale the label down instead of wrapping (long
          // en/ja labels like "Applications"/"プロフィール" were breaking onto
          // two lines and shoving the layout).
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                item.label,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Company shell: 캠페인 / 알림 / 프로필.
class CompanyShell extends ConsumerWidget {
  const CompanyShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = ref.watch(notificationsProvider).value?.unread ?? 0;
    return Scaffold(
      extendBody: true,
      body: shell,
      // FAB lives on the shell (the Scaffold that owns the bottom nav) so
      // Flutter automatically floats it ABOVE the glass nav bar. Only shown on
      // the 캠페인 tab.
      floatingActionButton: shell.currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () => context.push('/campaign/new'),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              icon: const Icon(Icons.add_rounded),
              label: Text(context.l10n.newCampaign),
            )
          : null,
      bottomNavigationBar: _GlassNavBar(
        index: shell.currentIndex,
        onTap: (i) =>
            shell.goBranch(i, initialLocation: i == shell.currentIndex),
        items: [
          _NavItem(Icons.campaign_rounded, context.l10n.navCampaigns),
          _NavItem(Icons.forum_rounded, context.l10n.navBoard),
          _NavItem(Icons.notifications_rounded, context.l10n.navNotifications,
              badge: unread),
          _NavItem(Icons.person_rounded, context.l10n.navProfile),
        ],
      ),
    );
  }
}

/// Influencer shell: 둘러보기 / 내 지원 / 정산 / 알림 / 프로필.
class InfluencerShell extends ConsumerWidget {
  const InfluencerShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = ref.watch(notificationsProvider).value?.unread ?? 0;
    return Scaffold(
      extendBody: true,
      body: shell,
      bottomNavigationBar: _GlassNavBar(
        index: shell.currentIndex,
        onTap: (i) =>
            shell.goBranch(i, initialLocation: i == shell.currentIndex),
        items: [
          _NavItem(Icons.explore_rounded, context.l10n.navExplore),
          _NavItem(Icons.forum_rounded, context.l10n.navBoard),
          _NavItem(Icons.assignment_rounded, context.l10n.navMyApplications),
          _NavItem(
              Icons.account_balance_wallet_rounded, context.l10n.navSettlement),
          _NavItem(Icons.notifications_rounded, context.l10n.navNotifications,
              badge: unread),
          _NavItem(Icons.person_rounded, context.l10n.navProfile),
        ],
      ),
    );
  }
}
