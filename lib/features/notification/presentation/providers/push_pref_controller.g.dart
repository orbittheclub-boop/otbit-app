// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_pref_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The user's push-notification on/off state, persisted in shared_preferences
/// so the profile screen renders the toggle instantly (synchronous read — no
/// async OS query, no flicker). Backed by the real OS permission via
/// permission_handler + the backend token registration.

@ProviderFor(PushPrefController)
final pushPrefControllerProvider = PushPrefControllerProvider._();

/// The user's push-notification on/off state, persisted in shared_preferences
/// so the profile screen renders the toggle instantly (synchronous read — no
/// async OS query, no flicker). Backed by the real OS permission via
/// permission_handler + the backend token registration.
final class PushPrefControllerProvider
    extends $NotifierProvider<PushPrefController, bool> {
  /// The user's push-notification on/off state, persisted in shared_preferences
  /// so the profile screen renders the toggle instantly (synchronous read — no
  /// async OS query, no flicker). Backed by the real OS permission via
  /// permission_handler + the backend token registration.
  PushPrefControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushPrefControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushPrefControllerHash();

  @$internal
  @override
  PushPrefController create() => PushPrefController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$pushPrefControllerHash() =>
    r'a90cfd91f30216ffe276556a398a643330e51d98';

/// The user's push-notification on/off state, persisted in shared_preferences
/// so the profile screen renders the toggle instantly (synchronous read — no
/// async OS query, no flicker). Backed by the real OS permission via
/// permission_handler + the backend token registration.

abstract class _$PushPrefController extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
