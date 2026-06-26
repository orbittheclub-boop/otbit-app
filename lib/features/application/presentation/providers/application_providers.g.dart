// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(applicationApi)
final applicationApiProvider = ApplicationApiProvider._();

final class ApplicationApiProvider
    extends $FunctionalProvider<ApplicationApi, ApplicationApi, ApplicationApi>
    with $Provider<ApplicationApi> {
  ApplicationApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'applicationApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$applicationApiHash();

  @$internal
  @override
  $ProviderElement<ApplicationApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApplicationApi create(Ref ref) {
    return applicationApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApplicationApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApplicationApi>(value),
    );
  }
}

String _$applicationApiHash() => r'cc8c80e479d29b75a592bebe347aa12fc74981bd';

@ProviderFor(applicationRepository)
final applicationRepositoryProvider = ApplicationRepositoryProvider._();

final class ApplicationRepositoryProvider
    extends
        $FunctionalProvider<
          ApplicationRepository,
          ApplicationRepository,
          ApplicationRepository
        >
    with $Provider<ApplicationRepository> {
  ApplicationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'applicationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$applicationRepositoryHash();

  @$internal
  @override
  $ProviderElement<ApplicationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ApplicationRepository create(Ref ref) {
    return applicationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApplicationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApplicationRepository>(value),
    );
  }
}

String _$applicationRepositoryHash() =>
    r'6b9add4ce083add178b165ef1ef0105d32e6ab01';

@ProviderFor(myApplications)
final myApplicationsProvider = MyApplicationsProvider._();

final class MyApplicationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Application>>,
          List<Application>,
          FutureOr<List<Application>>
        >
    with
        $FutureModifier<List<Application>>,
        $FutureProvider<List<Application>> {
  MyApplicationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myApplicationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myApplicationsHash();

  @$internal
  @override
  $FutureProviderElement<List<Application>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Application>> create(Ref ref) {
    return myApplications(ref);
  }
}

String _$myApplicationsHash() => r'cf6ce74015105f0a4b8cd1d43f355ffee184725a';

@ProviderFor(applicants)
final applicantsProvider = ApplicantsFamily._();

final class ApplicantsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Application>>,
          List<Application>,
          FutureOr<List<Application>>
        >
    with
        $FutureModifier<List<Application>>,
        $FutureProvider<List<Application>> {
  ApplicantsProvider._({
    required ApplicantsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'applicantsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$applicantsHash();

  @override
  String toString() {
    return r'applicantsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Application>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Application>> create(Ref ref) {
    final argument = this.argument as String;
    return applicants(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ApplicantsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$applicantsHash() => r'b42506688af4255b4d018548d845e5f03baeaa2e';

final class ApplicantsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Application>>, String> {
  ApplicantsFamily._()
    : super(
        retry: null,
        name: r'applicantsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ApplicantsProvider call(String campaignId) =>
      ApplicantsProvider._(argument: campaignId, from: this);

  @override
  String toString() => r'applicantsProvider';
}
