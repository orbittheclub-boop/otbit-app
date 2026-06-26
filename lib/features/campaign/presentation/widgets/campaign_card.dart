import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/campaign/domain/entities/campaign.dart';

class CampaignCard extends StatelessWidget {
  const CampaignCard({
    super.key,
    required this.campaign,
    this.onTap,
    this.showStatus = false,
    this.rank,
    this.onBookmark,
  });

  final Campaign campaign;
  final VoidCallback? onTap;
  final bool showStatus;

  /// 1-based ranking position (popular sort). Shows a #N badge when set.
  final int? rank;

  /// When provided, a bookmark (찜) heart is shown over the thumbnail.
  final VoidCallback? onBookmark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: context.palette.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.palette.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: campaign.thumbnailUrl != null
                      ? CachedNetworkImage(
                          imageUrl: campaign.thumbnailUrl!,
                          fit: BoxFit.cover,
                          placeholder: (_, _) =>
                              Container(color: context.palette.surface),
                          errorWidget: (_, _, _) => const _Placeholder(),
                        )
                      : const _Placeholder(),
                ),
                if (rank != null)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        gradient: AppColors.brandGradient,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '#$rank',
                        style: const TextStyle(
                          color: AppColors.onPrimary,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                if (onBookmark != null)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Material(
                      color: Colors.black.withValues(alpha: 0.32),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: onBookmark,
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Icon(
                            campaign.bookmarked
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            size: 20,
                            color: campaign.bookmarked
                                ? AppColors.primary
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _Chip(text: campaign.type.label),
                      if (showStatus) ...[
                        const SizedBox(width: 6),
                        _Chip(
                          text: campaign.status.label,
                          color: campaign.status == CampaignStatus.open
                              ? AppColors.success
                              : context.palette.textTertiary,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    campaign.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: context.palette.ink,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    campaign.companyName ?? '브랜드',
                    style: TextStyle(
                      fontSize: 13,
                      color: context.palette.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.card_giftcard_rounded,
                          size: 16, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        campaign.rewardType ??
                            (campaign.rewardAmount != null
                                ? '${campaign.rewardAmount}원'
                                : '제공 혜택'),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: context.palette.ink,
                        ),
                      ),
                      const Spacer(),
                      if (campaign.applicantCount != null) ...[
                        const Icon(Icons.people_alt_rounded,
                            size: 14, color: AppColors.primary),
                        const SizedBox(width: 3),
                        Text(
                          '지원 ${campaign.applicantCount}명',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ] else
                        Text(
                          '모집 ${campaign.recruitCount}명',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.palette.textSecondary,
                          ),
                        ),
                    ],
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

class _Placeholder extends StatelessWidget {
  const _Placeholder();
  @override
  Widget build(BuildContext context) => Container(
        color: context.palette.surface,
        child: Center(
          child: Icon(Icons.image_outlined,
              color: context.palette.textTertiary, size: 32),
        ),
      );
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text, this.color = AppColors.primary});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      );
}
