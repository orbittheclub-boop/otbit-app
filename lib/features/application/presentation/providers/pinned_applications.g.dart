// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pinned_applications.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Locally-pinned application IDs — "즐겨찾기" in 내 지원 현황. Stored in
/// shared_preferences, so this is distinct from 내 찜 (campaign_bookmarks), which
/// are server-side saves of campaigns while browsing. Here we just float a few
/// important *applications* to the top so the influencer can track them.

@ProviderFor(PinnedApplications)
final pinnedApplicationsProvider = PinnedApplicationsProvider._();

/// Locally-pinned application IDs — "즐겨찾기" in 내 지원 현황. Stored in
/// shared_preferences, so this is distinct from 내 찜 (campaign_bookmarks), which
/// are server-side saves of campaigns while browsing. Here we just float a few
/// important *applications* to the top so the influencer can track them.
final class PinnedApplicationsProvider
    extends $NotifierProvider<PinnedApplications, Set<String>> {
  /// Locally-pinned application IDs — "즐겨찾기" in 내 지원 현황. Stored in
  /// shared_preferences, so this is distinct from 내 찜 (campaign_bookmarks), which
  /// are server-side saves of campaigns while browsing. Here we just float a few
  /// important *applications* to the top so the influencer can track them.
  PinnedApplicationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pinnedApplicationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pinnedApplicationsHash();

  @$internal
  @override
  PinnedApplications create() => PinnedApplications();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$pinnedApplicationsHash() =>
    r'dceb2de148a28d717e018b6a0ff809edb424d506';

/// Locally-pinned application IDs — "즐겨찾기" in 내 지원 현황. Stored in
/// shared_preferences, so this is distinct from 내 찜 (campaign_bookmarks), which
/// are server-side saves of campaigns while browsing. Here we just float a few
/// important *applications* to the top so the influencer can track them.

abstract class _$PinnedApplications extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
