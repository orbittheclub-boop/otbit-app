import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/core/theme/theme_controller.dart';

part 'recent_emails.g.dart';

/// Locally remembered emails for the login screen's quick-pick dropdown.
/// Persisted in shared_preferences; most-recent first, capped to [_max].
@Riverpod(keepAlive: true)
class RecentEmails extends _$RecentEmails {
  static const _key = 'recent_emails';
  static const _max = 5;

  @override
  List<String> build() =>
      ref.read(sharedPreferencesProvider).getStringList(_key) ?? const [];

  Future<void> add(String email) async {
    final e = email.trim();
    if (e.isEmpty) return;
    final list = [e, ...state.where((x) => x != e)].take(_max).toList();
    state = list;
    await ref.read(sharedPreferencesProvider).setStringList(_key, list);
  }

  Future<void> remove(String email) async {
    final list = state.where((x) => x != email).toList();
    state = list;
    await ref.read(sharedPreferencesProvider).setStringList(_key, list);
  }
}
