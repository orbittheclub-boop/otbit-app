import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/board/domain/entities/board_comment.dart';
import 'package:orbit/features/board/domain/entities/board_post.dart';
import 'package:orbit/features/board/domain/entities/board_post_input.dart';

/// Post + its comments, returned by [BoardRepository.detail].
typedef BoardDetailData = ({BoardPost post, List<BoardComment> comments});

/// Result of toggling a like.
typedef LikeResult = ({bool liked, int likeCount});

/// Community board boundary (over the `board` Edge Function).
abstract interface class BoardRepository {
  Future<Result<List<BoardPost>>> feed({String? category});

  /// Synchronously reads the locally cached posts for [category] (may be empty).
  /// Used to show content instantly before the network refresh completes.
  List<BoardPost> cachedFeed({String? category});
  Future<Result<BoardDetailData>> detail(String id);
  Future<Result<BoardPost>> create(BoardPostInput input);
  Future<Result<void>> deletePost(String id);
  Future<Result<LikeResult>> toggleLike(String id);
  Future<Result<void>> addComment(String postId, String body);
  Future<Result<void>> deleteComment(String postId, String commentId);
}
