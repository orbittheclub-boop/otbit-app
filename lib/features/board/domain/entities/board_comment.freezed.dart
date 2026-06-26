// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BoardComment {

 String get id; String get authorId; String get body; String get authorName; String? get authorAvatarUrl; String? get authorRole; DateTime? get createdAt;
/// Create a copy of BoardComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardCommentCopyWith<BoardComment> get copyWith => _$BoardCommentCopyWithImpl<BoardComment>(this as BoardComment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardComment&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.body, body) || other.body == body)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorAvatarUrl, authorAvatarUrl) || other.authorAvatarUrl == authorAvatarUrl)&&(identical(other.authorRole, authorRole) || other.authorRole == authorRole)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,authorId,body,authorName,authorAvatarUrl,authorRole,createdAt);

@override
String toString() {
  return 'BoardComment(id: $id, authorId: $authorId, body: $body, authorName: $authorName, authorAvatarUrl: $authorAvatarUrl, authorRole: $authorRole, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BoardCommentCopyWith<$Res>  {
  factory $BoardCommentCopyWith(BoardComment value, $Res Function(BoardComment) _then) = _$BoardCommentCopyWithImpl;
@useResult
$Res call({
 String id, String authorId, String body, String authorName, String? authorAvatarUrl, String? authorRole, DateTime? createdAt
});




}
/// @nodoc
class _$BoardCommentCopyWithImpl<$Res>
    implements $BoardCommentCopyWith<$Res> {
  _$BoardCommentCopyWithImpl(this._self, this._then);

  final BoardComment _self;
  final $Res Function(BoardComment) _then;

/// Create a copy of BoardComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorId = null,Object? body = null,Object? authorName = null,Object? authorAvatarUrl = freezed,Object? authorRole = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorAvatarUrl: freezed == authorAvatarUrl ? _self.authorAvatarUrl : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,authorRole: freezed == authorRole ? _self.authorRole : authorRole // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardComment].
extension BoardCommentPatterns on BoardComment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardComment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardComment value)  $default,){
final _that = this;
switch (_that) {
case _BoardComment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardComment value)?  $default,){
final _that = this;
switch (_that) {
case _BoardComment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String authorId,  String body,  String authorName,  String? authorAvatarUrl,  String? authorRole,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardComment() when $default != null:
return $default(_that.id,_that.authorId,_that.body,_that.authorName,_that.authorAvatarUrl,_that.authorRole,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String authorId,  String body,  String authorName,  String? authorAvatarUrl,  String? authorRole,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _BoardComment():
return $default(_that.id,_that.authorId,_that.body,_that.authorName,_that.authorAvatarUrl,_that.authorRole,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String authorId,  String body,  String authorName,  String? authorAvatarUrl,  String? authorRole,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BoardComment() when $default != null:
return $default(_that.id,_that.authorId,_that.body,_that.authorName,_that.authorAvatarUrl,_that.authorRole,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _BoardComment implements BoardComment {
  const _BoardComment({required this.id, required this.authorId, required this.body, required this.authorName, this.authorAvatarUrl, this.authorRole, this.createdAt});
  

@override final  String id;
@override final  String authorId;
@override final  String body;
@override final  String authorName;
@override final  String? authorAvatarUrl;
@override final  String? authorRole;
@override final  DateTime? createdAt;

/// Create a copy of BoardComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardCommentCopyWith<_BoardComment> get copyWith => __$BoardCommentCopyWithImpl<_BoardComment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardComment&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.body, body) || other.body == body)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorAvatarUrl, authorAvatarUrl) || other.authorAvatarUrl == authorAvatarUrl)&&(identical(other.authorRole, authorRole) || other.authorRole == authorRole)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,authorId,body,authorName,authorAvatarUrl,authorRole,createdAt);

@override
String toString() {
  return 'BoardComment(id: $id, authorId: $authorId, body: $body, authorName: $authorName, authorAvatarUrl: $authorAvatarUrl, authorRole: $authorRole, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BoardCommentCopyWith<$Res> implements $BoardCommentCopyWith<$Res> {
  factory _$BoardCommentCopyWith(_BoardComment value, $Res Function(_BoardComment) _then) = __$BoardCommentCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorId, String body, String authorName, String? authorAvatarUrl, String? authorRole, DateTime? createdAt
});




}
/// @nodoc
class __$BoardCommentCopyWithImpl<$Res>
    implements _$BoardCommentCopyWith<$Res> {
  __$BoardCommentCopyWithImpl(this._self, this._then);

  final _BoardComment _self;
  final $Res Function(_BoardComment) _then;

/// Create a copy of BoardComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? body = null,Object? authorName = null,Object? authorAvatarUrl = freezed,Object? authorRole = freezed,Object? createdAt = freezed,}) {
  return _then(_BoardComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorAvatarUrl: freezed == authorAvatarUrl ? _self.authorAvatarUrl : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,authorRole: freezed == authorRole ? _self.authorRole : authorRole // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
