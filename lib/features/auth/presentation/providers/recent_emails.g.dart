// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_emails.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Locally remembered emails for the login screen's quick-pick dropdown.
/// Persisted in shared_preferences; most-recent first, capped to [_max].

@ProviderFor(RecentEmails)
final recentEmailsProvider = RecentEmailsProvider._();

/// Locally remembered emails for the login screen's quick-pick dropdown.
/// Persisted in shared_preferences; most-recent first, capped to [_max].
final class RecentEmailsProvider
    extends $NotifierProvider<RecentEmails, List<String>> {
  /// Locally remembered emails for the login screen's quick-pick dropdown.
  /// Persisted in shared_preferences; most-recent first, capped to [_max].
  RecentEmailsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentEmailsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentEmailsHash();

  @$internal
  @override
  RecentEmails create() => RecentEmails();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$recentEmailsHash() => r'ac237bb0a960c001089c30b6bb1032322b0c42c0';

/// Locally remembered emails for the login screen's quick-pick dropdown.
/// Persisted in shared_preferences; most-recent first, capped to [_max].

abstract class _$RecentEmails extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>, List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
