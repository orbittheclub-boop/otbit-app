import 'dart:convert';

import 'package:hive/hive.dart';

/// Local Hive cache for the influencer's bookmarked campaigns — enables
/// stale-while-revalidate (show saved campaigns instantly, refresh in the
/// background) just like [BoardCache] does for the board feed.
class BookmarkCache {
  BookmarkCache._();

  static const _boxName = 'bookmark_cache';
  static const _key = 'bookmarked';
  static const _max = 100;
  static Box<String>? _box;

  static Future<void> init() async {
    _box = await Hive.openBox<String>(_boxName);
  }

  /// Raw cached campaign maps (empty if nothing cached).
  static List<Map<String, dynamic>> read() {
    final s = _box?.get(_key);
    if (s == null) return const [];
    try {
      return (jsonDecode(s) as List).cast<Map<String, dynamic>>();
    } catch (_) {
      return const [];
    }
  }

  static Future<void> write(List<Map<String, dynamic>> items) async {
    final box = _box;
    if (box == null) return;
    final capped = items.length > _max ? items.sublist(0, _max) : items;
    await box.put(_key, jsonEncode(capped));
  }
}
