import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/widgets/app_toast.dart';
import 'package:orbit/features/campaign/domain/entities/campaign.dart';
import 'package:orbit/features/campaign/presentation/providers/campaign_providers.dart';
import 'package:orbit/features/campaign/presentation/widgets/campaign_card.dart';
import 'package:orbit/features/home/presentation/widgets/app_drawer.dart';

/// Influencer landing: feed of open campaigns to browse, filter, rank and apply.
class InfluencerHomeScreen extends HookConsumerWidget {
  const InfluencerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(campaignFeedProvider);
    final filter = ref.watch(campaignFilterProvider);
    final search = useTextEditingController();
    useListenable(search);

    final popular = filter.sort == 'popular';

    void applyQuery() {
      final v = search.text.trim();
      ref.read(campaignFilterProvider.notifier).setQuery(v.isEmpty ? null : v);
      FocusScope.of(context).unfocus();
    }

    final overrides = ref.watch(bookmarkOverridesProvider);

    Future<void> onBookmark(Campaign c) async {
      final ok = await toggleCampaignBookmark(ref, c);
      if (!ok && context.mounted) {
        showAppToast(context, '잠시 후 다시 시도해주세요', type: AppToastType.error);
      }
    }

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('캠페인 둘러보기')),
      body: Column(
        children: [
          _FilterBar(
            search: search,
            selectedType: filter.type,
            selectedSort: filter.sort,
            popular: popular,
            onSubmitQuery: applyQuery,
            onClearQuery: () {
              search.clear();
              ref.read(campaignFilterProvider.notifier).setQuery(null);
              FocusScope.of(context).unfocus();
            },
            onType: (t) => ref.read(campaignFilterProvider.notifier).setType(t),
            onSort: (s) => ref.read(campaignFilterProvider.notifier).setSort(s),
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async => ref.invalidate(campaignFeedProvider),
              child: async.when(
                loading: () => const Center(
                    child: CircularProgressIndicator(color: AppColors.primary)),
                error: (e, _) => _Error(
                  message: '$e',
                  onRetry: () => ref.invalidate(campaignFeedProvider),
                ),
                data: (list) => list.isEmpty
                    ? _Empty(filtered: filter.type != null || filter.query != null)
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                        itemCount: list.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 16),
                        itemBuilder: (_, i) {
                          final c = list[i];
                          return CampaignCard(
                            campaign: c.copyWith(
                                bookmarked: overrides[c.id] ?? c.bookmarked),
                            rank: popular ? i + 1 : null,
                            onBookmark: () => onBookmark(c),
                            onTap: () => context.push('/campaign/${c.id}'),
                          )
                              .animate(delay: (i * 50).ms)
                              .fadeIn(duration: 320.ms)
                              .moveY(begin: 14, end: 0, curve: Curves.easeOut);
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.search,
    required this.selectedType,
    required this.selectedSort,
    required this.popular,
    required this.onSubmitQuery,
    required this.onClearQuery,
    required this.onType,
    required this.onSort,
  });

  final TextEditingController search;
  final String? selectedType;
  final String selectedSort;
  final bool popular;
  final VoidCallback onSubmitQuery;
  final VoidCallback onClearQuery;
  final ValueChanged<String?> onType;
  final ValueChanged<String> onSort;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
      child: Column(
        children: [
          Row(
            children: [
              _SortChip(
                icon: Icons.schedule_rounded,
                label: context.l10n.sortLatest,
                selected: !popular,
                onTap: () => onSort('latest'),
              ),
              const SizedBox(width: 8),
              _SortChip(
                icon: Icons.local_fire_department_rounded,
                label: context.l10n.sortPopular,
                selected: popular,
                onTap: () => onSort('popular'),
              ),
            ],
          ),
          if (!popular) ...[
            const SizedBox(height: 10),
            TextField(
              controller: search,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => onSubmitQuery(),
              decoration: InputDecoration(
                isDense: true,
                hintText: '캠페인 검색',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: search.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close_rounded, size: 20),
                        onPressed: onClearQuery,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _TypeChip(
                    label: '전체',
                    selected: selectedType == null,
                    onTap: () => onType(null),
                  ),
                  for (final t in CampaignType.values)
                    _TypeChip(
                      label: t.label,
                      selected: selectedType == t.name,
                      onTap: () => onType(t.name),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  const _SortChip({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : context.palette.textSecondary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? context.palette.primarySoft : context.palette.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.primary : context.palette.border,
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? AppColors.primaryDark : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        showCheckmark: false,
        backgroundColor: context.palette.surface,
        selectedColor: context.palette.primarySoft,
        side: BorderSide(
          color: selected ? AppColors.primary : context.palette.border,
          width: selected ? 1.4 : 1,
        ),
        labelStyle: TextStyle(
          fontSize: 13,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected ? AppColors.primaryDark : context.palette.textSecondary,
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({this.filtered = false});
  final bool filtered;
  @override
  Widget build(BuildContext context) => ListView(
        children: [
          const SizedBox(height: 120),
          Icon(Icons.search_off_rounded,
              size: 52, color: context.palette.textTertiary),
          const SizedBox(height: 16),
          Text(
            filtered
                ? '조건에 맞는 캠페인이 없어요.\n필터를 바꿔보세요!'
                : '진행 중인 캠페인이 없어요.\n곧 새로운 캠페인이 올라올 거예요!',
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
