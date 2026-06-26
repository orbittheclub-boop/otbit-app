import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/core/widgets/zoom_tap.dart';
import 'package:orbit/features/application/domain/entities/application.dart';
import 'package:orbit/features/application/presentation/providers/application_providers.dart';
import 'package:orbit/features/application/presentation/widgets/status_chip.dart';
import 'package:orbit/features/review/presentation/widgets/rating_dialog.dart';
import 'package:orbit/features/settlement/presentation/providers/settlement_providers.dart';

class ApplicantsScreen extends ConsumerWidget {
  const ApplicantsScreen({super.key, required this.campaignId});

  final String campaignId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(applicantsProvider(campaignId));
    return Scaffold(
      appBar: AppBar(title: const Text('지원자')),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async => ref.invalidate(applicantsProvider(campaignId)),
        child: async.when(
          loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary)),
          error: (e, _) => _CenterText('$e'),
          data: (list) => list.isEmpty
              ? const _CenterText('아직 지원자가 없어요.')
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => _ApplicantTile(
                    application: list[i],
                    campaignId: campaignId,
                  ),
                ),
        ),
      ),
    );
  }
}

class _ApplicantTile extends ConsumerWidget {
  const _ApplicantTile({required this.application, required this.campaignId});

  final Application application;
  final String campaignId;

  Future<void> _decide(WidgetRef ref, bool accept) async {
    await ref.read(applicationRepositoryProvider).decide(application.id, accept: accept);
    ref.invalidate(applicantsProvider(campaignId));
  }

  Future<void> _settle(BuildContext context, WidgetRef ref) async {
    final amount = await showDialog<int>(
      context: context,
      builder: (_) => const _AmountDialog(),
    );
    if (amount == null || !context.mounted) return;
    final res = await ref
        .read(settlementRepositoryProvider)
        .create(application.id, amount: amount, paid: true);
    if (!context.mounted) return;
    final msg = switch (res) {
      Ok() => '정산 등록 완료',
      Err(:final failure) => failure.message,
    };
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pending = application.status == ApplicationStatus.pending;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.palette.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: context.palette.primarySoft,
                backgroundImage: application.influencerAvatar != null
                    ? NetworkImage(application.influencerAvatar!)
                    : null,
                child: application.influencerAvatar == null
                    ? const Icon(Icons.person, color: AppColors.primary)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      application.influencerName ?? '인플루언서',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: context.palette.ink),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (application.tiktokUsername != null) ...[
                          Icon(Icons.music_note_rounded,
                              size: 13, color: context.palette.textSecondary),
                          Text(
                            ' @${application.tiktokUsername}  ',
                            style: TextStyle(
                                fontSize: 12, color: context.palette.textSecondary),
                          ),
                        ],
                        const Icon(Icons.favorite_rounded,
                            size: 13, color: AppColors.primary),
                        Text(
                          ' ${application.followerCount ?? 0}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: context.palette.ink),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              StatusChip(label: application.status.label, status: application.status),
            ],
          ),
          if (application.message != null && application.message!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(application.message!,
                style: TextStyle(fontSize: 13, color: context.palette.textSecondary)),
          ],
          if (pending) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ZoomTap(
                    child: OutlinedButton(
                      onPressed: () => _decide(ref, false),
                      child: const Text('미선정'),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ZoomTap(
                    child: ElevatedButton(
                      onPressed: () => _decide(ref, true),
                      child: const Text('선정'),
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (application.status == ApplicationStatus.submitted) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ZoomTap(
                    child: OutlinedButton(
                      onPressed: () => _settle(context, ref),
                      child: const Text('정산하기'),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ZoomTap(
                    child: ElevatedButton(
                      onPressed: () => showRatingDialog(context, application.id,
                          title: '인플루언서 평가'),
                      child: const Text('리뷰'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _AmountDialog extends StatefulWidget {
  const _AmountDialog();
  @override
  State<_AmountDialog> createState() => _AmountDialogState();
}

class _AmountDialogState extends State<_AmountDialog> {
  final _amount = TextEditingController();

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('정산 금액'),
      content: TextField(
        controller: _amount,
        keyboardType: TextInputType.number,
        autofocus: true,
        decoration: const InputDecoration(hintText: '금액(원)', suffixText: '원'),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소')),
        TextButton(
          onPressed: () =>
              Navigator.of(context).pop(int.tryParse(_amount.text) ?? 0),
          child: const Text('확인'),
        ),
      ],
    );
  }
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
