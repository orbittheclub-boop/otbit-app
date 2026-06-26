// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BoardCommentModel _$BoardCommentModelFromJson(Map<String, dynamic> json) =>
    _BoardCommentModel(
      id: json['id'] as String,
      authorId: json['author_id'] as String,
      body: json['body'] as String,
      createdAt: json['created_at'] as String?,
      author: json['author'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BoardCommentModelToJson(_BoardCommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author_id': instance.authorId,
      'body': instance.body,
      'created_at': instance.createdAt,
      'author': instance.author,
    };
