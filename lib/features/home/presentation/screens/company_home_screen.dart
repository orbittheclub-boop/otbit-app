import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/campaign/presentation/providers/campaign_providers.dart';
import 'package:orbit/features/campaign/presentation/widgets/campaign_card.dart';
import 'package:orbit/features/home/presentation/widgets/app_drawer.dart';

/// Company landing: list of the company's own campaigns + create FAB.
class CompanyHomeScreen extends ConsumerWidget {
  const CompanyHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(myCampaignsProvider);
    return Scaffold(
      // The create-campaign FAB lives on the shell (so it floats above the
      // glass nav bar); no per-screen FAB here to avoid a duplicate.
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('내 캠페인')),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async => ref.invalidate(myCampaignsProvider),
        child: async.when(
          loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary)),
          error: (e, _) => _Error(
            message: '$e',
            onRetry: () => ref.invalidate(myCampaignsProvider),
          ),
          data: (list) => list.isEmpty
              ? const _Empty(
                  icon: Icons.campaign_outlined,
                  text: '아직 등록한 캠페인이 없어요.\n첫 캠페인을 만들어보세요!',
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  itemCount: list.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 14),
                  itemBuilder: (_, i) => CampaignCard(
                    campaign: list[i],
                    showStatus: true,
                    onTap: () => context.push('/campaign/${list[i].id}'),
                  )
                      .animate(delay: (i * 50).ms)
                      .fadeIn(duration: 320.ms)
                      .moveY(begin: 14, end: 0, curve: Curves.easeOut),
                ),
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => ListView(
        children: [
          const SizedBox(height: 140),
          Icon(icon, size: 52, color: context.palette.textTertiary),
          const SizedBox(height: 16),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: context.palette.textSecondary, height: 1.5),
          ),
        ],
      );
}

class _Error extends StatelessWidget {
  const _Error({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) => ListView(
        children: [
          const SizedBox(height: 160),
          Text(message,
              textAlign: TextAlign.center,
              style: TextStyle(color: context.palette.textSecondary)),
          const SizedBox(height: 12),
          Center(
              child: TextButton(onPressed: onRetry, child: const Text('다시 시도'))),
        ],
      );
}
