// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tiktok_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TiktokAccount {

 String? get username; String? get displayName; String? get avatarUrl; int? get followerCount; int? get followingCount; int? get likesCount; int? get videoCount; DateTime? get verifiedAt; DateTime? get lastSyncedAt;
/// Create a copy of TiktokAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TiktokAccountCopyWith<TiktokAccount> get copyWith => _$TiktokAccountCopyWithImpl<TiktokAccount>(this as TiktokAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TiktokAccount&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.followerCount, followerCount) || other.followerCount == followerCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.videoCount, videoCount) || other.videoCount == videoCount)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}


@override
int get hashCode => Object.hash(runtimeType,username,displayName,avatarUrl,followerCount,followingCount,likesCount,videoCount,verifiedAt,lastSyncedAt);

@override
String toString() {
  return 'TiktokAccount(username: $username, displayName: $displayName, avatarUrl: $avatarUrl, followerCount: $followerCount, followingCount: $followingCount, likesCount: $likesCount, videoCount: $videoCount, verifiedAt: $verifiedAt, lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class $TiktokAccountCopyWith<$Res>  {
  factory $TiktokAccountCopyWith(TiktokAccount value, $Res Function(TiktokAccount) _then) = _$TiktokAccountCopyWithImpl;
@useResult
$Res call({
 String? username, String? displayName, String? avatarUrl, int? followerCount, int? followingCount, int? likesCount, int? videoCount, DateTime? verifiedAt, DateTime? lastSyncedAt
});




}
/// @nodoc
class _$TiktokAccountCopyWithImpl<$Res>
    implements $TiktokAccountCopyWith<$Res> {
  _$TiktokAccountCopyWithImpl(this._self, this._then);

  final TiktokAccount _self;
  final $Res Function(TiktokAccount) _then;

/// Create a copy of TiktokAccount
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
as DateTime?,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TiktokAccount].
extension TiktokAccountPatterns on TiktokAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TiktokAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TiktokAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TiktokAccount value)  $default,){
final _that = this;
switch (_that) {
case _TiktokAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TiktokAccount value)?  $default,){
final _that = this;
switch (_that) {
case _TiktokAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? username,  String? displayName,  String? avatarUrl,  int? followerCount,  int? followingCount,  int? likesCount,  int? videoCount,  DateTime? verifiedAt,  DateTime? lastSyncedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TiktokAccount() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? username,  String? displayName,  String? avatarUrl,  int? followerCount,  int? followingCount,  int? likesCount,  int? videoCount,  DateTime? verifiedAt,  DateTime? lastSyncedAt)  $default,) {final _that = this;
switch (_that) {
case _TiktokAccount():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? username,  String? displayName,  String? avatarUrl,  int? followerCount,  int? followingCount,  int? likesCount,  int? videoCount,  DateTime? verifiedAt,  DateTime? lastSyncedAt)?  $default,) {final _that = this;
switch (_that) {
case _TiktokAccount() when $default != null:
return $default(_that.username,_that.displayName,_that.avatarUrl,_that.followerCount,_that.followingCount,_that.likesCount,_that.videoCount,_that.verifiedAt,_that.lastSyncedAt);case _:
  return null;

}
}

}

/// @nodoc


class _TiktokAccount implements TiktokAccount {
  const _TiktokAccount({this.username, this.displayName, this.avatarUrl, this.followerCount, this.followingCount, this.likesCount, this.videoCount, this.verifiedAt, this.lastSyncedAt});
  

@override final  String? username;
@override final  String? displayName;
@override final  String? avatarUrl;
@override final  int? followerCount;
@override final  int? followingCount;
@override final  int? likesCount;
@override final  int? videoCount;
@override final  DateTime? verifiedAt;
@override final  DateTime? lastSyncedAt;

/// Create a copy of TiktokAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TiktokAccountCopyWith<_TiktokAccount> get copyWith => __$TiktokAccountCopyWithImpl<_TiktokAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TiktokAccount&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.followerCount, followerCount) || other.followerCount == followerCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.videoCount, videoCount) || other.videoCount == videoCount)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}


@override
int get hashCode => Object.hash(runtimeType,username,displayName,avatarUrl,followerCount,followingCount,likesCount,videoCount,verifiedAt,lastSyncedAt);

@override
String toString() {
  return 'TiktokAccount(username: $username, displayName: $displayName, avatarUrl: $avatarUrl, followerCount: $followerCount, followingCount: $followingCount, likesCount: $likesCount, videoCount: $videoCount, verifiedAt: $verifiedAt, lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class _$TiktokAccountCopyWith<$Res> implements $TiktokAccountCopyWith<$Res> {
  factory _$TiktokAccountCopyWith(_TiktokAccount value, $Res Function(_TiktokAccount) _then) = __$TiktokAccountCopyWithImpl;
@override @useResult
$Res call({
 String? username, String? displayName, String? avatarUrl, int? followerCount, int? followingCount, int? likesCount, int? videoCount, DateTime? verifiedAt, DateTime? lastSyncedAt
});




}
/// @nodoc
class __$TiktokAccountCopyWithImpl<$Res>
    implements _$TiktokAccountCopyWith<$Res> {
  __$TiktokAccountCopyWithImpl(this._self, this._then);

  final _TiktokAccount _self;
  final $Res Function(_TiktokAccount) _then;

/// Create a copy of TiktokAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = freezed,Object? displayName = freezed,Object? avatarUrl = freezed,Object? followerCount = freezed,Object? followingCount = freezed,Object? likesCount = freezed,Object? videoCount = freezed,Object? verifiedAt = freezed,Object? lastSyncedAt = freezed,}) {
  return _then(_TiktokAccount(
username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,followerCount: freezed == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int?,followingCount: freezed == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int?,likesCount: freezed == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int?,videoCount: freezed == videoCount ? _self.videoCount : videoCount // ignore: cast_nullable_to_non_nullable
as int?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
