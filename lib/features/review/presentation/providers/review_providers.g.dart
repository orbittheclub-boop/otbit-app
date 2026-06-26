// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reviewApi)
final reviewApiProvider = ReviewApiProvider._();

final class ReviewApiProvider
    extends $FunctionalProvider<ReviewApi, ReviewApi, ReviewApi>
    with $Provider<ReviewApi> {
  ReviewApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reviewApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reviewApiHash();

  @$internal
  @override
  $ProviderElement<ReviewApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReviewApi create(Ref ref) {
    return reviewApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReviewApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReviewApi>(value),
    );
  }
}

String _$reviewApiHash() => r'5a9da6ee362dd1cdfe02f8d8a056ca5308c0d6fd';

@ProviderFor(reviewRepository)
final reviewRepositoryProvider = ReviewRepositoryProvider._();

final class ReviewRepositoryProvider
    extends
        $FunctionalProvider<
          ReviewRepository,
          ReviewRepository,
          ReviewRepository
        >
    with $Provider<ReviewRepository> {
  ReviewRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reviewRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reviewRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReviewRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReviewRepository create(Ref ref) {
    return reviewRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReviewRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReviewRepository>(value),
    );
  }
}

String _$reviewRepositoryHash() => r'2a94fb299ea16d7cb5df8c62cb55d7f199a947ab';
