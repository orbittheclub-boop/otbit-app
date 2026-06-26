// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(campaignApi)
final campaignApiProvider = CampaignApiProvider._();

final class CampaignApiProvider
    extends $FunctionalProvider<CampaignApi, CampaignApi, CampaignApi>
    with $Provider<CampaignApi> {
  CampaignApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'campaignApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campaignApiHash();

  @$internal
  @override
  $ProviderElement<CampaignApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CampaignApi create(Ref ref) {
    return campaignApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CampaignApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CampaignApi>(value),
    );
  }
}

String _$campaignApiHash() => r'33a3106174f16297db30d9c3e785360b1c443914';

@ProviderFor(campaignRepository)
final campaignRepositoryProvider = CampaignRepositoryProvider._();

final class CampaignRepositoryProvider
    extends
        $FunctionalProvider<
          CampaignRepository,
          CampaignRepository,
          CampaignRepository
        >
    with $Provider<CampaignRepository> {
  CampaignRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'campaignRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campaignRepositoryHash();

  @$internal
  @override
  $ProviderElement<CampaignRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CampaignRepository create(Ref ref) {
    return campaignRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CampaignRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CampaignRepository>(value),
    );
  }
}

String _$campaignRepositoryHash() =>
    r'c87479441b9be11731de4ebf1ca9f5127c7ab4db';

@ProviderFor(CampaignFilter)
final campaignFilterProvider = CampaignFilterProvider._();

final class CampaignFilterProvider
    extends $NotifierProvider<CampaignFilter, CampaignFilterState> {
  CampaignFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'campaignFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campaignFilterHash();

  @$internal
  @override
  CampaignFilter create() => CampaignFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CampaignFilterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CampaignFilterState>(value),
    );
  }
}

String _$campaignFilterHash() => r'70133a0ffa11909441eda6a2dfc4930dc17275c7';

abstract class _$CampaignFilter extends $Notifier<CampaignFilterState> {
  CampaignFilterState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CampaignFilterState, CampaignFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CampaignFilterState, CampaignFilterState>,
              CampaignFilterState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(campaignFeed)
final campaignFeedProvider = CampaignFeedProvider._();

final class CampaignFeedProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Campaign>>,
          List<Campaign>,
          FutureOr<List<Campaign>>
        >
    with $FutureModifier<List<Campaign>>, $FutureProvider<List<Campaign>> {
  CampaignFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'campaignFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campaignFeedHash();

  @$internal
  @override
  $FutureProviderElement<List<Campaign>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Campaign>> create(Ref ref) {
    return campaignFeed(ref);
  }
}

String _$campaignFeedHash() => r'183f7fec260e8e09b41e47ddd064fad3eba898a2';

@ProviderFor(bookmarkedCampaigns)
final bookmarkedCampaignsProvider = BookmarkedCampaignsProvider._();

final class BookmarkedCampaignsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Campaign>>,
          List<Campaign>,
          FutureOr<List<Campaign>>
        >
    with $FutureModifier<List<Campaign>>, $FutureProvider<List<Campaign>> {
  BookmarkedCampaignsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookmarkedCampaignsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookmarkedCampaignsHash();

  @$internal
  @override
  $FutureProviderElement<List<Campaign>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Campaign>> create(Ref ref) {
    return bookmarkedCampaigns(ref);
  }
}

String _$bookmarkedCampaignsHash() =>
    r'9f4d55a20368259dd04d3e59f25543d08d021c13';

/// Optimistic bookmark state (campaignId -> bookmarked) so the heart flips
/// instantly, without refetching the whole feed.

@ProviderFor(BookmarkOverrides)
final bookmarkOverridesProvider = BookmarkOverridesProvider._();

/// Optimistic bookmark state (campaignId -> bookmarked) so the heart flips
/// instantly, without refetching the whole feed.
final class BookmarkOverridesProvider
    extends $NotifierProvider<BookmarkOverrides, Map<String, bool>> {
  /// Optimistic bookmark state (campaignId -> bookmarked) so the heart flips
  /// instantly, without refetching the whole feed.
  BookmarkOverridesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookmarkOverridesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookmarkOverridesHash();

  @$internal
  @override
  BookmarkOverrides create() => BookmarkOverrides();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, bool> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, bool>>(value),
    );
  }
}

String _$bookmarkOverridesHash() => r'f827de0dfdb958a5d9135f65ef8c72c224fe538b';

/// Optimistic bookmark state (campaignId -> bookmarked) so the heart flips
/// instantly, without refetching the whole feed.

abstract class _$BookmarkOverrides extends $Notifier<Map<String, bool>> {
  Map<String, bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Map<String, bool>, Map<String, bool>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, bool>, Map<String, bool>>,
              Map<String, bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(myCampaigns)
final myCampaignsProvider = MyCampaignsProvider._();

final class MyCampaignsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Campaign>>,
          List<Campaign>,
          FutureOr<List<Campaign>>
        >
    with $FutureModifier<List<Campaign>>, $FutureProvider<List<Campaign>> {
  MyCampaignsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myCampaignsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myCampaignsHash();

  @$internal
  @override
  $FutureProviderElement<List<Campaign>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Campaign>> create(Ref ref) {
    return myCampaigns(ref);
  }
}

String _$myCampaignsHash() => r'570bcd7f6026ce6d4a8675786d4dfce78efcc9c7';

@ProviderFor(campaignDetail)
final campaignDetailProvider = CampaignDetailFamily._();

final class CampaignDetailProvider
    extends
        $FunctionalProvider<AsyncValue<Campaign>, Campaign, FutureOr<Campaign>>
    with $FutureModifier<Campaign>, $FutureProvider<Campaign> {
  CampaignDetailProvider._({
    required CampaignDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'campaignDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$campaignDetailHash();

  @override
  String toString() {
    return r'campaignDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Campaign> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Campaign> create(Ref ref) {
    final argument = this.argument as String;
    return campaignDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CampaignDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$campaignDetailHash() => r'65c5ad7a6ec4114bf043ccf619a20ccdb3abe090';

final class CampaignDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Campaign>, String> {
  CampaignDetailFamily._()
    : super(
        retry: null,
        name: r'campaignDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CampaignDetailProvider call(String id) =>
      CampaignDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'campaignDetailProvider';
}
