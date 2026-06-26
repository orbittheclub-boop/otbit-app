import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/core/widgets/primary_button.dart';
import 'package:orbit/features/campaign/domain/entities/campaign.dart';
import 'package:orbit/features/campaign/domain/entities/campaign_input.dart';
import 'package:orbit/features/campaign/presentation/providers/campaign_providers.dart';

class CampaignFormScreen extends HookConsumerWidget {
  const CampaignFormScreen({super.key, this.initial});

  final Campaign? initial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEdit = initial != null;
    final title = useTextEditingController(text: initial?.title ?? '');
    final desc = useTextEditingController(text: initial?.description ?? '');
    final category = useTextEditingController(text: initial?.category ?? '');
    final rewardType = useTextEditingController(text: initial?.rewardType ?? '');
    final rewardAmount =
        useTextEditingController(text: initial?.rewardAmount?.toString() ?? '');
    final recruit = useTextEditingController(
        text: (initial?.recruitCount ?? 1).toString());
    final minF =
        useTextEditingController(text: (initial?.minFollowers ?? 0).toString());
    final guide = useTextEditingController(text: initial?.contentGuide ?? '');
    final type = useState(initial?.type ?? CampaignType.delivery);
    final deadline = useState<DateTime?>(initial?.applyDeadline);
    final publishNow = useState(false);
    final loading = useState(false);
    final error = useState<String?>(null);

    String? nz(TextEditingController c) =>
        c.text.trim().isEmpty ? null : c.text.trim();

    Future<void> submit() async {
      FocusScope.of(context).unfocus();
      if (title.text.trim().isEmpty) {
        error.value = '제목을 입력해주세요.';
        return;
      }
      loading.value = true;
      error.value = null;
      final input = CampaignInput(
        title: title.text.trim(),
        description: nz(desc),
        category: nz(category),
        type: type.value,
        rewardType: nz(rewardType),
        rewardAmount: int.tryParse(rewardAmount.text),
        recruitCount: int.tryParse(recruit.text) ?? 1,
        minFollowers: int.tryParse(minF.text) ?? 0,
        contentGuide: nz(guide),
        applyDeadline: deadline.value,
        publishNow: publishNow.value,
      );
      final repo = ref.read(campaignRepositoryProvider);
      final res = isEdit
          ? await repo.update(initial!.id, input)
          : await repo.create(input);
      if (!context.mounted) return;
      loading.value = false;
      switch (res) {
        case Ok():
          ref.invalidate(myCampaignsProvider);
          ref.invalidate(campaignFeedProvider);
          if (isEdit) ref.invalidate(campaignDetailProvider(initial!.id));
          context.pop();
        case Err(:final failure):
          error.value = failure.message;
      }
    }

    Future<void> remove() async {
      final ok = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('캠페인 삭제'),
          content: const Text('정말 삭제할까요? 되돌릴 수 없어요.'),
          actions: [
            TextButton(
                onPressed: () => context.pop(false), child: const Text('취소')),
            TextButton(
                onPressed: () => context.pop(true),
                child: const Text('삭제', style: TextStyle(color: AppColors.danger))),
          ],
        ),
      );
      if (ok != true || !context.mounted) return;
      final res = await ref.read(campaignRepositoryProvider).remove(initial!.id);
      if (!context.mounted) return;
      switch (res) {
        case Ok():
          ref.invalidate(myCampaignsProvider);
          ref.invalidate(campaignFeedProvider);
          context.go('/company');
        case Err(:final failure):
          error.value = failure.message;
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(isEdit ? '캠페인 수정' : '새 캠페인')),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              const SizedBox(height: 8),
            _Label('제목'),
            TextField(
                controller: title,
                decoration: const InputDecoration(hintText: '캠페인 제목')),
            const SizedBox(height: 16),
            _Label('유형'),
            DropdownButtonFormField<CampaignType>(
              initialValue: type.value,
              items: CampaignType.values
                  .map((t) =>
                      DropdownMenuItem(value: t, child: Text(t.label)))
                  .toList(),
              onChanged: (v) => type.value = v ?? CampaignType.delivery,
            ),
            const SizedBox(height: 16),
            _Label('카테고리'),
            TextField(
                controller: category,
                decoration: const InputDecoration(hintText: '예) 뷰티, 푸드')),
            const SizedBox(height: 16),
            _Label('제공 혜택'),
            TextField(
                controller: rewardType,
                decoration: const InputDecoration(hintText: '예) 제품 무료 제공')),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Label('지급액(원)'),
                      TextField(
                          controller: rewardAmount,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: '0')),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Label('모집 인원'),
                      TextField(
                          controller: recruit,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: '1')),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _Label('최소 팔로워 수'),
            TextField(
                controller: minF,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: '0')),
            const SizedBox(height: 16),
            _Label('마감일'),
            InkWell(
              onTap: () async {
                final now = DateTime.now();
                final picked = await showDatePicker(
                  context: context,
                  initialDate: deadline.value ?? now,
                  firstDate: now,
                  lastDate: now.add(const Duration(days: 365)),
                );
                if (picked != null) deadline.value = picked;
              },
              child: InputDecorator(
                decoration: const InputDecoration(),
                child: Text(
                  deadline.value == null
                      ? '날짜 선택'
                      : DateFormat('yyyy.MM.dd').format(deadline.value!),
                  style: TextStyle(
                    color: deadline.value == null
                        ? context.palette.textTertiary
                        : context.palette.ink,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _Label('소개'),
            TextField(
                controller: desc,
                maxLines: 4,
                decoration: const InputDecoration(hintText: '캠페인 소개')),
            const SizedBox(height: 16),
            _Label('콘텐츠 가이드'),
            TextField(
                controller: guide,
                maxLines: 3,
                decoration: const InputDecoration(hintText: '인플루언서가 지켜야 할 가이드')),
            if (!isEdit) ...[
              const SizedBox(height: 8),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeThumbColor: AppColors.primary,
                title: const Text('바로 발행하기'),
                subtitle: const Text('끄면 작성중(draft)으로 저장돼요'),
                value: publishNow.value,
                onChanged: (v) => publishNow.value = v,
              ),
            ],
            if (error.value != null) ...[
              const SizedBox(height: 12),
              Text(error.value!,
                  style: const TextStyle(color: AppColors.danger, fontSize: 13)),
            ],
            const SizedBox(height: 20),
            PrimaryButton(
              label: isEdit ? '저장하기' : '등록하기',
              loading: loading.value,
              onPressed: submit,
            ),
            if (isEdit) ...[
              const SizedBox(height: 4),
              TextButton(
                onPressed: remove,
                child: const Text('캠페인 삭제',
                    style: TextStyle(color: AppColors.danger)),
              ),
            ],
            const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: context.palette.ink,
                fontSize: 14)),
      );
}
