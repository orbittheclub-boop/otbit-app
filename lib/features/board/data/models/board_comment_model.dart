import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:orbit/features/board/domain/entities/board_comment.dart';

part 'board_comment_model.freezed.dart';
part 'board_comment_model.g.dart';

/// DTO mirroring a `board_comments` row (with embedded `author` profile).
@freezed
abstract class BoardCommentModel with _$BoardCommentModel {
  const BoardCommentModel._();

  const factory BoardCommentModel({
    required String id,
    @JsonKey(name: 'author_id') required String authorId,
    required String body,
    @JsonKey(name: 'created_at') String? createdAt,
    Map<String, dynamic>? author,
  }) = _BoardCommentModel;

  factory BoardCommentModel.fromJson(Map<String, dynamic> json) =>
      _$BoardCommentModelFromJson(json);

  BoardComment toEntity() => BoardComment(
        id: id,
        authorId: authorId,
        body: body,
        authorName: (author?['display_name'] as String?) ?? '익명',
        authorAvatarUrl: author?['avatar_url'] as String?,
        authorRole: author?['role'] as String?,
        createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
      );
}
