import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/core/widgets/app_toast.dart';
import 'package:orbit/core/widgets/primary_button.dart';
import 'package:orbit/features/application/presentation/providers/application_providers.dart';
import 'package:orbit/features/auth/domain/entities/app_user.dart';
import 'package:orbit/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbit/features/campaign/domain/entities/campaign.dart';
import 'package:orbit/features/campaign/presentation/providers/campaign_providers.dart';

class CampaignDetailScreen extends ConsumerWidget {
  const CampaignDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(campaignDetailProvider(id));
    final user = ref.watch(authControllerProvider).value;
    final overrides = ref.watch(bookmarkOverridesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('캠페인 상세'),
        actions: [
          if (async.value != null)
            Builder(
              builder: (context) {
                final c = async.value!;
                final marked = overrides[c.id] ?? c.bookmarked;
                return IconButton(
                  tooltip: context.l10n.bookmark,
                  icon: Icon(
                    marked
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    color: marked ? AppColors.primary : null,
                  ),
                  onPressed: () async {
                    final ok = await toggleCampaignBookmark(ref, c);
                    if (!ok && context.mounted) {
                      showAppToast(context, '잠시 후 다시 시도해주세요',
                          type: AppToastType.error);
                    }
                  },
                );
              },
            ),
        ],
      ),
      body: async.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => _ErrorView(
          message: '$e',
          onRetry: () => ref.invalidate(campaignDetailProvider(id)),
        ),
        data: (c) => _Body(campaign: c, user: user),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.campaign, required this.user});

  final Campaign campaign;
  final AppUser? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOwner =
        user?.role == Role.company && user?.id == campaign.companyId;
    final deadline = campaign.applyDeadline;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              if (campaign.thumbnailUrl != null)
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: campaign.thumbnailUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _Tag(campaign.type.label),
                        const SizedBox(width: 6),
                        _Tag(campaign.status.label),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      campaign.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: context.palette.ink,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      campaign.companyName ?? '브랜드',
                      style: TextStyle(
                        fontSize: 14,
                        color: context.palette.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _InfoRow(
                      icon: Icons.card_giftcard_rounded,
                      label: '제공',
                      value: campaign.rewardType ??
                          (campaign.rewardAmount != null
                              ? '${campaign.rewardAmount}원'
                              : '-'),
                    ),
                    _InfoRow(
                      icon: Icons.people_alt_rounded,
                      label: '모집',
                      value: '${campaign.recruitCount}명',
                    ),
                    _InfoRow(
                      icon: Icons.favorite_rounded,
                      label: '최소 팔로워',
                      value: '${campaign.minFollowers}',
                    ),
                    if (deadline != null)
                      _InfoRow(
                        icon: Icons.schedule_rounded,
                        label: '마감',
                        value: DateFormat('yyyy.MM.dd').format(deadline),
                      ),
                    if (campaign.description != null) ...[
                      const SizedBox(height: 20),
                      const _SectionTitle('캠페인 소개'),
                      Text(
                        campaign.description!,
                        style: const TextStyle(height: 1.6, fontSize: 14),
                      ),
                    ],
                    if (campaign.contentGuide != null) ...[
                      const SizedBox(height: 20),
                      const _SectionTitle('콘텐츠 가이드'),
                      Text(
                        campaign.contentGuide!,
                        style: const TextStyle(height: 1.6, fontSize: 14),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        _ActionBar(campaign: campaign, isOwner: isOwner),
      ],
    );
  }
}

class _ActionBar extends ConsumerWidget {
  const _ActionBar({required this.campaign, required this.isOwner});

  final Campaign campaign;
  final bool isOwner;

  Future<void> _run(
    BuildContext context,
    WidgetRef ref,
    Future<Object?> Function() action,
  ) async {
    await action();
    ref.invalidate(campaignDetailProvider(campaign.id));
    ref.invalidate(myCampaignsProvider);
    ref.invalidate(campaignFeedProvider);
  }

  Future<void> _apply(BuildContext context, WidgetRef ref) async {
    final res = await ref.read(applicationRepositoryProvider).apply(campaign.id);
    if (!context.mounted) return;
    switch (res) {
      case Ok():
        ref.invalidate(campaignDetailProvider(campaign.id));
        ref.invalidate(myApplicationsProvider);
        showAppToast(context, '지원이 완료됐어요!');
      case Err(:final failure):
        final msg = failure.message == 'already_applied'
            ? '이미 지원한 캠페인이에요.'
            : failure.message;
        showAppToast(context, msg, type: AppToastType.error);
    }
  }

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    final appId = campaign.applicationId;
    if (appId == null) return;
    final res = await ref.read(applicationRepositoryProvider).cancel(appId);
    if (!context.mounted) return;
    switch (res) {
      case Ok():
        ref.invalidate(campaignDetailProvider(campaign.id));
        ref.invalidate(myApplicationsProvider);
        showAppToast(context, '지원을 취소했어요.');
      case Err(:final failure):
        showAppToast(context, failure.message, type: AppToastType.error);
    }
  }

  /// Apply / cancel / status button for influencers, based on whether they have
  /// already applied and the application's status.
  Widget _influencerAction(BuildContext context, WidgetRef ref) {
    if (!campaign.applied) {
      return PrimaryButton(
        label: '지원하기',
        onPressed: () => _apply(context, ref),
      );
    }
    if (campaign.applicationStatus == 'pending') {
      return SecondaryButton(
        label: '지원취소하기',
        onPressed: () => _cancel(context, ref),
      );
    }
    final label = switch (campaign.applicationStatus) {
      'accepted' => '선정됐어요 ✓',
      'submitted' => '제출 완료',
      'completed' => '완료',
      'rejected' => '미선정',
      _ => '지원 완료',
    };
    return PrimaryButton(label: label, onPressed: null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(campaignRepositoryProvider);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: isOwner
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SecondaryButton(
                    label: '지원자 보기',
                    icon: Icons.people_alt_rounded,
                    onPressed: () =>
                        context.push('/campaign/${campaign.id}/applicants'),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: SecondaryButton(
                          label: '수정',
                          onPressed: () => context.push(
                            '/campaign/${campaign.id}/edit',
                            extra: campaign,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: PrimaryButton(
                          label: campaign.status == CampaignStatus.open
                              ? '마감하기'
                              : '발행하기',
                          onPressed: () => _run(
                            context,
                            ref,
                            () => campaign.status == CampaignStatus.open
                                ? repo.close(campaign.id)
                                : repo.publish(campaign.id),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : _influencerAction(context, ref),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(icon, size: 18, color: context.palette.textSecondary),
            const SizedBox(width: 10),
            Text(label,
                style: TextStyle(
                    color: context.palette.textSecondary, fontSize: 14)),
            const Spacer(),
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: context.palette.ink,
                    fontSize: 14)),
          ],
        ),
      );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: context.palette.ink)),
      );
}

class _Tag extends StatelessWidget {
  const _Tag(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: BoxDecoration(
          color: context.palette.primarySoft,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(text,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryDark)),
      );
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: TextStyle(color: context.palette.textSecondary)),
            const SizedBox(height: 12),
            TextButton(onPressed: onRetry, child: const Text('다시 시도')),
          ],
        ),
      );
}
