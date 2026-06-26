// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tiktok_account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TiktokAccountModel {

 String? get username;@JsonKey(name: 'display_name') String? get displayName;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'follower_count') int? get followerCount;@JsonKey(name: 'following_count') int? get followingCount;@JsonKey(name: 'likes_count') int? get likesCount;@JsonKey(name: 'video_count') int? get videoCount;@JsonKey(name: 'verified_at') String? get verifiedAt;@JsonKey(name: 'last_synced_at') String? get lastSyncedAt;
/// Create a copy of TiktokAccountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TiktokAccountModelCopyWith<TiktokAccountModel> get copyWith => _$TiktokAccountModelCopyWithImpl<TiktokAccountModel>(this as TiktokAccountModel, _$identity);

  /// Serializes this TiktokAccountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TiktokAccountModel&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.followerCount, followerCount) || other.followerCount == followerCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.videoCount, videoCount) || other.videoCount == videoCount)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,displayName,avatarUrl,followerCount,followingCount,likesCount,videoCount,verifiedAt,lastSyncedAt);

@override
String toString() {
  return 'TiktokAccountModel(username: $username, displayName: $displayName, avatarUrl: $avatarUrl, followerCount: $followerCount, followingCount: $followingCount, likesCount: $likesCount, videoCount: $videoCount, verifiedAt: $verifiedAt, lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class $TiktokAccountModelCopyWith<$Res>  {
  factory $TiktokAccountModelCopyWith(TiktokAccountModel value, $Res Function(TiktokAccountModel) _then) = _$TiktokAccountModelCopyWithImpl;
@useResult
$Res call({
 String? username,@JsonKey(name: 'display_name') String? displayName,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'follower_count') int? followerCount,@JsonKey(name: 'following_count') int? followingCount,@JsonKey(name: 'likes_count') int? likesCount,@JsonKey(name: 'video_count') int? videoCount,@JsonKey(name: 'verified_at') String? verifiedAt,@JsonKey(name: 'last_synced_at') String? lastSyncedAt
});




}
/// @nodoc
class _$TiktokAccountModelCopyWithImpl<$Res>
    implements $TiktokAccountModelCopyWith<$Res> {
  _$TiktokAccountModelCopyWithImpl(this._self, this._then);

  final TiktokAccountModel _self;
  final $Res Function(TiktokAccountModel) _then;

/// Create a copy of TiktokAccountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = freezed,Object? displayName = freezed,Object? avatarUrl = freezed,Object? followerCount = freezed,Object? followingCount = freezed,Object? likesCount = freezed,Object? videoCount = freezed,Object? verifiedAt = freezed,Object? lastSyncedAt = freezed,}) {
  return _then(_self.copyWith(
username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,followerCount: freezed == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int?,followingCount: freezed == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int?,likesCount: freezed == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int?,videoCount: freezed == videoCount ? _self.videoCount : videoCount // ignore: cast_nullable_to_non_nullable
as int?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as String?,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TiktokAccountModel].
extension TiktokAccountModelPatterns on TiktokAccountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TiktokAccountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TiktokAccountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TiktokAccountModel value)  $default,){
final _that = this;
switch (_that) {
case _TiktokAccountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TiktokAccountModel value)?  $default,){
final _that = this;
switch (_that) {
case _TiktokAccountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? username, @JsonKey(name: 'display_name')  String? displayName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'follower_count')  int? followerCount, @JsonKey(name: 'following_count')  int? followingCount, @JsonKey(name: 'likes_count')  int? likesCount, @JsonKey(name: 'video_count')  int? videoCount, @JsonKey(name: 'verified_at')  String? verifiedAt, @JsonKey(name: 'last_synced_at')  String? lastSyncedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TiktokAccountModel() when $default != null:
return $default(_that.username,_that.displayName,_that.avatarUrl,_that.followerCount,_that.followingCount,_that.likesCount,_that.videoCount,_that.verifiedAt,_that.lastSyncedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? username, @JsonKey(name: 'display_name')  String? displayName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'follower_count')  int? followerCount, @JsonKey(name: 'following_count')  int? followingCount, @JsonKey(name: 'likes_count')  int? likesCount, @JsonKey(name: 'video_count')  int? videoCount, @JsonKey(name: 'verified_at')  String? verifiedAt, @JsonKey(name: 'last_synced_at')  String? lastSyncedAt)  $default,) {final _that = this;
switch (_that) {
case _TiktokAccountModel():
return $default(_that.username,_that.displayName,_that.avatarUrl,_that.followerCount,_that.followingCount,_that.likesCount,_that.videoCount,_that.verifiedAt,_that.lastSyncedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? username, @JsonKey(name: 'display_name')  String? displayName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'follower_count')  int? followerCount, @JsonKey(name: 'following_count')  int? followingCount, @JsonKey(name: 'likes_count')  int? likesCount, @JsonKey(name: 'video_count')  int? videoCount, @JsonKey(name: 'verified_at')  String? verifiedAt, @JsonKey(name: 'last_synced_at')  String? lastSyncedAt)?  $default,) {final _that = this;
switch (_that) {
case _TiktokAccountModel() when $default != null:
return $default(_that.username,_that.displayName,_that.avatarUrl,_that.followerCount,_that.followingCount,_that.likesCount,_that.videoCount,_that.verifiedAt,_that.lastSyncedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TiktokAccountModel extends TiktokAccountModel {
  const _TiktokAccountModel({this.username, @JsonKey(name: 'display_name') this.displayName, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'follower_count') this.followerCount, @JsonKey(name: 'following_count') this.followingCount, @JsonKey(name: 'likes_count') this.likesCount, @JsonKey(name: 'video_count') this.videoCount, @JsonKey(name: 'verified_at') this.verifiedAt, @JsonKey(name: 'last_synced_at') this.lastSyncedAt}): super._();
  factory _TiktokAccountModel.fromJson(Map<String, dynamic> json) => _$TiktokAccountModelFromJson(json);

@override final  String? username;
@override@JsonKey(name: 'display_name') final  String? displayName;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'follower_count') final  int? followerCount;
@override@JsonKey(name: 'following_count') final  int? followingCount;
@override@JsonKey(name: 'likes_count') final  int? likesCount;
@override@JsonKey(name: 'video_count') final  int? videoCount;
@override@JsonKey(name: 'verified_at') final  String? verifiedAt;
@override@JsonKey(name: 'last_synced_at') final  String? lastSyncedAt;

/// Create a copy of TiktokAccountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TiktokAccountModelCopyWith<_TiktokAccountModel> get copyWith => __$TiktokAccountModelCopyWithImpl<_TiktokAccountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TiktokAccountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TiktokAccountModel&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.followerCount, followerCount) || other.followerCount == followerCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.videoCount, videoCount) || other.videoCount == videoCount)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,displayName,avatarUrl,followerCount,followingCount,likesCount,videoCount,verifiedAt,lastSyncedAt);

@override
String toString() {
  return 'TiktokAccountModel(username: $username, displayName: $displayName, avatarUrl: $avatarUrl, followerCount: $followerCount, followingCount: $followingCount, likesCount: $likesCount, videoCount: $videoCount, verifiedAt: $verifiedAt, lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class _$TiktokAccountModelCopyWith<$Res> implements $TiktokAccountModelCopyWith<$Res> {
  factory _$TiktokAccountModelCopyWith(_TiktokAccountModel value, $Res Function(_TiktokAccountModel) _then) = __$TiktokAccountModelCopyWithImpl;
@override @useResult
$Res call({
 String? username,@JsonKey(name: 'display_name') String? displayName,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'follower_count') int? followerCount,@JsonKey(name: 'following_count') int? followingCount,@JsonKey(name: 'likes_count') int? likesCount,@JsonKey(name: 'video_count') int? videoCount,@JsonKey(name: 'verified_at') String? verifiedAt,@JsonKey(name: 'last_synced_at') String? lastSyncedAt
});




}
/// @nodoc
class __$TiktokAccountModelCopyWithImpl<$Res>
    implements _$TiktokAccountModelCopyWith<$Res> {
  __$TiktokAccountModelCopyWithImpl(this._self, this._then);

  final _TiktokAccountModel _self;
  final $Res Function(_TiktokAccountModel) _then;

/// Create a copy of TiktokAccountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = freezed,Object? displayName = freezed,Object? avatarUrl = freezed,Object? followerCount = freezed,Object? followingCount = freezed,Object? likesCount = freezed,Object? videoCount = freezed,Object? verifiedAt = freezed,Object? lastSyncedAt = freezed,}) {
  return _then(_TiktokAccountModel(
username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,followerCount: freezed == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int?,followingCount: freezed == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int?,likesCount: freezed == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int?,videoCount: freezed == videoCount ? _self.videoCount : videoCount // ignore: cast_nullable_to_non_nullable
as int?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as String?,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
