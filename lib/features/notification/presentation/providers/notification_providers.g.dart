// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationApi)
final notificationApiProvider = NotificationApiProvider._();

final class NotificationApiProvider
    extends
        $FunctionalProvider<NotificationApi, NotificationApi, NotificationApi>
    with $Provider<NotificationApi> {
  NotificationApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationApiHash();

  @$internal
  @override
  $ProviderElement<NotificationApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotificationApi create(Ref ref) {
    return notificationApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationApi>(value),
    );
  }
}

String _$notificationApiHash() => r'eb2cbd11e8f5a5dcb0047bf6f8d990c7f7a22427';

@ProviderFor(notificationRepository)
final notificationRepositoryProvider = NotificationRepositoryProvider._();

final class NotificationRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationRepository,
          NotificationRepository,
          NotificationRepository
        >
    with $Provider<NotificationRepository> {
  NotificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRepository create(Ref ref) {
    return notificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRepository>(value),
    );
  }
}

String _$notificationRepositoryHash() =>
    r'658b90b79da56d26d7a87b3f52a9c80a7ce89a8e';

@ProviderFor(notifications)
final notificationsProvider = NotificationsProvider._();

final class NotificationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<NotificationFeed>,
          NotificationFeed,
          FutureOr<NotificationFeed>
        >
    with $FutureModifier<NotificationFeed>, $FutureProvider<NotificationFeed> {
  NotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsHash();

  @$internal
  @override
  $FutureProviderElement<NotificationFeed> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NotificationFeed> create(Ref ref) {
    return notifications(ref);
  }
}

String _$notificationsHash() => r'f2c1343375fb251f06492c1c46db3e33d007b0e4';
