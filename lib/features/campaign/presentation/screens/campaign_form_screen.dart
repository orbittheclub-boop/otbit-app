import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:orbit/core/l10n/auth_error.dart';
import 'package:orbit/core/l10n/enum_labels.dart';
import 'package:orbit/core/l10n/l10n.dart';
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
        error.value = context.l10n.enterTitle;
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
          error.value = localizeAuthError(context.l10n, failure.message);
      }
    }

    Future<void> remove() async {
      final ok = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(context.l10n.campaignFormDelete),
          content: Text(context.l10n.deletePostConfirm),
          actions: [
            TextButton(
                onPressed: () => context.pop(false),
                child: Text(context.l10n.cancel)),
            TextButton(
                onPressed: () => context.pop(true),
                child: Text(context.l10n.delete,
                    style: const TextStyle(color: AppColors.danger))),
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
          error.value = localizeAuthError(context.l10n, failure.message);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
              isEdit ? context.l10n.campaignFormEditTitle : context.l10n.newCampaign)),
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
            _Label(context.l10n.fieldTitle),
            TextField(
                controller: title,
                decoration:
                    InputDecoration(hintText: context.l10n.campaignFormTitleHint)),
            const SizedBox(height: 16),
            _Label(context.l10n.summaryType),
            DropdownButtonFormField<CampaignType>(
              initialValue: type.value,
              items: CampaignType.values
                  .map((t) =>
                      DropdownMenuItem(
                          value: t,
                          child: Text(campaignTypeLabel(context.l10n, t))))
                  .toList(),
              onChanged: (v) => type.value = v ?? CampaignType.delivery,
            ),
            const SizedBox(height: 16),
            _Label(context.l10n.boardCategory),
            TextField(
                controller: category,
                decoration: InputDecoration(
                    hintText: context.l10n.campaignFormCategoryHint)),
            const SizedBox(height: 16),
            _Label(context.l10n.campaignFormReward),
            TextField(
                controller: rewardType,
                decoration:
                    InputDecoration(hintText: context.l10n.wizardRewardHint)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Label(context.l10n.amountWon),
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
                      _Label(context.l10n.recruitCountLabel),
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
            _Label(context.l10n.minFollowersLabel),
            TextField(
                controller: minF,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: '0')),
            const SizedBox(height: 16),
            _Label(context.l10n.campaignFormDeadline),
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
                      ? context.l10n.campaignFormPickDate
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
            _Label(context.l10n.intro),
            TextField(
                controller: desc,
                maxLines: 4,
                decoration:
                    InputDecoration(hintText: context.l10n.wizardDescHint)),
            const SizedBox(height: 16),
            _Label(context.l10n.contentGuide),
            TextField(
                controller: guide,
                maxLines: 3,
                decoration:
                    InputDecoration(hintText: context.l10n.wizardGuideHint)),
            if (!isEdit) ...[
              const SizedBox(height: 8),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeThumbColor: AppColors.primary,
                title: Text(context.l10n.publishNow),
                subtitle: Text(context.l10n.publishNowDesc),
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
              label: isEdit ? context.l10n.campaignFormSave : context.l10n.register,
              loading: loading.value,
              onPressed: submit,
            ),
            if (isEdit) ...[
              const SizedBox(height: 4),
              TextButton(
                onPressed: remove,
                child: Text(context.l10n.campaignFormDelete,
                    style: const TextStyle(color: AppColors.danger)),
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
