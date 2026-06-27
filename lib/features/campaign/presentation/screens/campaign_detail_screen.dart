import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:orbit/core/l10n/enum_labels.dart';
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
        title: Text(context.l10n.campaignDetailTitle),
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
                      showAppToast(context, context.l10n.tryAgainLater,
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
                        _Tag(campaignTypeLabel(context.l10n, campaign.type)),
                        const SizedBox(width: 6),
                        _Tag(campaignStatusLabel(context.l10n, campaign.status)),
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
                      campaign.companyName ?? context.l10n.brandFallback,
                      style: TextStyle(
                        fontSize: 14,
                        color: context.palette.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _InfoRow(
                      icon: Icons.card_giftcard_rounded,
                      label: context.l10n.campaignDetailRewardLabel,
                      value: campaign.rewardType ??
                          (campaign.rewardAmount != null
                              ? context.l10n.wonAmount('${campaign.rewardAmount}')
                              : '-'),
                    ),
                    _InfoRow(
                      icon: Icons.people_alt_rounded,
                      label: context.l10n.summaryRecruit,
                      value: context.l10n
                          .campaignDetailPeopleCount(campaign.recruitCount),
                    ),
                    _InfoRow(
                      icon: Icons.favorite_rounded,
                      label: context.l10n.campaignDetailMinFollowers,
                      value: '${campaign.minFollowers}',
                    ),
                    if (deadline != null)
                      _InfoRow(
                        icon: Icons.schedule_rounded,
                        label: context.l10n.summaryDeadline,
                        value: DateFormat('yyyy.MM.dd').format(deadline),
                      ),
                    if (campaign.description != null) ...[
                      const SizedBox(height: 20),
                      _SectionTitle(context.l10n.campaignDetailIntroSection),
                      Text(
                        campaign.description!,
                        style: const TextStyle(height: 1.6, fontSize: 14),
                      ),
                    ],
                    if (campaign.contentGuide != null) ...[
                      const SizedBox(height: 20),
                      _SectionTitle(context.l10n.contentGuide),
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
        showAppToast(context, context.l10n.campaignDetailApplySuccess);
      case Err(:final failure):
        final msg = failure.message == 'already_applied'
            ? context.l10n.campaignDetailAlreadyApplied
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
        showAppToast(context, context.l10n.campaignDetailCancelSuccess);
      case Err(:final failure):
        showAppToast(context, failure.message, type: AppToastType.error);
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.campaignDetailDeleteTitle),
        content: Text(context.l10n.campaignDetailDeleteConfirm),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(context.l10n.cancel)),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );
    if (ok != true) return;
    final res = await ref.read(campaignRepositoryProvider).remove(campaign.id);
    if (!context.mounted) return;
    switch (res) {
      case Ok():
        ref.invalidate(myCampaignsProvider);
        ref.invalidate(campaignFeedProvider);
        showAppToast(context, context.l10n.campaignDetailDeleteSuccess);
        context.pop();
      case Err(:final failure):
        showAppToast(context, failure.message, type: AppToastType.error);
    }
  }

  /// Apply / cancel / status button for influencers, based on whether they have
  /// already applied and the application's status.
  Widget _influencerAction(BuildContext context, WidgetRef ref) {
    if (!campaign.applied) {
      return PrimaryButton(
        label: context.l10n.campaignDetailApply,
        onPressed: () => _apply(context, ref),
      );
    }
    if (campaign.applicationStatus == 'pending') {
      return SecondaryButton(
        label: context.l10n.campaignDetailCancelApply,
        onPressed: () => _cancel(context, ref),
      );
    }
    final label = switch (campaign.applicationStatus) {
      'accepted' => context.l10n.campaignDetailStatusAccepted,
      'submitted' => context.l10n.campaignDetailStatusSubmitted,
      'completed' => context.l10n.campaignDetailStatusCompleted,
      'rejected' => context.l10n.campaignDetailStatusRejected,
      _ => context.l10n.campaignDetailStatusApplied,
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
                    label: context.l10n.campaignDetailViewApplicants,
                    icon: Icons.people_alt_rounded,
                    onPressed: () =>
                        context.push('/campaign/${campaign.id}/applicants'),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: SecondaryButton(
                          label: context.l10n.campaignDetailEdit,
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
                              ? context.l10n.campaignDetailClose
                              : context.l10n.campaignDetailPublish,
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
                  const SizedBox(height: 2),
                  TextButton.icon(
                    onPressed: () => _delete(context, ref),
                    icon: const Icon(Icons.delete_outline_rounded,
                        size: 18, color: AppColors.danger),
                    label: Text(context.l10n.campaignDetailDeleteTitle,
                        style: const TextStyle(color: AppColors.danger)),
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
            TextButton(onPressed: onRetry, child: Text(context.l10n.retry)),
          ],
        ),
      );
}
