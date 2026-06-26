// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(boardApi)
final boardApiProvider = BoardApiProvider._();

final class BoardApiProvider
    extends $FunctionalProvider<BoardApi, BoardApi, BoardApi>
    with $Provider<BoardApi> {
  BoardApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'boardApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$boardApiHash();

  @$internal
  @override
  $ProviderElement<BoardApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BoardApi create(Ref ref) {
    return boardApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BoardApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BoardApi>(value),
    );
  }
}

String _$boardApiHash() => r'34602cf13a376e29b98aad03257d2dd82a311d31';

@ProviderFor(boardRepository)
final boardRepositoryProvider = BoardRepositoryProvider._();

final class BoardRepositoryProvider
    extends
        $FunctionalProvider<BoardRepository, BoardRepository, BoardRepository>
    with $Provider<BoardRepository> {
  BoardRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'boardRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$boardRepositoryHash();

  @$internal
  @override
  $ProviderElement<BoardRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BoardRepository create(Ref ref) {
    return boardRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BoardRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BoardRepository>(value),
    );
  }
}

String _$boardRepositoryHash() => r'3fdb879b2f6952d4008f6861985086b3c0fbe494';

/// Selected board category filter (null = all). The feed re-fetches on change.

@ProviderFor(BoardCategoryFilter)
final boardCategoryFilterProvider = BoardCategoryFilterProvider._();

/// Selected board category filter (null = all). The feed re-fetches on change.
final class BoardCategoryFilterProvider
    extends $NotifierProvider<BoardCategoryFilter, String?> {
  /// Selected board category filter (null = all). The feed re-fetches on change.
  BoardCategoryFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'boardCategoryFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$boardCategoryFilterHash();

  @$internal
  @override
  BoardCategoryFilter create() => BoardCategoryFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$boardCategoryFilterHash() =>
    r'84f910690a6b845968741223d989d6055effec3a';

/// Selected board category filter (null = all). The feed re-fetches on change.

abstract class _$BoardCategoryFilter extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Board feed with stale-while-revalidate: shows the Hive-cached posts for the
/// selected category instantly, then refreshes from the network in the
/// background — so switching category tabs never flashes a loading spinner once
/// a category has been seen.

@ProviderFor(BoardFeed)
final boardFeedProvider = BoardFeedProvider._();

/// Board feed with stale-while-revalidate: shows the Hive-cached posts for the
/// selected category instantly, then refreshes from the network in the
/// background — so switching category tabs never flashes a loading spinner once
/// a category has been seen.
final class BoardFeedProvider
    extends $AsyncNotifierProvider<BoardFeed, List<BoardPost>> {
  /// Board feed with stale-while-revalidate: shows the Hive-cached posts for the
  /// selected category instantly, then refreshes from the network in the
  /// background — so switching category tabs never flashes a loading spinner once
  /// a category has been seen.
  BoardFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'boardFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$boardFeedHash();

  @$internal
  @override
  BoardFeed create() => BoardFeed();
}

String _$boardFeedHash() => r'35825dd88e576fae16ed147557e95999ccc90a85';

/// Board feed with stale-while-revalidate: shows the Hive-cached posts for the
/// selected category instantly, then refreshes from the network in the
/// background — so switching category tabs never flashes a loading spinner once
/// a category has been seen.

abstract class _$BoardFeed extends $AsyncNotifier<List<BoardPost>> {
  FutureOr<List<BoardPost>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<BoardPost>>, List<BoardPost>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BoardPost>>, List<BoardPost>>,
              AsyncValue<List<BoardPost>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(boardDetail)
final boardDetailProvider = BoardDetailFamily._();

final class BoardDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<BoardDetailData>,
          BoardDetailData,
          FutureOr<BoardDetailData>
        >
    with $FutureModifier<BoardDetailData>, $FutureProvider<BoardDetailData> {
  BoardDetailProvider._({
    required BoardDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'boardDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$boardDetailHash();

  @override
  String toString() {
    return r'boardDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<BoardDetailData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BoardDetailData> create(Ref ref) {
    final argument = this.argument as String;
    return boardDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BoardDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$boardDetailHash() => r'2a0c6bea41ac014626630f66fc948c025d2efd37';

final class BoardDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<BoardDetailData>, String> {
  BoardDetailFamily._()
    : super(
        retry: null,
        name: r'boardDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BoardDetailProvider call(String id) =>
      BoardDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'boardDetailProvider';
}
