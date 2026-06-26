// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BoardCommentModel {

 String get id;@JsonKey(name: 'author_id') String get authorId; String get body;@JsonKey(name: 'created_at') String? get createdAt; Map<String, dynamic>? get author;
/// Create a copy of BoardCommentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardCommentModelCopyWith<BoardCommentModel> get copyWith => _$BoardCommentModelCopyWithImpl<BoardCommentModel>(this as BoardCommentModel, _$identity);

  /// Serializes this BoardCommentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardCommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.author, author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,body,createdAt,const DeepCollectionEquality().hash(author));

@override
String toString() {
  return 'BoardCommentModel(id: $id, authorId: $authorId, body: $body, createdAt: $createdAt, author: $author)';
}


}

/// @nodoc
abstract mixin class $BoardCommentModelCopyWith<$Res>  {
  factory $BoardCommentModelCopyWith(BoardCommentModel value, $Res Function(BoardCommentModel) _then) = _$BoardCommentModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'author_id') String authorId, String body,@JsonKey(name: 'created_at') String? createdAt, Map<String, dynamic>? author
});




}
/// @nodoc
class _$BoardCommentModelCopyWithImpl<$Res>
    implements $BoardCommentModelCopyWith<$Res> {
  _$BoardCommentModelCopyWithImpl(this._self, this._then);

  final BoardCommentModel _self;
  final $Res Function(BoardCommentModel) _then;

/// Create a copy of BoardCommentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorId = null,Object? body = null,Object? createdAt = freezed,Object? author = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardCommentModel].
extension BoardCommentModelPatterns on BoardCommentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardCommentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardCommentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardCommentModel value)  $default,){
final _that = this;
switch (_that) {
case _BoardCommentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardCommentModel value)?  $default,){
final _that = this;
switch (_that) {
case _BoardCommentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'author_id')  String authorId,  String body, @JsonKey(name: 'created_at')  String? createdAt,  Map<String, dynamic>? author)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardCommentModel() when $default != null:
return $default(_that.id,_that.authorId,_that.body,_that.createdAt,_that.author);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'author_id')  String authorId,  String body, @JsonKey(name: 'created_at')  String? createdAt,  Map<String, dynamic>? author)  $default,) {final _that = this;
switch (_that) {
case _BoardCommentModel():
return $default(_that.id,_that.authorId,_that.body,_that.createdAt,_that.author);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'author_id')  String authorId,  String body, @JsonKey(name: 'created_at')  String? createdAt,  Map<String, dynamic>? author)?  $default,) {final _that = this;
switch (_that) {
case _BoardCommentModel() when $default != null:
return $default(_that.id,_that.authorId,_that.body,_that.createdAt,_that.author);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BoardCommentModel extends BoardCommentModel {
  const _BoardCommentModel({required this.id, @JsonKey(name: 'author_id') required this.authorId, required this.body, @JsonKey(name: 'created_at') this.createdAt, final  Map<String, dynamic>? author}): _author = author,super._();
  factory _BoardCommentModel.fromJson(Map<String, dynamic> json) => _$BoardCommentModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'author_id') final  String authorId;
@override final  String body;
@override@JsonKey(name: 'created_at') final  String? createdAt;
 final  Map<String, dynamic>? _author;
@override Map<String, dynamic>? get author {
  final value = _author;
  if (value == null) return null;
  if (_author is EqualUnmodifiableMapView) return _author;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of BoardCommentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardCommentModelCopyWith<_BoardCommentModel> get copyWith => __$BoardCommentModelCopyWithImpl<_BoardCommentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardCommentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardCommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._author, _author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,body,createdAt,const DeepCollectionEquality().hash(_author));

@override
String toString() {
  return 'BoardCommentModel(id: $id, authorId: $authorId, body: $body, createdAt: $createdAt, author: $author)';
}


}

/// @nodoc
abstract mixin class _$BoardCommentModelCopyWith<$Res> implements $BoardCommentModelCopyWith<$Res> {
  factory _$BoardCommentModelCopyWith(_BoardCommentModel value, $Res Function(_BoardCommentModel) _then) = __$BoardCommentModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'author_id') String authorId, String body,@JsonKey(name: 'created_at') String? createdAt, Map<String, dynamic>? author
});




}
/// @nodoc
class __$BoardCommentModelCopyWithImpl<$Res>
    implements _$BoardCommentModelCopyWith<$Res> {
  __$BoardCommentModelCopyWithImpl(this._self, this._then);

  final _BoardCommentModel _self;
  final $Res Function(_BoardCommentModel) _then;

/// Create a copy of BoardCommentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? body = null,Object? createdAt = freezed,Object? author = freezed,}) {
  return _then(_BoardCommentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self._author : author // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
