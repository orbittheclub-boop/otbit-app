// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BoardPostModel {

 String get id;@JsonKey(name: 'author_id') String get authorId; String get category; String get title; String get body;@JsonKey(name: 'like_count') int get likeCount;@JsonKey(name: 'comment_count') int get commentCount; bool get liked;@JsonKey(name: 'created_at') String? get createdAt; Map<String, dynamic>? get author;
/// Create a copy of BoardPostModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardPostModelCopyWith<BoardPostModel> get copyWith => _$BoardPostModelCopyWithImpl<BoardPostModel>(this as BoardPostModel, _$identity);

  /// Serializes this BoardPostModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardPostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.category, category) || other.category == category)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.liked, liked) || other.liked == liked)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.author, author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,category,title,body,likeCount,commentCount,liked,createdAt,const DeepCollectionEquality().hash(author));

@override
String toString() {
  return 'BoardPostModel(id: $id, authorId: $authorId, category: $category, title: $title, body: $body, likeCount: $likeCount, commentCount: $commentCount, liked: $liked, createdAt: $createdAt, author: $author)';
}


}

/// @nodoc
abstract mixin class $BoardPostModelCopyWith<$Res>  {
  factory $BoardPostModelCopyWith(BoardPostModel value, $Res Function(BoardPostModel) _then) = _$BoardPostModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'author_id') String authorId, String category, String title, String body,@JsonKey(name: 'like_count') int likeCount,@JsonKey(name: 'comment_count') int commentCount, bool liked,@JsonKey(name: 'created_at') String? createdAt, Map<String, dynamic>? author
});




}
/// @nodoc
class _$BoardPostModelCopyWithImpl<$Res>
    implements $BoardPostModelCopyWith<$Res> {
  _$BoardPostModelCopyWithImpl(this._self, this._then);

  final BoardPostModel _self;
  final $Res Function(BoardPostModel) _then;

/// Create a copy of BoardPostModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorId = null,Object? category = null,Object? title = null,Object? body = null,Object? likeCount = null,Object? commentCount = null,Object? liked = null,Object? createdAt = freezed,Object? author = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardPostModel].
extension BoardPostModelPatterns on BoardPostModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardPostModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardPostModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardPostModel value)  $default,){
final _that = this;
switch (_that) {
case _BoardPostModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardPostModel value)?  $default,){
final _that = this;
switch (_that) {
case _BoardPostModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'author_id')  String authorId,  String category,  String title,  String body, @JsonKey(name: 'like_count')  int likeCount, @JsonKey(name: 'comment_count')  int commentCount,  bool liked, @JsonKey(name: 'created_at')  String? createdAt,  Map<String, dynamic>? author)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardPostModel() when $default != null:
return $default(_that.id,_that.authorId,_that.category,_that.title,_that.body,_that.likeCount,_that.commentCount,_that.liked,_that.createdAt,_that.author);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'author_id')  String authorId,  String category,  String title,  String body, @JsonKey(name: 'like_count')  int likeCount, @JsonKey(name: 'comment_count')  int commentCount,  bool liked, @JsonKey(name: 'created_at')  String? createdAt,  Map<String, dynamic>? author)  $default,) {final _that = this;
switch (_that) {
case _BoardPostModel():
return $default(_that.id,_that.authorId,_that.category,_that.title,_that.body,_that.likeCount,_that.commentCount,_that.liked,_that.createdAt,_that.author);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'author_id')  String authorId,  String category,  String title,  String body, @JsonKey(name: 'like_count')  int likeCount, @JsonKey(name: 'comment_count')  int commentCount,  bool liked, @JsonKey(name: 'created_at')  String? createdAt,  Map<String, dynamic>? author)?  $default,) {final _that = this;
switch (_that) {
case _BoardPostModel() when $default != null:
return $default(_that.id,_that.authorId,_that.category,_that.title,_that.body,_that.likeCount,_that.commentCount,_that.liked,_that.createdAt,_that.author);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BoardPostModel extends BoardPostModel {
  const _BoardPostModel({required this.id, @JsonKey(name: 'author_id') required this.authorId, required this.category, required this.title, required this.body, @JsonKey(name: 'like_count') this.likeCount = 0, @JsonKey(name: 'comment_count') this.commentCount = 0, this.liked = false, @JsonKey(name: 'created_at') this.createdAt, final  Map<String, dynamic>? author}): _author = author,super._();
  factory _BoardPostModel.fromJson(Map<String, dynamic> json) => _$BoardPostModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'author_id') final  String authorId;
@override final  String category;
@override final  String title;
@override final  String body;
@override@JsonKey(name: 'like_count') final  int likeCount;
@override@JsonKey(name: 'comment_count') final  int commentCount;
@override@JsonKey() final  bool liked;
@override@JsonKey(name: 'created_at') final  String? createdAt;
 final  Map<String, dynamic>? _author;
@override Map<String, dynamic>? get author {
  final value = _author;
  if (value == null) return null;
  if (_author is EqualUnmodifiableMapView) return _author;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of BoardPostModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardPostModelCopyWith<_BoardPostModel> get copyWith => __$BoardPostModelCopyWithImpl<_BoardPostModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardPostModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardPostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.category, category) || other.category == category)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.liked, liked) || other.liked == liked)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._author, _author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,category,title,body,likeCount,commentCount,liked,createdAt,const DeepCollectionEquality().hash(_author));

@override
String toString() {
  return 'BoardPostModel(id: $id, authorId: $authorId, category: $category, title: $title, body: $body, likeCount: $likeCount, commentCount: $commentCount, liked: $liked, createdAt: $createdAt, author: $author)';
}


}

/// @nodoc
abstract mixin class _$BoardPostModelCopyWith<$Res> implements $BoardPostModelCopyWith<$Res> {
  factory _$BoardPostModelCopyWith(_BoardPostModel value, $Res Function(_BoardPostModel) _then) = __$BoardPostModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'author_id') String authorId, String category, String title, String body,@JsonKey(name: 'like_count') int likeCount,@JsonKey(name: 'comment_count') int commentCount, bool liked,@JsonKey(name: 'created_at') String? createdAt, Map<String, dynamic>? author
});




}
/// @nodoc
class __$BoardPostModelCopyWithImpl<$Res>
    implements _$BoardPostModelCopyWith<$Res> {
  __$BoardPostModelCopyWithImpl(this._self, this._then);

  final _BoardPostModel _self;
  final $Res Function(_BoardPostModel) _then;

/// Create a copy of BoardPostModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? category = null,Object? title = null,Object? body = null,Object? likeCount = null,Object? commentCount = null,Object? liked = null,Object? createdAt = freezed,Object? author = freezed,}) {
  return _then(_BoardPostModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self._author : author // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
