import 'package:orbit/features/campaign/domain/entities/campaign.dart';

/// Fields a company submits to create or update a campaign.
class CampaignInput {
  const CampaignInput({
    required this.title,
    this.description,
    this.category,
    this.type = CampaignType.delivery,
    this.rewardType,
    this.rewardAmount,
    this.recruitCount = 1,
    this.contentGuide,
    this.minFollowers = 0,
    this.applyDeadline,
    this.thumbnailUrl,
    this.publishNow = false,
  });

  final String title;
  final String? description;
  final String? category;
  final CampaignType type;
  final String? rewardType;
  final int? rewardAmount;
  final int recruitCount;
  final String? contentGuide;
  final int minFollowers;
  final DateTime? applyDeadline;
  final String? thumbnailUrl;

  /// When true on create, the campaign starts as `open` instead of `draft`.
  final bool publishNow;
}
