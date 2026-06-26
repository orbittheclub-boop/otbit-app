import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/core/providers/app_providers.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/campaign/data/datasources/campaign_api.dart';
import 'package:orbit/features/campaign/data/repositories/campaign_repository_impl.dart';
import 'package:orbit/features/campaign/domain/entities/campaign.dart';
import 'package:orbit/features/campaign/domain/repositories/campaign_repository.dart';

part 'campaign_providers.g.dart';

@Riverpod(keepAlive: true)
CampaignApi campaignApi(Ref ref) => CampaignApi(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
CampaignRepository campaignRepository(Ref ref) =>
    CampaignRepositoryImpl(ref.watch(campaignApiProvider), ref.watch(dioProvider));

/// Browse filter for the influencer feed. The feed re-fetches whenever it
/// changes. `type` holds a [CampaignType] name; `sort` is 'latest' | 'popular'.
typedef CampaignFilterState = ({
  String? category,
  String? type,
  String? query,
  String sort,
});

@riverpod
class CampaignFilter extends _$CampaignFilter {
  @override
  CampaignFilterState build() =>
      (category: null, type: null, query: null, sort: 'latest');

  void setType(String? type) => state = (
        category: state.category,
        type: type,
        query: state.query,
        sort: state.sort,
      );

  void setCategory(String? category) => state = (
        category: category,
        type: state.type,
        query: state.query,
        sort: state.sort,
      );

  void setQuery(String? query) => state = (
        category: state.category,
        type: state.type,
        query: query,
        sort: state.sort,
      );

  void setSort(String sort) => state = (
        category: state.category,
        type: state.type,
        query: state.query,
        sort: sort,
      );

  bool get isActive =>
      state.category != null || state.type != null || state.query != null;
}

@riverpod
Future<List<Campaign>> campaignFeed(Ref ref) async {
  final f = ref.watch(campaignFilterProvider);
  return unwrap(
    await ref.watch(campaignRepositoryProvider).feed(
          category: f.category,
          type: f.type,
          query: f.query,
          sort: f.sort == 'popular' ? 'popular' : null,
        ),
  );
}

@riverpod
Future<List<Campaign>> bookmarkedCampaigns(Ref ref) async =>
    unwrap(await ref.watch(campaignRepositoryProvider).bookmarked());

/// Optimistic bookmark state (campaignId -> bookmarked) so the heart flips
/// instantly, without refetching the whole feed.
@riverpod
class BookmarkOverrides extends _$BookmarkOverrides {
  @override
  Map<String, bool> build() => {};

  void set(String id, bool value) => state = {...state, id: value};
}

/// Effective bookmark state for [campaign] (optimistic override or server value).
bool effectiveBookmarked(WidgetRef ref, Campaign campaign) =>
    ref.watch(bookmarkOverridesProvider)[campaign.id] ?? campaign.bookmarked;

/// Optimistically toggles [campaign]'s bookmark: flips the UI immediately, then
/// syncs with the server and reverts on failure. Returns false on failure.
Future<bool> toggleCampaignBookmark(WidgetRef ref, Campaign campaign) async {
  final notifier = ref.read(bookmarkOverridesProvider.notifier);
  final current =
      ref.read(bookmarkOverridesProvider)[campaign.id] ?? campaign.bookmarked;
  notifier.set(campaign.id, !current); // instant
  final res =
      await ref.read(campaignRepositoryProvider).toggleBookmark(campaign.id);
  switch (res) {
    case Ok(:final value):
      notifier.set(campaign.id, value);
      ref.invalidate(bookmarkedCampaignsProvider);
      return true;
    case Err():
      notifier.set(campaign.id, current); // revert
      return false;
  }
}

@riverpod
Future<List<Campaign>> myCampaigns(Ref ref) async =>
    unwrap(await ref.watch(campaignRepositoryProvider).myCampaigns());

@riverpod
Future<Campaign> campaignDetail(Ref ref, String id) async =>
    unwrap(await ref.watch(campaignRepositoryProvider).detail(id));
