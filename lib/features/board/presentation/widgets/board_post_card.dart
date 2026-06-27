import 'package:flutter/material.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/auth/domain/entities/app_user.dart';
import 'package:orbit/features/board/domain/entities/board_post.dart';
import 'package:orbit/features/board/presentation/widgets/board_body.dart';
import 'package:orbit/features/home/presentation/widgets/role_badge.dart';

/// Localized label for a board category key.
String boardCategoryLabel(BuildContext context, String key) => switch (key) {
      'free' => context.l10n.boardCatFree,
      'question' => context.l10n.boardCatQuestion,
      'tip' => context.l10n.boardCatTip,
      'review' => context.l10n.boardCatReview,
      _ => key,
    };

/// Maps the stored author role string to the [Role] enum (for [RoleBadge]).
Role? boardAuthorRole(String? s) => switch (s) {
      'company' => Role.company,
      'influencer' => Role.influencer,
      _ => null,
    };

/// Short relative time (방금 / N분 전 / N시간 전 / N일 전 / yyyy.MM.dd).
String boardTimeAgo(AppLocalizations l10n, DateTime? dt) {
  if (dt == null) return '';
  final diff = DateTime.now().difference(dt);
  if (diff.inMinutes < 1) return l10n.timeJustNow;
  if (diff.inMinutes < 60) return l10n.timeMinutesAgo(diff.inMinutes);
  if (diff.inHours < 24) return l10n.timeHoursAgo(diff.inHours);
  if (diff.inDays < 7) return l10n.timeDaysAgo(diff.inDays);
  return '${dt.year}.${dt.month.toString().padLeft(2, '0')}.${dt.day.toString().padLeft(2, '0')}';
}

class CategoryChip extends StatelessWidget {
  const CategoryChip(this.categoryKey, {super.key});
  final String categoryKey;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: BoxDecoration(
          color: context.palette.primarySoft,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          boardCategoryLabel(context, categoryKey),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryDark,
          ),
        ),
      );
}

class BoardPostCard extends StatelessWidget {
  const BoardPostCard({super.key, required this.post, required this.onTap});

  final BoardPost post;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final role = boardAuthorRole(post.authorRole);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.palette.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.palette.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CategoryChip(post.category),
                const Spacer(),
                Text(boardTimeAgo(context.l10n, post.createdAt),
                    style: TextStyle(
                        fontSize: 12, color: context.palette.textTertiary)),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              post.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: context.palette.ink,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              boardBodyToPlainText(post.body),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 13, height: 1.4, color: context.palette.textSecondary),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                CircleAvatar(
                  radius: 11,
                  backgroundColor: context.palette.primarySoft,
                  backgroundImage: post.authorAvatarUrl != null
                      ? NetworkImage(post.authorAvatarUrl!)
                      : null,
                  child: post.authorAvatarUrl == null
                      ? const Icon(Icons.person_rounded,
                          size: 14, color: AppColors.primary)
                      : null,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    post.authorName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: context.palette.textSecondary),
                  ),
                ),
                if (role != null) ...[
                  const SizedBox(width: 6),
                  RoleBadge(role: role),
                ],
                const Spacer(),
                _Stat(Icons.favorite_rounded, post.likeCount,
                    color: post.liked ? AppColors.primary : null),
                const SizedBox(width: 12),
                _Stat(Icons.mode_comment_rounded, post.commentCount),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.icon, this.count, {this.color});
  final IconData icon;
  final int count;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final c = color ?? context.palette.textTertiary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: c),
        const SizedBox(width: 4),
        Text('$count', style: TextStyle(fontSize: 12, color: c)),
      ],
    );
  }
}
