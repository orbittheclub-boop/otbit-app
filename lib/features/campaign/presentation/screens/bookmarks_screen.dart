import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/widgets/app_toast.dart';
import 'package:orbit/features/campaign/presentation/providers/campaign_providers.dart';
import 'package:orbit/features/campaign/presentation/widgets/campaign_card.dart';

/// The influencer's bookmarked (찜) campaigns.
class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(bookmarkedCampaignsProvider);
    final overrides = ref.watch(bookmarkOverridesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.myBookmarks)),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async => ref.invalidate(bookmarkedCampaignsProvider),
        child: async.when(
          loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary)),
          error: (e, _) => ListView(children: [
            const SizedBox(height: 160),
            Text('$e',
                textAlign: TextAlign.center,
                style: TextStyle(color: context.palette.textSecondary)),
          ]),
          data: (list) => list.isEmpty
              ? ListView(children: [
                  const SizedBox(height: 130),
                  Icon(Icons.bookmark_border_rounded,
                      size: 52, color: context.palette.textTertiary),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.bookmarksEmpty,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: context.palette.textSecondary, height: 1.5),
                  ),
                ])
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  itemCount: list.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (_, i) {
                    final c = list[i];
                    return CampaignCard(
                      campaign: c.copyWith(
                          bookmarked: overrides[c.id] ?? c.bookmarked),
                      onBookmark: () async {
                        final ok = await toggleCampaignBookmark(ref, c);
                        if (!ok && context.mounted) {
                          showAppToast(context, '잠시 후 다시 시도해주세요',
                              type: AppToastType.error);
                        }
                      },
                      onTap: () => context.push('/campaign/${c.id}'),
                    )
                        .animate(delay: (i * 50).ms)
                        .fadeIn(duration: 300.ms)
                        .moveY(begin: 12, end: 0, curve: Curves.easeOut);
                  },
                ),
        ),
      ),
    );
  }
}
