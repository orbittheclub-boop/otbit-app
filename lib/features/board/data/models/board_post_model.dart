import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:orbit/features/board/domain/entities/board_post.dart';

part 'board_post_model.freezed.dart';
part 'board_post_model.g.dart';

/// DTO mirroring a `board_posts` row (with embedded `author` profile).
@freezed
abstract class BoardPostModel with _$BoardPostModel {
  const BoardPostModel._();

  const factory BoardPostModel({
    required String id,
    @JsonKey(name: 'author_id') required String authorId,
    required String category,
    required String title,
    required String body,
    @JsonKey(name: 'like_count') @Default(0) int likeCount,
    @JsonKey(name: 'comment_count') @Default(0) int commentCount,
    @Default(false) bool liked,
    @JsonKey(name: 'created_at') String? createdAt,
    Map<String, dynamic>? author,
  }) = _BoardPostModel;

  factory BoardPostModel.fromJson(Map<String, dynamic> json) =>
      _$BoardPostModelFromJson(json);

  BoardPost toEntity() => BoardPost(
        id: id,
        authorId: authorId,
        category: category,
        title: title,
        body: body,
        authorName: (author?['display_name'] as String?) ?? '익명',
        authorAvatarUrl: author?['avatar_url'] as String?,
        authorRole: author?['role'] as String?,
        likeCount: likeCount,
        commentCount: commentCount,
        liked: liked,
        createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
      );
}
