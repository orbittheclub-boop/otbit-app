import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_post.freezed.dart';

/// Fixed board categories. The stored key is the enum name; labels are i18n.
enum BoardCategory { free, question, tip, review }

BoardCategory? boardCategoryFromKey(String? key) => switch (key) {
      'free' => BoardCategory.free,
      'question' => BoardCategory.question,
      'tip' => BoardCategory.tip,
      'review' => BoardCategory.review,
      _ => null,
    };

/// A community board post (Picky-style discussion board).
@freezed
abstract class BoardPost with _$BoardPost {
  const factory BoardPost({
    required String id,
    required String authorId,
    required String category,
    required String title,
    required String body,
    required String authorName,
    String? authorAvatarUrl,
    String? authorRole,
    @Default(0) int likeCount,
    @Default(0) int commentCount,
    @Default(false) bool liked,
    DateTime? createdAt,
  }) = _BoardPost;
}
