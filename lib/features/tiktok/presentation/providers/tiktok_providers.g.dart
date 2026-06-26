// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tiktok_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tiktokApi)
final tiktokApiProvider = TiktokApiProvider._();

final class TiktokApiProvider
    extends $FunctionalProvider<TiktokApi, TiktokApi, TiktokApi>
    with $Provider<TiktokApi> {
  TiktokApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tiktokApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tiktokApiHash();

  @$internal
  @override
  $ProviderElement<TiktokApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TiktokApi create(Ref ref) {
    return tiktokApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TiktokApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TiktokApi>(value),
    );
  }
}

String _$tiktokApiHash() => r'fb3bf9a6719ad86d04b669e7002b1796dd1f364e';

@ProviderFor(tiktokRepository)
final tiktokRepositoryProvider = TiktokRepositoryProvider._();

final class TiktokRepositoryProvider
    extends
        $FunctionalProvider<
          TiktokRepository,
          TiktokRepository,
          TiktokRepository
        >
    with $Provider<TiktokRepository> {
  TiktokRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tiktokRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tiktokRepositoryHash();

  @$internal
  @override
  $ProviderElement<TiktokRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TiktokRepository create(Ref ref) {
    return tiktokRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TiktokRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TiktokRepository>(value),
    );
  }
}

String _$tiktokRepositoryHash() => r'5c89d88fd1232e8a03fce0716396cd3b5f5347bc';

@ProviderFor(tiktokAccount)
final tiktokAccountProvider = TiktokAccountProvider._();

final class TiktokAccountProvider
    extends
        $FunctionalProvider<
          AsyncValue<TiktokAccount?>,
          TiktokAccount?,
          FutureOr<TiktokAccount?>
        >
    with $FutureModifier<TiktokAccount?>, $FutureProvider<TiktokAccount?> {
  TiktokAccountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tiktokAccountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tiktokAccountHash();

  @$internal
  @override
  $FutureProviderElement<TiktokAccount?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TiktokAccount?> create(Ref ref) {
    return tiktokAccount(ref);
  }
}

String _$tiktokAccountHash() => r'453b1e42ff8f487e746b11844d1c42fa1a0b6e58';
