import 'dart:convert';

import 'package:hive/hive.dart';

/// Local Hive cache for the community board feed — enables stale-while-revalidate
/// (show cached posts instantly on tab switch, refresh in the background).
///
/// Keys are category keys (`all` | `free` | `question` | `tip` | `review`); each
/// entry is a JSON string of the raw post list, capped to [_maxPosts] so the
/// cache stays small (at most 5 keys × [_maxPosts]).
class BoardCache {
  BoardCache._();

  static const _boxName = 'board_feed_cache';
  static const _maxPosts = 60;
  static Box<String>? _box;

  static Future<void> init() async {
    _box = await Hive.openBox<String>(_boxName);
  }

  static String _key(String? category) => category ?? 'all';

  /// Raw cached post maps for [category] (empty if nothing cached).
  static List<Map<String, dynamic>> read(String? category) {
    final s = _box?.get(_key(category));
    if (s == null) return const [];
    try {
      return (jsonDecode(s) as List).cast<Map<String, dynamic>>();
    } catch (_) {
      return const [];
    }
  }

  static Future<void> write(
    String? category,
    List<Map<String, dynamic>> posts,
  ) async {
    final box = _box;
    if (box == null) return;
    final capped =
        posts.length > _maxPosts ? posts.sublist(0, _maxPosts) : posts;
    await box.put(_key(category), jsonEncode(capped));
  }
}
