import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/enum_labels.dart';
import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/core/widgets/app_toast.dart';
import 'package:orbit/core/widgets/zoom_tap.dart';
import 'package:orbit/features/application/domain/entities/application.dart';
import 'package:orbit/features/application/presentation/providers/application_providers.dart';
import 'package:orbit/features/application/presentation/providers/pinned_applications.dart';
import 'package:orbit/features/application/presentation/widgets/status_chip.dart';
import 'package:orbit/features/review/presentation/widgets/rating_dialog.dart';

class MyApplicationsScreen extends ConsumerWidget {
  const MyApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(myApplicationsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.applyMyApplicationsTitle)),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async => ref.invalidate(myApplicationsProvider),
        child: async.when(
          loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary)),
          error: (e, _) => _CenterText('$e'),
          data: (list) {
            if (list.isEmpty) {
              return _CenterText(context.l10n.applyEmpty);
            }
            // 즐겨찾기(로컬 핀)한 지원을 위로 분리. 내 찜(캠페인 북마크)과는 별개.
            final pinnedIds = ref.watch(pinnedApplicationsProvider);
            final pinned = list.where((a) => pinnedIds.contains(a.id)).toList();
            final rest = list.where((a) => !pinnedIds.contains(a.id)).toList();
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              children: [
                if (pinned.isNotEmpty) ...[
                  _SectionHeader(context.l10n.applyFavoritesSection),
                  for (final a in pinned)
                    _ApplicationTile(application: a, pinned: true),
                ],
                if (rest.isNotEmpty) ...[
                  if (pinned.isNotEmpty) _SectionHeader(context.l10n.boardAll),
                  for (final a in rest)
                    _ApplicationTile(application: a, pinned: false),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ApplicationTile extends ConsumerWidget {
  const _ApplicationTile({required this.application, required this.pinned});

  final Application application;
  final bool pinned;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canSubmit = application.status == ApplicationStatus.accepted ||
        application.status == ApplicationStatus.submitted;
    // Cancellable only while pending (the backend enforces influencer + pending).
    final canCancel = application.status == ApplicationStatus.pending;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey(application.id),
        // Swipe right → toggle 즐겨찾기 (local pin).
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.3,
          children: [
            SlidableAction(
              onPressed: (_) => ref
                  .read(pinnedApplicationsProvider.notifier)
                  .toggle(application.id),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              borderRadius: BorderRadius.circular(14),
              icon: pinned ? Icons.star_rounded : Icons.star_outline_rounded,
              label: pinned ? context.l10n.applyUnpin : context.l10n.applyPin,
            ),
          ],
        ),
        // Swipe left → 지원취소 (only while pending).
        endActionPane: canCancel
            ? ActionPane(
                motion: const DrawerMotion(),
                extentRatio: 0.3,
                children: [
                  SlidableAction(
                    onPressed: (ctx) => _confirmCancel(ctx, ref),
                    backgroundColor: AppColors.danger,
                    foregroundColor: AppColors.onPrimary,
                    borderRadius: BorderRadius.circular(14),
                    icon: Icons.close_rounded,
                    label: context.l10n.applyCancelAction,
                  ),
                ],
              )
            : null,
        child: ZoomTap(
          child: InkWell(
            onTap: () => context.push('/campaign/${application.campaignId}'),
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: pinned
                    ? context.palette.primarySoft
                    : context.palette.background,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: pinned ? AppColors.primary : context.palette.border,
                  width: pinned ? 1.4 : 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (pinned) ...[
                        const Icon(Icons.star_rounded,
                            size: 16, color: AppColors.primary),
                        const SizedBox(width: 4),
                      ],
                      Expanded(
                        child: Text(
                          application.campaignTitle ?? context.l10n.campaignFallback,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: context.palette.ink),
                        ),
                      ),
                      const SizedBox(width: 8),
                      StatusChip(
                          label: applicationStatusLabel(
                              context.l10n, application.status),
                          status: application.status),
                      const SizedBox(width: 4),
                      Icon(Icons.chevron_right_rounded,
                          size: 18, color: context.palette.textTertiary),
                    ],
                  ),
          const SizedBox(height: 4),
          Text(
            application.companyName ?? context.l10n.brandFallback,
            style: TextStyle(color: context.palette.textSecondary, fontSize: 13),
          ),
          if (canSubmit) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ZoomTap(
                child: OutlinedButton(
                  onPressed: () => _submit(context, ref),
                  child: Text(application.status == ApplicationStatus.submitted
                      ? context.l10n.applyResubmitContent
                      : context.l10n.applySubmitContent),
                ),
              ),
            ),
          ],
          if (application.status == ApplicationStatus.submitted ||
              application.status == ApplicationStatus.completed) ...[
            const SizedBox(height: 4),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => showRatingDialog(context, application.id,
                    title: context.l10n.applyRatingTitle),
                child: Text(context.l10n.applyLeaveReview),
              ),
            ),
          ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmCancel(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.applyCancelTitle),
        content: Text(context.l10n.applyCancelConfirm),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(context.l10n.applyNo)),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(context.l10n.applyCancelAction),
          ),
        ],
      ),
    );
    if (ok != true) return;
    final res =
        await ref.read(applicationRepositoryProvider).cancel(application.id);
    if (!context.mounted) return;
    if (res is Ok) {
      ref.invalidate(myApplicationsProvider);
    } else {
      showAppToast(context, (res as Err).failure.message,
          type: AppToastType.error);
    }
  }

  Future<void> _submit(BuildContext context, WidgetRef ref) async {
    final done = await showDialog<bool>(
      context: context,
      builder: (_) => _SubmitDialog(applicationId: application.id),
    );
    if (done == true) ref.invalidate(myApplicationsProvider);
  }
}

class _SubmitDialog extends ConsumerStatefulWidget {
  const _SubmitDialog({required this.applicationId});
  final String applicationId;

  @override
  ConsumerState<_SubmitDialog> createState() => _SubmitDialogState();
}

class _SubmitDialogState extends ConsumerState<_SubmitDialog> {
  final _url = TextEditingController();
  final _note = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _url.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_url.text.trim().isEmpty) {
      setState(() => _error = context.l10n.applyContentUrlRequired);
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    final res = await ref.read(applicationRepositoryProvider).submitContent(
          widget.applicationId,
          contentUrl: _url.text.trim(),
          note: _note.text.trim().isEmpty ? null : _note.text.trim(),
        );
    if (!mounted) return;
    switch (res) {
      case Ok():
        Navigator.of(context).pop(true);
      case Err(:final failure):
        setState(() {
          _loading = false;
          _error = failure.message;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.applySubmitTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _url,
            decoration: InputDecoration(hintText: context.l10n.applyContentUrlHint),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _note,
            decoration: InputDecoration(hintText: context.l10n.applyNoteHint),
          ),
          if (_error != null) ...[
            const SizedBox(height: 10),
            Text(_error!,
                style: const TextStyle(color: AppColors.danger, fontSize: 12)),
          ],
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.cancel)),
        TextButton(
          onPressed: _loading ? null : _save,
          child: _loading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : Text(context.l10n.applySubmit),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 10, left: 2),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: context.palette.textSecondary,
          ),
        ),
      );
}

class _CenterText extends StatelessWidget {
  const _CenterText(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => ListView(
        children: [
          const SizedBox(height: 180),
          Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(color: context.palette.textSecondary)),
        ],
      );
}
