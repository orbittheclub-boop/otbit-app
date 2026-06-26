// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_pref_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Last FCM registration status, for on-screen diagnostics (temporary).

@ProviderFor(FcmDebug)
final fcmDebugProvider = FcmDebugProvider._();

/// Last FCM registration status, for on-screen diagnostics (temporary).
final class FcmDebugProvider extends $NotifierProvider<FcmDebug, String> {
  /// Last FCM registration status, for on-screen diagnostics (temporary).
  FcmDebugProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fcmDebugProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fcmDebugHash();

  @$internal
  @override
  FcmDebug create() => FcmDebug();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$fcmDebugHash() => r'4d57ca8f2d5efb42dfe3f69f479954044c6e3d43';

/// Last FCM registration status, for on-screen diagnostics (temporary).

abstract class _$FcmDebug extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

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
    r'5a967d526450233ac6d5ca4248c9a3e38998f3f3';

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
