import 'package:freezed_annotation/freezed_annotation.dart';

part 'application.freezed.dart';

enum ApplicationStatus {
  pending,
  accepted,
  rejected,
  submitted,
  completed;

  static ApplicationStatus fromString(String? s) => switch (s) {
        'accepted' => ApplicationStatus.accepted,
        'rejected' => ApplicationStatus.rejected,
        'submitted' => ApplicationStatus.submitted,
        'completed' => ApplicationStatus.completed,
        _ => ApplicationStatus.pending,
      };

  String get label => switch (this) {
        ApplicationStatus.pending => '심사중',
        ApplicationStatus.accepted => '선정',
        ApplicationStatus.rejected => '미선정',
        ApplicationStatus.submitted => '제출완료',
        ApplicationStatus.completed => '완료',
      };
}

/// One influencer's application to a campaign. Carries optional joined data for
/// both views: campaign brief (influencer's "my applications") and influencer
/// brief (company's "applicants").
@freezed
abstract class Application with _$Application {
  const factory Application({
    required String id,
    required String campaignId,
    required String influencerId,
    @Default(ApplicationStatus.pending) ApplicationStatus status,
    String? message,
    DateTime? appliedAt,
    // campaign brief
    String? campaignTitle,
    String? campaignThumbnail,
    String? companyName,
    // influencer brief
    String? influencerName,
    String? influencerAvatar,
    String? tiktokUsername,
    int? followerCount,
  }) = _Application;
}
