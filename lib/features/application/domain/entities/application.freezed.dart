// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Application {

 String get id; String get campaignId; String get influencerId; ApplicationStatus get status; String? get message; DateTime? get appliedAt; String? get campaignTitle; String? get campaignThumbnail; String? get companyName; String? get influencerName; String? get influencerAvatar; String? get tiktokUsername; int? get followerCount;
/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationCopyWith<Application> get copyWith => _$ApplicationCopyWithImpl<Application>(this as Application, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Application&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.influencerId, influencerId) || other.influencerId == influencerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.appliedAt, appliedAt) || other.appliedAt == appliedAt)&&(identical(other.campaignTitle, campaignTitle) || other.campaignTitle == campaignTitle)&&(identical(other.campaignThumbnail, campaignThumbnail) || other.campaignThumbnail == campaignThumbnail)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.influencerName, influencerName) || other.influencerName == influencerName)&&(identical(other.influencerAvatar, influencerAvatar) || other.influencerAvatar == influencerAvatar)&&(identical(other.tiktokUsername, tiktokUsername) || other.tiktokUsername == tiktokUsername)&&(identical(other.followerCount, followerCount) || other.followerCount == followerCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,campaignId,influencerId,status,message,appliedAt,campaignTitle,campaignThumbnail,companyName,influencerName,influencerAvatar,tiktokUsername,followerCount);

@override
String toString() {
  return 'Application(id: $id, campaignId: $campaignId, influencerId: $influencerId, status: $status, message: $message, appliedAt: $appliedAt, campaignTitle: $campaignTitle, campaignThumbnail: $campaignThumbnail, companyName: $companyName, influencerName: $influencerName, influencerAvatar: $influencerAvatar, tiktokUsername: $tiktokUsername, followerCount: $followerCount)';
}


}

/// @nodoc
abstract mixin class $ApplicationCopyWith<$Res>  {
  factory $ApplicationCopyWith(Application value, $Res Function(Application) _then) = _$ApplicationCopyWithImpl;
@useResult
$Res call({
 String id, String campaignId, String influencerId, ApplicationStatus status, String? message, DateTime? appliedAt, String? campaignTitle, String? campaignThumbnail, String? companyName, String? influencerName, String? influencerAvatar, String? tiktokUsername, int? followerCount
});




}
/// @nodoc
class _$ApplicationCopyWithImpl<$Res>
    implements $ApplicationCopyWith<$Res> {
  _$ApplicationCopyWithImpl(this._self, this._then);

  final Application _self;
  final $Res Function(Application) _then;

/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? campaignId = null,Object? influencerId = null,Object? status = null,Object? message = freezed,Object? appliedAt = freezed,Object? campaignTitle = freezed,Object? campaignThumbnail = freezed,Object? companyName = freezed,Object? influencerName = freezed,Object? influencerAvatar = freezed,Object? tiktokUsername = freezed,Object? followerCount = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,influencerId: null == influencerId ? _self.influencerId : influencerId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,appliedAt: freezed == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,campaignTitle: freezed == campaignTitle ? _self.campaignTitle : campaignTitle // ignore: cast_nullable_to_non_nullable
as String?,campaignThumbnail: freezed == campaignThumbnail ? _self.campaignThumbnail : campaignThumbnail // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,influencerName: freezed == influencerName ? _self.influencerName : influencerName // ignore: cast_nullable_to_non_nullable
as String?,influencerAvatar: freezed == influencerAvatar ? _self.influencerAvatar : influencerAvatar // ignore: cast_nullable_to_non_nullable
as String?,tiktokUsername: freezed == tiktokUsername ? _self.tiktokUsername : tiktokUsername // ignore: cast_nullable_to_non_nullable
as String?,followerCount: freezed == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Application].
extension ApplicationPatterns on Application {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Application value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Application() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Application value)  $default,){
final _that = this;
switch (_that) {
case _Application():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Application value)?  $default,){
final _that = this;
switch (_that) {
case _Application() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String campaignId,  String influencerId,  ApplicationStatus status,  String? message,  DateTime? appliedAt,  String? campaignTitle,  String? campaignThumbnail,  String? companyName,  String? influencerName,  String? influencerAvatar,  String? tiktokUsername,  int? followerCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Application() when $default != null:
return $default(_that.id,_that.campaignId,_that.influencerId,_that.status,_that.message,_that.appliedAt,_that.campaignTitle,_that.campaignThumbnail,_that.companyName,_that.influencerName,_that.influencerAvatar,_that.tiktokUsername,_that.followerCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String campaignId,  String influencerId,  ApplicationStatus status,  String? message,  DateTime? appliedAt,  String? campaignTitle,  String? campaignThumbnail,  String? companyName,  String? influencerName,  String? influencerAvatar,  String? tiktokUsername,  int? followerCount)  $default,) {final _that = this;
switch (_that) {
case _Application():
return $default(_that.id,_that.campaignId,_that.influencerId,_that.status,_that.message,_that.appliedAt,_that.campaignTitle,_that.campaignThumbnail,_that.companyName,_that.influencerName,_that.influencerAvatar,_that.tiktokUsername,_that.followerCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String campaignId,  String influencerId,  ApplicationStatus status,  String? message,  DateTime? appliedAt,  String? campaignTitle,  String? campaignThumbnail,  String? companyName,  String? influencerName,  String? influencerAvatar,  String? tiktokUsername,  int? followerCount)?  $default,) {final _that = this;
switch (_that) {
case _Application() when $default != null:
return $default(_that.id,_that.campaignId,_that.influencerId,_that.status,_that.message,_that.appliedAt,_that.campaignTitle,_that.campaignThumbnail,_that.companyName,_that.influencerName,_that.influencerAvatar,_that.tiktokUsername,_that.followerCount);case _:
  return null;

}
}

}

/// @nodoc


class _Application implements Application {
  const _Application({required this.id, required this.campaignId, required this.influencerId, this.status = ApplicationStatus.pending, this.message, this.appliedAt, this.campaignTitle, this.campaignThumbnail, this.companyName, this.influencerName, this.influencerAvatar, this.tiktokUsername, this.followerCount});
  

@override final  String id;
@override final  String campaignId;
@override final  String influencerId;
@override@JsonKey() final  ApplicationStatus status;
@override final  String? message;
@override final  DateTime? appliedAt;
@override final  String? campaignTitle;
@override final  String? campaignThumbnail;
@override final  String? companyName;
@override final  String? influencerName;
@override final  String? influencerAvatar;
@override final  String? tiktokUsername;
@override final  int? followerCount;

/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationCopyWith<_Application> get copyWith => __$ApplicationCopyWithImpl<_Application>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Application&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.influencerId, influencerId) || other.influencerId == influencerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.appliedAt, appliedAt) || other.appliedAt == appliedAt)&&(identical(other.campaignTitle, campaignTitle) || other.campaignTitle == campaignTitle)&&(identical(other.campaignThumbnail, campaignThumbnail) || other.campaignThumbnail == campaignThumbnail)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.influencerName, influencerName) || other.influencerName == influencerName)&&(identical(other.influencerAvatar, influencerAvatar) || other.influencerAvatar == influencerAvatar)&&(identical(other.tiktokUsername, tiktokUsername) || other.tiktokUsername == tiktokUsername)&&(identical(other.followerCount, followerCount) || other.followerCount == followerCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,campaignId,influencerId,status,message,appliedAt,campaignTitle,campaignThumbnail,companyName,influencerName,influencerAvatar,tiktokUsername,followerCount);

@override
String toString() {
  return 'Application(id: $id, campaignId: $campaignId, influencerId: $influencerId, status: $status, message: $message, appliedAt: $appliedAt, campaignTitle: $campaignTitle, campaignThumbnail: $campaignThumbnail, companyName: $companyName, influencerName: $influencerName, influencerAvatar: $influencerAvatar, tiktokUsername: $tiktokUsername, followerCount: $followerCount)';
}


}

/// @nodoc
abstract mixin class _$ApplicationCopyWith<$Res> implements $ApplicationCopyWith<$Res> {
  factory _$ApplicationCopyWith(_Application value, $Res Function(_Application) _then) = __$ApplicationCopyWithImpl;
@override @useResult
$Res call({
 String id, String campaignId, String influencerId, ApplicationStatus status, String? message, DateTime? appliedAt, String? campaignTitle, String? campaignThumbnail, String? companyName, String? influencerName, String? influencerAvatar, String? tiktokUsername, int? followerCount
});




}
/// @nodoc
class __$ApplicationCopyWithImpl<$Res>
    implements _$ApplicationCopyWith<$Res> {
  __$ApplicationCopyWithImpl(this._self, this._then);

  final _Application _self;
  final $Res Function(_Application) _then;

/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? campaignId = null,Object? influencerId = null,Object? status = null,Object? message = freezed,Object? appliedAt = freezed,Object? campaignTitle = freezed,Object? campaignThumbnail = freezed,Object? companyName = freezed,Object? influencerName = freezed,Object? influencerAvatar = freezed,Object? tiktokUsername = freezed,Object? followerCount = freezed,}) {
  return _then(_Application(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,influencerId: null == influencerId ? _self.influencerId : influencerId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,appliedAt: freezed == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,campaignTitle: freezed == campaignTitle ? _self.campaignTitle : campaignTitle // ignore: cast_nullable_to_non_nullable
as String?,campaignThumbnail: freezed == campaignThumbnail ? _self.campaignThumbnail : campaignThumbnail // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,influencerName: freezed == influencerName ? _self.influencerName : influencerName // ignore: cast_nullable_to_non_nullable
as String?,influencerAvatar: freezed == influencerAvatar ? _self.influencerAvatar : influencerAvatar // ignore: cast_nullable_to_non_nullable
as String?,tiktokUsername: freezed == tiktokUsername ? _self.tiktokUsername : tiktokUsername // ignore: cast_nullable_to_non_nullable
as String?,followerCount: freezed == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
