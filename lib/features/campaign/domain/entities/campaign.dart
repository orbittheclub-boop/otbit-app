import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign.freezed.dart';

enum CampaignType {
  delivery,
  visit,
  press;

  static CampaignType fromString(String? s) => switch (s) {
        'visit' => CampaignType.visit,
        'press' => CampaignType.press,
        _ => CampaignType.delivery,
      };

  String get label => switch (this) {
        CampaignType.delivery => '배송형',
        CampaignType.visit => '방문형',
        CampaignType.press => '기자단',
      };
}

enum CampaignStatus {
  draft,
  open,
  closed,
  completed;

  static CampaignStatus fromString(String? s) => switch (s) {
        'open' => CampaignStatus.open,
        'closed' => CampaignStatus.closed,
        'completed' => CampaignStatus.completed,
        _ => CampaignStatus.draft,
      };

  String get label => switch (this) {
        CampaignStatus.draft => '작성중',
        CampaignStatus.open => '모집중',
        CampaignStatus.closed => '마감',
        CampaignStatus.completed => '완료',
      };
}

@freezed
abstract class Campaign with _$Campaign {
  const factory Campaign({
    required String id,
    required String companyId,
    required String title,
    String? description,
    String? category,
    @Default(CampaignType.delivery) CampaignType type,
    String? rewardType,
    int? rewardAmount,
    @Default(1) int recruitCount,
    String? contentGuide,
    @Default(0) int minFollowers,
    String? thumbnailUrl,
    DateTime? applyDeadline,
    @Default(CampaignStatus.draft) CampaignStatus status,
    DateTime? createdAt,
    String? companyName,
    @Default(false) bool verified,
    @Default(false) bool bookmarked,
    int? applicantCount,
    @Default(false) bool applied,
    String? applicationId,
    String? applicationStatus,
  }) = _Campaign;
}
