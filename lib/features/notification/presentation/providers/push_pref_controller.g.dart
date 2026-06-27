// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_pref_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Last FCM registration status, for on-screen diagnostics (temporary).
/// keepAlive so a status set before the profile tile mounts isn't lost to
/// auto-dispose (which would leave the row showing the initial 'idle').

@ProviderFor(FcmDebug)
final fcmDebugProvider = FcmDebugProvider._();

/// Last FCM registration status, for on-screen diagnostics (temporary).
/// keepAlive so a status set before the profile tile mounts isn't lost to
/// auto-dispose (which would leave the row showing the initial 'idle').
final class FcmDebugProvider extends $NotifierProvider<FcmDebug, String> {
  /// Last FCM registration status, for on-screen diagnostics (temporary).
  /// keepAlive so a status set before the profile tile mounts isn't lost to
  /// auto-dispose (which would leave the row showing the initial 'idle').
  FcmDebugProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fcmDebugProvider',
        isAutoDispose: false,
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

String _$fcmDebugHash() => r'a934e40d8c537baa9814b4684cef75f252fdbfcb';

/// Last FCM registration status, for on-screen diagnostics (temporary).
/// keepAlive so a status set before the profile tile mounts isn't lost to
/// auto-dispose (which would leave the row showing the initial 'idle').

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
    r'5bde6f96fadf7da95eab3d167e9767c629b0ce24';

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
