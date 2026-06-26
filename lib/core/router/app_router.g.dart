// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Router driven by [authControllerProvider]. Each role lands on a bottom-nav
/// shell (StatefulShellRoute keeps each tab's state). Detail/form screens are
/// top-level routes so they cover the bottom navigation.

@ProviderFor(goRouter)
final goRouterProvider = GoRouterProvider._();

/// Router driven by [authControllerProvider]. Each role lands on a bottom-nav
/// shell (StatefulShellRoute keeps each tab's state). Detail/form screens are
/// top-level routes so they cover the bottom navigation.

final class GoRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// Router driven by [authControllerProvider]. Each role lands on a bottom-nav
  /// shell (StatefulShellRoute keeps each tab's state). Detail/form screens are
  /// top-level routes so they cover the bottom navigation.
  GoRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return goRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$goRouterHash() => r'492d7a0ee545c669990613ab38e602492067c686';
