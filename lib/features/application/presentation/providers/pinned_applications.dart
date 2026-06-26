import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/core/theme/theme_controller.dart' show sharedPreferencesProvider;

part 'pinned_applications.g.dart';

/// Locally-pinned application IDs — "즐겨찾기" in 내 지원 현황. Stored in
/// shared_preferences, so this is distinct from 내 찜 (campaign_bookmarks), which
/// are server-side saves of campaigns while browsing. Here we just float a few
/// important *applications* to the top so the influencer can track them.
@Riverpod(keepAlive: true)
class PinnedApplications extends _$PinnedApplications {
  static const _key = 'pinned_applications';

  @override
  Set<String> build() =>
      ref.read(sharedPreferencesProvider).getStringList(_key)?.toSet() ??
      <String>{};

  Future<void> toggle(String id) async {
    final next = {...state};
    if (!next.remove(id)) next.add(id);
    state = next;
    await ref
        .read(sharedPreferencesProvider)
        .setStringList(_key, next.toList());
  }
}
