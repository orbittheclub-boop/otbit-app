import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/board/presentation/providers/board_providers.dart';
import 'package:orbit/features/board/presentation/widgets/board_post_card.dart';

const _categories = ['free', 'question', 'tip', 'review'];

/// Community board feed (Picky-style): category filter + post list. Both roles
/// can read & write. Compose entry is an AppBar action (avoids FAB/nav overlap).
class BoardListScreen extends HookConsumerWidget {
  const BoardListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(boardFeedProvider);
    final selected = ref.watch(boardCategoryFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.navBoard),
        actions: [
          IconButton(
            tooltip: context.l10n.boardWrite,
            icon: const Icon(Icons.edit_square),
            onPressed: () => context.push('/board/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              children: [
                _Chip(
                  label: context.l10n.boardAll,
                  selected: selected == null,
                  onTap: () =>
                      ref.read(boardCategoryFilterProvider.notifier).select(null),
                ),
                for (final c in _categories)
                  _Chip(
                    label: boardCategoryLabel(context, c),
                    selected: selected == c,
                    onTap: () =>
                        ref.read(boardCategoryFilterProvider.notifier).select(c),
                  ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async => ref.invalidate(boardFeedProvider),
              // Show cached/previous posts immediately; only show a spinner on
              // the very first load when there is nothing to display yet.
              child: Builder(
                builder: (context) {
                  final list = async.value;
                  if (list == null) {
                    return async.hasError
                        ? _Error(
                            message: '${async.error}',
                            onRetry: () => ref.invalidate(boardFeedProvider),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primary));
                  }
                  if (list.isEmpty) return const _Empty();
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                    itemCount: list.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 14),
                    itemBuilder: (_, i) => BoardPostCard(
                      post: list[i],
                      onTap: () => context.push('/board/${list[i].id}'),
                    )
                        .animate(delay: (i * 40).ms)
                        .fadeIn(duration: 300.ms)
                        .moveY(begin: 12, end: 0, curve: Curves.easeOut),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Padding(
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
            color:
                selected ? AppColors.primaryDark : context.palette.textSecondary,
          ),
        ),
      );
}

class _Empty extends StatelessWidget {
  const _Empty();
  @override
  Widget build(BuildContext context) => ListView(
        children: [
          const SizedBox(height: 130),
          Icon(Icons.forum_outlined,
              size: 52, color: context.palette.textTertiary),
          const SizedBox(height: 16),
          Text(
            context.l10n.boardEmpty,
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
              child: TextButton(
                  onPressed: onRetry, child: Text(context.l10n.retry))),
        ],
      );
}
