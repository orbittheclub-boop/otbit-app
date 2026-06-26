// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BoardPost {

 String get id; String get authorId; String get category; String get title; String get body; String get authorName; String? get authorAvatarUrl; String? get authorRole; int get likeCount; int get commentCount; bool get liked; DateTime? get createdAt;
/// Create a copy of BoardPost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardPostCopyWith<BoardPost> get copyWith => _$BoardPostCopyWithImpl<BoardPost>(this as BoardPost, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardPost&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.category, category) || other.category == category)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorAvatarUrl, authorAvatarUrl) || other.authorAvatarUrl == authorAvatarUrl)&&(identical(other.authorRole, authorRole) || other.authorRole == authorRole)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.liked, liked) || other.liked == liked)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,authorId,category,title,body,authorName,authorAvatarUrl,authorRole,likeCount,commentCount,liked,createdAt);

@override
String toString() {
  return 'BoardPost(id: $id, authorId: $authorId, category: $category, title: $title, body: $body, authorName: $authorName, authorAvatarUrl: $authorAvatarUrl, authorRole: $authorRole, likeCount: $likeCount, commentCount: $commentCount, liked: $liked, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BoardPostCopyWith<$Res>  {
  factory $BoardPostCopyWith(BoardPost value, $Res Function(BoardPost) _then) = _$BoardPostCopyWithImpl;
@useResult
$Res call({
 String id, String authorId, String category, String title, String body, String authorName, String? authorAvatarUrl, String? authorRole, int likeCount, int commentCount, bool liked, DateTime? createdAt
});




}
/// @nodoc
class _$BoardPostCopyWithImpl<$Res>
    implements $BoardPostCopyWith<$Res> {
  _$BoardPostCopyWithImpl(this._self, this._then);

  final BoardPost _self;
  final $Res Function(BoardPost) _then;

/// Create a copy of BoardPost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorId = null,Object? category = null,Object? title = null,Object? body = null,Object? authorName = null,Object? authorAvatarUrl = freezed,Object? authorRole = freezed,Object? likeCount = null,Object? commentCount = null,Object? liked = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorAvatarUrl: freezed == authorAvatarUrl ? _self.authorAvatarUrl : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,authorRole: freezed == authorRole ? _self.authorRole : authorRole // ignore: cast_nullable_to_non_nullable
as String?,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardPost].
extension BoardPostPatterns on BoardPost {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardPost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardPost() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardPost value)  $default,){
final _that = this;
switch (_that) {
case _BoardPost():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardPost value)?  $default,){
final _that = this;
switch (_that) {
case _BoardPost() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String authorId,  String category,  String title,  String body,  String authorName,  String? authorAvatarUrl,  String? authorRole,  int likeCount,  int commentCount,  bool liked,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardPost() when $default != null:
return $default(_that.id,_that.authorId,_that.category,_that.title,_that.body,_that.authorName,_that.authorAvatarUrl,_that.authorRole,_that.likeCount,_that.commentCount,_that.liked,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String authorId,  String category,  String title,  String body,  String authorName,  String? authorAvatarUrl,  String? authorRole,  int likeCount,  int commentCount,  bool liked,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _BoardPost():
return $default(_that.id,_that.authorId,_that.category,_that.title,_that.body,_that.authorName,_that.authorAvatarUrl,_that.authorRole,_that.likeCount,_that.commentCount,_that.liked,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String authorId,  String category,  String title,  String body,  String authorName,  String? authorAvatarUrl,  String? authorRole,  int likeCount,  int commentCount,  bool liked,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BoardPost() when $default != null:
return $default(_that.id,_that.authorId,_that.category,_that.title,_that.body,_that.authorName,_that.authorAvatarUrl,_that.authorRole,_that.likeCount,_that.commentCount,_that.liked,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _BoardPost implements BoardPost {
  const _BoardPost({required this.id, required this.authorId, required this.category, required this.title, required this.body, required this.authorName, this.authorAvatarUrl, this.authorRole, this.likeCount = 0, this.commentCount = 0, this.liked = false, this.createdAt});
  

@override final  String id;
@override final  String authorId;
@override final  String category;
@override final  String title;
@override final  String body;
@override final  String authorName;
@override final  String? authorAvatarUrl;
@override final  String? authorRole;
@override@JsonKey() final  int likeCount;
@override@JsonKey() final  int commentCount;
@override@JsonKey() final  bool liked;
@override final  DateTime? createdAt;

/// Create a copy of BoardPost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardPostCopyWith<_BoardPost> get copyWith => __$BoardPostCopyWithImpl<_BoardPost>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardPost&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.category, category) || other.category == category)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorAvatarUrl, authorAvatarUrl) || other.authorAvatarUrl == authorAvatarUrl)&&(identical(other.authorRole, authorRole) || other.authorRole == authorRole)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.liked, liked) || other.liked == liked)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,authorId,category,title,body,authorName,authorAvatarUrl,authorRole,likeCount,commentCount,liked,createdAt);

@override
String toString() {
  return 'BoardPost(id: $id, authorId: $authorId, category: $category, title: $title, body: $body, authorName: $authorName, authorAvatarUrl: $authorAvatarUrl, authorRole: $authorRole, likeCount: $likeCount, commentCount: $commentCount, liked: $liked, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BoardPostCopyWith<$Res> implements $BoardPostCopyWith<$Res> {
  factory _$BoardPostCopyWith(_BoardPost value, $Res Function(_BoardPost) _then) = __$BoardPostCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorId, String category, String title, String body, String authorName, String? authorAvatarUrl, String? authorRole, int likeCount, int commentCount, bool liked, DateTime? createdAt
});




}
/// @nodoc
class __$BoardPostCopyWithImpl<$Res>
    implements _$BoardPostCopyWith<$Res> {
  __$BoardPostCopyWithImpl(this._self, this._then);

  final _BoardPost _self;
  final $Res Function(_BoardPost) _then;

/// Create a copy of BoardPost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? category = null,Object? title = null,Object? body = null,Object? authorName = null,Object? authorAvatarUrl = freezed,Object? authorRole = freezed,Object? likeCount = null,Object? commentCount = null,Object? liked = null,Object? createdAt = freezed,}) {
  return _then(_BoardPost(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorAvatarUrl: freezed == authorAvatarUrl ? _self.authorAvatarUrl : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,authorRole: freezed == authorRole ? _self.authorRole : authorRole // ignore: cast_nullable_to_non_nullable
as String?,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
