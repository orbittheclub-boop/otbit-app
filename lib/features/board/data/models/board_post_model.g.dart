// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BoardPostModel _$BoardPostModelFromJson(Map<String, dynamic> json) =>
    _BoardPostModel(
      id: json['id'] as String,
      authorId: json['author_id'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      commentCount: (json['comment_count'] as num?)?.toInt() ?? 0,
      liked: json['liked'] as bool? ?? false,
      createdAt: json['created_at'] as String?,
      author: json['author'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BoardPostModelToJson(_BoardPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author_id': instance.authorId,
      'category': instance.category,
      'title': instance.title,
      'body': instance.body,
      'like_count': instance.likeCount,
      'comment_count': instance.commentCount,
      'liked': instance.liked,
      'created_at': instance.createdAt,
      'author': instance.author,
    };
