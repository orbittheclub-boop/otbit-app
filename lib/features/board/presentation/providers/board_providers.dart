import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/core/providers/app_providers.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/board/data/datasources/board_api.dart';
import 'package:orbit/features/board/data/repositories/board_repository_impl.dart';
import 'package:orbit/features/board/domain/entities/board_post.dart';
import 'package:orbit/features/board/domain/repositories/board_repository.dart';

part 'board_providers.g.dart';

@Riverpod(keepAlive: true)
BoardApi boardApi(Ref ref) => BoardApi(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
BoardRepository boardRepository(Ref ref) =>
    BoardRepositoryImpl(ref.watch(boardApiProvider));

/// Selected board category filter (null = all). The feed re-fetches on change.
@riverpod
class BoardCategoryFilter extends _$BoardCategoryFilter {
  @override
  String? build() => null;

  void select(String? category) => state = category;
}

/// Board feed with stale-while-revalidate: shows the Hive-cached posts for the
/// selected category instantly, then refreshes from the network in the
/// background — so switching category tabs never flashes a loading spinner once
/// a category has been seen.
@riverpod
class BoardFeed extends _$BoardFeed {
  @override
  Future<List<BoardPost>> build() async {
    final category = ref.watch(boardCategoryFilterProvider);
    final repo = ref.read(boardRepositoryProvider);

    final cached = repo.cachedFeed(category: category);
    if (cached.isNotEmpty) {
      // Refresh in the background; update only if still on this category.
      Future.microtask(() async {
        try {
          final res = await repo.feed(category: category);
          if (ref.read(boardCategoryFilterProvider) != category) return;
          switch (res) {
            case Ok(:final value):
              state = AsyncData(value);
            case Err():
              break; // keep the cached posts on failure
          }
        } catch (_) {/* provider disposed — ignore */}
      });
      return cached;
    }

    // No cache yet → normal load (spinner once, then cached for next time).
    return unwrap(await repo.feed(category: category));
  }
}

@riverpod
Future<BoardDetailData> boardDetail(Ref ref, String id) async =>
    unwrap(await ref.watch(boardRepositoryProvider).detail(id));
