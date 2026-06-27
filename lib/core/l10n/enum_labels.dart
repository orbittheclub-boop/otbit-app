import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/features/application/domain/entities/application.dart';
import 'package:orbit/features/campaign/domain/entities/campaign.dart';
import 'package:orbit/features/settlement/domain/entities/settlement.dart';

/// Localized labels for domain enums. Entities have no BuildContext, so the
/// UI maps the enum to a translated string here instead of a hardcoded getter.

String campaignTypeLabel(AppLocalizations l10n, CampaignType t) => switch (t) {
      CampaignType.delivery => l10n.campaignTypeDelivery,
      CampaignType.visit => l10n.campaignTypeVisit,
      CampaignType.press => l10n.campaignTypePress,
    };

String campaignStatusLabel(AppLocalizations l10n, CampaignStatus s) =>
    switch (s) {
      CampaignStatus.draft => l10n.campaignStatusDraft,
      CampaignStatus.open => l10n.campaignStatusOpen,
      CampaignStatus.closed => l10n.campaignStatusClosed,
      CampaignStatus.completed => l10n.campaignStatusCompleted,
    };

String applicationStatusLabel(AppLocalizations l10n, ApplicationStatus s) =>
    switch (s) {
      ApplicationStatus.pending => l10n.appStatusPending,
      ApplicationStatus.accepted => l10n.appStatusAccepted,
      ApplicationStatus.rejected => l10n.appStatusRejected,
      ApplicationStatus.submitted => l10n.appStatusSubmitted,
      ApplicationStatus.completed => l10n.appStatusCompleted,
    };

String settlementStatusLabel(AppLocalizations l10n, SettlementStatus s) =>
    switch (s) {
      SettlementStatus.pending => l10n.settleStatusPending,
      SettlementStatus.processing => l10n.settleStatusProcessing,
      SettlementStatus.paid => l10n.settleStatusPaid,
    };
