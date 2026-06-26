import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_comment.freezed.dart';

/// A comment on a board post.
@freezed
abstract class BoardComment with _$BoardComment {
  const factory BoardComment({
    required String id,
    required String authorId,
    required String body,
    required String authorName,
    String? authorAvatarUrl,
    String? authorRole,
    DateTime? createdAt,
  }) = _BoardComment;
}
