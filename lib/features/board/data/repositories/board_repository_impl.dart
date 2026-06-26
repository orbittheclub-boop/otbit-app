import 'package:orbit/core/cache/board_cache.dart';
import 'package:orbit/core/network/network_guard.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/board/data/datasources/board_api.dart';
import 'package:orbit/features/board/data/models/board_comment_model.dart';
import 'package:orbit/features/board/data/models/board_post_model.dart';
import 'package:orbit/features/board/domain/entities/board_post.dart';
import 'package:orbit/features/board/domain/entities/board_post_input.dart';
import 'package:orbit/features/board/domain/repositories/board_repository.dart';

class BoardRepositoryImpl implements BoardRepository {
  BoardRepositoryImpl(this._api);

  final BoardApi _api;

  BoardPost _parsePost(dynamic res) => BoardPostModel.fromJson(
        res['data']['post'] as Map<String, dynamic>,
      ).toEntity();

  List<BoardPost> _mapRaw(List<Map<String, dynamic>> raw) =>
      raw.map((j) => BoardPostModel.fromJson(j).toEntity()).toList();

  @override
  Future<Result<List<BoardPost>>> feed({String? category}) =>
      guard(() async {
        final res = await _api.list(category);
        final raw =
            ((res['data']['posts']) as List).cast<Map<String, dynamic>>();
        await BoardCache.write(category, raw); // refresh local cache
        return _mapRaw(raw);
      });

  @override
  List<BoardPost> cachedFeed({String? category}) =>
      _mapRaw(BoardCache.read(category));

  @override
  Future<Result<BoardDetailData>> detail(String id) => guard(() async {
        final res = await _api.detail(id);
        final post = BoardPostModel.fromJson(
          res['data']['post'] as Map<String, dynamic>,
        ).toEntity();
        final comments = ((res['data']['comments']) as List)
            .cast<Map<String, dynamic>>()
            .map((j) => BoardCommentModel.fromJson(j).toEntity())
            .toList();
        return (post: post, comments: comments);
      });

  @override
  Future<Result<BoardPost>> create(BoardPostInput input) =>
      guard(() async => _parsePost(await _api.create({
            'category': input.category,
            'title': input.title,
            'body': input.body,
          })));

  @override
  Future<Result<void>> deletePost(String id) => guard(() => _api.remove(id));

  @override
  Future<Result<LikeResult>> toggleLike(String id) => guard(() async {
        final res = await _api.like(id);
        final d = res['data'] as Map<String, dynamic>;
        return (
          liked: d['liked'] as bool,
          likeCount: (d['like_count'] as num).toInt(),
        );
      });

  @override
  Future<Result<void>> addComment(String postId, String body) =>
      guard(() => _api.addComment(postId, {'body': body}));

  @override
  Future<Result<void>> deleteComment(String postId, String commentId) =>
      guard(() => _api.deleteComment(postId, commentId));
}
