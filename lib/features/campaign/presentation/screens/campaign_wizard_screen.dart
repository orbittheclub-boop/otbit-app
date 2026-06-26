import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/core/widgets/primary_button.dart';
import 'package:orbit/features/campaign/domain/entities/campaign.dart';
import 'package:orbit/features/campaign/domain/entities/campaign_input.dart';
import 'package:orbit/features/campaign/presentation/providers/campaign_providers.dart';

const _totalSteps = 6;

/// Onboarding-style multi-step wizard for creating a campaign. All input lives
/// in hooks within this single widget, so moving between steps (or going back)
/// preserves everything entered.
class CampaignWizardScreen extends HookConsumerWidget {
  const CampaignWizardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step = useState(0);
    // +1 = moving forward, -1 = going back. Drives the slide direction of the
    // step transition.
    final direction = useState(1);
    final type = useState<CampaignType?>(null);
    final title = useTextEditingController();
    final category = useTextEditingController();
    final rewardType = useTextEditingController();
    final rewardAmount = useTextEditingController();
    final recruit = useTextEditingController(text: '1');
    final minF = useTextEditingController(text: '0');
    final desc = useTextEditingController();
    final guide = useTextEditingController();
    final deadline = useState<DateTime?>(null);
    // Default to publishing so a freshly created campaign is immediately visible
    // in the influencer feed; the toggle on the review step can still save it as
    // a draft.
    final publishNow = useState(true);
    final thumbnailUrl = useState<String?>(null);
    final uploadingThumb = useState(false);
    final loading = useState(false);
    final error = useState<String?>(null);

    // Rebuild the button's enabled state as the title is typed (step 2).
    useListenable(title);

    String? nz(TextEditingController c) =>
        c.text.trim().isEmpty ? null : c.text.trim();

    final canProceed = switch (step.value) {
      0 => type.value != null,
      1 => title.text.trim().isNotEmpty,
      _ => true,
    };
    final isLast = step.value == _totalSteps - 1;

    void goBack() {
      FocusScope.of(context).unfocus();
      if (step.value > 0) {
        direction.value = -1;
        step.value -= 1;
      } else {
        context.pop();
      }
    }

    void next() {
      FocusScope.of(context).unfocus();
      error.value = null;
      direction.value = 1;
      step.value += 1;
    }

    Future<void> pickThumbnail() async {
      final x = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 88,
      );
      if (x == null) return;
      uploadingThumb.value = true;
      error.value = null;
      final bytes = await x.readAsBytes();
      final ct =
          x.name.toLowerCase().endsWith('.png') ? 'image/png' : 'image/jpeg';
      final res = await ref
          .read(campaignRepositoryProvider)
          .uploadImage(bytes: bytes, contentType: ct);
      if (!context.mounted) return;
      uploadingThumb.value = false;
      switch (res) {
        case Ok(:final value):
          thumbnailUrl.value = value;
        case Err(:final failure):
          error.value = failure.message;
      }
    }

    Future<void> pickDeadline() async {
      final now = DateTime.now();
      final picked = await showDatePicker(
        context: context,
        initialDate: deadline.value ?? now,
        firstDate: now,
        lastDate: now.add(const Duration(days: 365)),
      );
      if (picked != null) deadline.value = picked;
    }

    Future<void> submit() async {
      FocusScope.of(context).unfocus();
      loading.value = true;
      error.value = null;
      final input = CampaignInput(
        title: title.text.trim(),
        description: nz(desc),
        category: nz(category),
        type: type.value ?? CampaignType.delivery,
        rewardType: nz(rewardType),
        rewardAmount: int.tryParse(rewardAmount.text),
        recruitCount: int.tryParse(recruit.text) ?? 1,
        minFollowers: int.tryParse(minF.text) ?? 0,
        contentGuide: nz(guide),
        applyDeadline: deadline.value,
        thumbnailUrl: thumbnailUrl.value,
        publishNow: publishNow.value,
      );
      final res = await ref.read(campaignRepositoryProvider).create(input);
      if (!context.mounted) return;
      loading.value = false;
      switch (res) {
        case Ok():
          ref.invalidate(myCampaignsProvider);
          ref.invalidate(campaignFeedProvider);
          context.pop();
        case Err(:final failure):
          error.value = failure.message;
      }
    }

    final body = switch (step.value) {
      0 => _StepType(selected: type.value, onSelect: (t) => type.value = t),
      1 => _StepTitle(
          title: title,
          category: category,
          thumbnailUrl: thumbnailUrl.value,
          uploading: uploadingThumb.value,
          onPickThumbnail: pickThumbnail,
        ),
      2 => _StepReward(
          rewardType: rewardType,
          rewardAmount: rewardAmount,
          recruit: recruit,
          minF: minF,
        ),
      3 => _StepDeadline(deadline: deadline.value, onPick: pickDeadline),
      4 => _StepDetail(desc: desc, guide: guide),
      _ => _StepReview(
          type: type.value,
          title: title.text,
          rewardType: nz(rewardType),
          rewardAmount: int.tryParse(rewardAmount.text),
          recruit: int.tryParse(recruit.text) ?? 1,
          deadline: deadline.value,
          publishNow: publishNow.value,
          onTogglePublish: (v) => publishNow.value = v,
        ),
    };

    return PopScope(
      canPop: step.value == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && step.value > 0) {
          direction.value = -1;
          step.value -= 1;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: goBack,
          ),
          title: const Text('새 캠페인'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(3),
            // Smoothly tween the progress bar as steps change.
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 360),
              curve: Curves.easeOutCubic,
              tween: Tween(end: (step.value + 1) / _totalSteps),
              builder: (_, value, _) => LinearProgressIndicator(
                value: value,
                minHeight: 3,
                backgroundColor: context.palette.border,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 380),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  final slide = Tween<Offset>(
                    begin: Offset(0.28 * direction.value, 0),
                    end: Offset.zero,
                  ).animate(animation);
                  final scale = Tween<double>(begin: 0.94, end: 1)
                      .animate(animation);
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: slide,
                      child: ScaleTransition(scale: scale, child: child),
                    ),
                  );
                },
                layoutBuilder: (current, previous) => Stack(
                  alignment: Alignment.topCenter,
                  children: [...previous, ?current],
                ),
                child: SingleChildScrollView(
                  key: ValueKey(step.value),
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: body,
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 4, 24, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (error.value != null) ...[
                      Text(error.value!,
                          style: const TextStyle(
                              color: AppColors.danger, fontSize: 13)),
                      const SizedBox(height: 10),
                    ],
                    PrimaryButton(
                      label: isLast ? '등록하기' : '다음',
                      loading: loading.value,
                      onPressed: (!isLast && !canProceed)
                          ? null
                          : (isLast ? submit : next),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── step header ────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  const _Header(this.title, this.subtitle);
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 24, top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: context.palette.ink,
                    height: 1.3)),
            const SizedBox(height: 8),
            Text(subtitle,
                style: TextStyle(
                    color: context.palette.textSecondary, fontSize: 14)),
          ],
        ),
      );
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 4),
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: context.palette.ink,
                fontSize: 14)),
      );
}

// ── step 1: type ───────────────────────────────────────────────────────────
class _StepType extends StatelessWidget {
  const _StepType({required this.selected, required this.onSelect});
  final CampaignType? selected;
  final ValueChanged<CampaignType> onSelect;

  static const _items = [
    (CampaignType.delivery, '배송형', '제품을 보내고 리뷰를 받아요', Icons.local_shipping_outlined),
    (CampaignType.visit, '방문형', '매장 방문 후 콘텐츠를 만들어요', Icons.storefront_outlined),
    (CampaignType.press, '기자단', '보도·홍보성 콘텐츠를 제작해요', Icons.article_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Header('어떤 캠페인인가요?', '진행할 캠페인 유형을 선택해주세요.'),
        for (final (t, title, sub, icon) in _items) ...[
          _TypeCard(
            title: title,
            subtitle: sub,
            icon: icon,
            selected: selected == t,
            onTap: () => onSelect(t),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _TypeCard extends StatelessWidget {
  const _TypeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: selected ? context.palette.primarySoft : context.palette.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.primary : context.palette.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: selected ? AppColors.primary : context.palette.textSecondary,
                size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: context.palette.ink)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: TextStyle(
                          fontSize: 13, color: context.palette.textSecondary)),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

// ── step 2: title & category ───────────────────────────────────────────────
class _StepTitle extends StatelessWidget {
  const _StepTitle({
    required this.title,
    required this.category,
    required this.thumbnailUrl,
    required this.uploading,
    required this.onPickThumbnail,
  });
  final TextEditingController title;
  final TextEditingController category;
  final String? thumbnailUrl;
  final bool uploading;
  final VoidCallback onPickThumbnail;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Header('캠페인을 소개해주세요', '대표 이미지·제목·카테고리를 입력해주세요.'),
        const _FieldLabel('대표 이미지 (선택)'),
        _ThumbnailPicker(
          url: thumbnailUrl,
          uploading: uploading,
          onTap: onPickThumbnail,
        ),
        const SizedBox(height: 18),
        const _FieldLabel('제목'),
        TextField(
          controller: title,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(hintText: '예) 신상 립밤 체험단 모집'),
        ),
        const SizedBox(height: 18),
        const _FieldLabel('카테고리 (선택)'),
        TextField(
          controller: category,
          decoration: const InputDecoration(hintText: '예) 뷰티, 푸드, 패션'),
        ),
      ],
    );
  }
}

class _ThumbnailPicker extends StatelessWidget {
  const _ThumbnailPicker({
    required this.url,
    required this.uploading,
    required this.onTap,
  });
  final String? url;
  final bool uploading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: uploading ? null : onTap,
      borderRadius: BorderRadius.circular(14),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
            color: context.palette.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: context.palette.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (url != null)
                CachedNetworkImage(imageUrl: url!, fit: BoxFit.cover)
              else
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined,
                          size: 34, color: context.palette.textTertiary),
                      const SizedBox(height: 6),
                      Text('대표 이미지 추가',
                          style:
                              TextStyle(color: context.palette.textSecondary)),
                    ],
                  ),
                ),
              if (uploading)
                ColoredBox(
                  color: Colors.black.withValues(alpha: 0.35),
                  child: const Center(
                    child: SizedBox(
                      height: 28,
                      width: 28,
                      child: CircularProgressIndicator(
                          strokeWidth: 2.5, color: Colors.white),
                    ),
                  ),
                ),
              if (url != null && !uploading)
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit_rounded, size: 14, color: Colors.white),
                        SizedBox(width: 4),
                        Text('변경',
                            style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── step 3: reward & recruit ───────────────────────────────────────────────
class _StepReward extends StatelessWidget {
  const _StepReward({
    required this.rewardType,
    required this.rewardAmount,
    required this.recruit,
    required this.minF,
  });
  final TextEditingController rewardType;
  final TextEditingController rewardAmount;
  final TextEditingController recruit;
  final TextEditingController minF;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Header('어떤 혜택을 제공하나요?', '제공 혜택과 모집 조건을 입력해주세요.'),
        const _FieldLabel('제공 혜택 (선택)'),
        TextField(
          controller: rewardType,
          decoration: const InputDecoration(hintText: '예) 제품 무료 제공'),
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _FieldLabel('지급액(원)'),
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
                  const _FieldLabel('모집 인원'),
                  TextField(
                      controller: recruit,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: '1')),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const _FieldLabel('최소 팔로워 수'),
        TextField(
          controller: minF,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: '0'),
        ),
      ],
    );
  }
}

// ── step 4: deadline ───────────────────────────────────────────────────────
class _StepDeadline extends StatelessWidget {
  const _StepDeadline({required this.deadline, required this.onPick});
  final DateTime? deadline;
  final VoidCallback onPick;
  @override
  Widget build(BuildContext context) {
    final set = deadline != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Header('언제까지 모집하나요?', '지원 마감일을 선택해주세요. (선택)'),
        InkWell(
          onTap: onPick,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: set ? context.palette.primarySoft : context.palette.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: set ? AppColors.primary : context.palette.border,
                  width: set ? 1.5 : 1),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_rounded,
                    color: set ? AppColors.primary : context.palette.textSecondary),
                const SizedBox(width: 14),
                Text(
                  set
                      ? DateFormat('yyyy년 MM월 dd일').format(deadline!)
                      : '마감일 선택하기',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: set ? context.palette.ink : context.palette.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── step 5: detail ─────────────────────────────────────────────────────────
class _StepDetail extends StatelessWidget {
  const _StepDetail({required this.desc, required this.guide});
  final TextEditingController desc;
  final TextEditingController guide;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Header('캠페인을 자세히 설명해주세요', '소개와 콘텐츠 가이드를 입력해주세요. (선택)'),
        const _FieldLabel('소개'),
        TextField(
          controller: desc,
          maxLines: 4,
          decoration: const InputDecoration(hintText: '캠페인 소개'),
        ),
        const SizedBox(height: 18),
        const _FieldLabel('콘텐츠 가이드'),
        TextField(
          controller: guide,
          maxLines: 3,
          decoration: const InputDecoration(hintText: '인플루언서가 지켜야 할 가이드'),
        ),
      ],
    );
  }
}

// ── step 6: review & publish ───────────────────────────────────────────────
class _StepReview extends StatelessWidget {
  const _StepReview({
    required this.type,
    required this.title,
    required this.rewardType,
    required this.rewardAmount,
    required this.recruit,
    required this.deadline,
    required this.publishNow,
    required this.onTogglePublish,
  });
  final CampaignType? type;
  final String title;
  final String? rewardType;
  final int? rewardAmount;
  final int recruit;
  final DateTime? deadline;
  final bool publishNow;
  final ValueChanged<bool> onTogglePublish;

  @override
  Widget build(BuildContext context) {
    final reward = rewardType ??
        (rewardAmount != null ? '$rewardAmount원' : '-');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Header('거의 다 됐어요!', '입력한 내용을 확인하고 등록해주세요.'),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: context.palette.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.palette.border),
          ),
          child: Column(
            children: [
              _SummaryRow('유형', type?.label ?? '-'),
              _SummaryRow('제목', title.isEmpty ? '-' : title),
              _SummaryRow('혜택', reward),
              _SummaryRow('모집', '$recruit명'),
              _SummaryRow(
                '마감',
                deadline == null
                    ? '미설정'
                    : DateFormat('yyyy.MM.dd').format(deadline!),
                last: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _CheckTile(
          checked: publishNow,
          title: '바로 발행하기',
          subtitle: '체크하면 인플루언서에게 바로 노출돼요.\n해제하면 작성중(draft)으로 저장돼요.',
          onTap: () => onTogglePublish(!publishNow),
        ),
      ],
    );
  }
}

/// Checkbox-style tile: dimmed when unchecked, highlighted + bold when checked.
class _CheckTile extends StatelessWidget {
  const _CheckTile({
    required this.checked,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final bool checked;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: checked ? context.palette.primarySoft : context.palette.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: checked ? AppColors.primary : context.palette.border,
            width: checked ? 1.5 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: checked ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: checked ? AppColors.primary : context.palette.textTertiary,
                  width: 2,
                ),
              ),
              child: checked
                  ? const Icon(Icons.check_rounded,
                      size: 16, color: AppColors.onPrimary)
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: checked ? FontWeight.w800 : FontWeight.w600,
                      color: checked
                          ? context.palette.ink
                          : context.palette.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: context.palette.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow(this.label, this.value, {this.last = false});
  final String label;
  final String value;
  final bool last;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: last ? 0 : 12),
        child: Row(
          children: [
            SizedBox(
              width: 56,
              child: Text(label,
                  style: TextStyle(
                      color: context.palette.textSecondary, fontSize: 14)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(value,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: context.palette.ink,
                      fontSize: 14)),
            ),
          ],
        ),
      );
}
