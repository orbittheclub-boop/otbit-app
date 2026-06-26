// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileApi)
final profileApiProvider = ProfileApiProvider._();

final class ProfileApiProvider
    extends $FunctionalProvider<ProfileApi, ProfileApi, ProfileApi>
    with $Provider<ProfileApi> {
  ProfileApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileApiHash();

  @$internal
  @override
  $ProviderElement<ProfileApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProfileApi create(Ref ref) {
    return profileApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileApi>(value),
    );
  }
}

String _$profileApiHash() => r'c735db8ac68aed9f076467560b92e0ab4ccd0fd4';

/// Auth boundary — impl injected here; swap this one provider for AWS Cognito.

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

/// Auth boundary — impl injected here; swap this one provider for AWS Cognito.

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// Auth boundary — impl injected here; swap this one provider for AWS Cognito.
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'4e4da0b1c4662175691ceb82ba9b029400930fb1';
