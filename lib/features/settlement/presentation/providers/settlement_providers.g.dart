// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settlementApi)
final settlementApiProvider = SettlementApiProvider._();

final class SettlementApiProvider
    extends $FunctionalProvider<SettlementApi, SettlementApi, SettlementApi>
    with $Provider<SettlementApi> {
  SettlementApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settlementApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settlementApiHash();

  @$internal
  @override
  $ProviderElement<SettlementApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettlementApi create(Ref ref) {
    return settlementApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettlementApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettlementApi>(value),
    );
  }
}

String _$settlementApiHash() => r'3bdfd840ff754e3a73b7d960971685a5156f4317';

@ProviderFor(settlementRepository)
final settlementRepositoryProvider = SettlementRepositoryProvider._();

final class SettlementRepositoryProvider
    extends
        $FunctionalProvider<
          SettlementRepository,
          SettlementRepository,
          SettlementRepository
        >
    with $Provider<SettlementRepository> {
  SettlementRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settlementRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settlementRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettlementRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettlementRepository create(Ref ref) {
    return settlementRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettlementRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettlementRepository>(value),
    );
  }
}

String _$settlementRepositoryHash() =>
    r'9e0dc05a6d598803c2672bf0a494314fe953a32a';

@ProviderFor(mySettlements)
final mySettlementsProvider = MySettlementsProvider._();

final class MySettlementsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Settlement>>,
          List<Settlement>,
          FutureOr<List<Settlement>>
        >
    with $FutureModifier<List<Settlement>>, $FutureProvider<List<Settlement>> {
  MySettlementsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mySettlementsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mySettlementsHash();

  @$internal
  @override
  $FutureProviderElement<List<Settlement>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Settlement>> create(Ref ref) {
    return mySettlements(ref);
  }
}

String _$mySettlementsHash() => r'26a5c8397b77b3cfda875baa21ee2e1b648dcc7c';
