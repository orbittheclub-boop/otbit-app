// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Campaign {

 String get id; String get companyId; String get title; String? get description; String? get category; CampaignType get type; String? get rewardType; int? get rewardAmount; int get recruitCount; String? get contentGuide; int get minFollowers; String? get thumbnailUrl; DateTime? get applyDeadline; CampaignStatus get status; DateTime? get createdAt; String? get companyName; bool get verified; bool get bookmarked; int? get applicantCount; bool get applied; String? get applicationId; String? get applicationStatus;
/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignCopyWith<Campaign> get copyWith => _$CampaignCopyWithImpl<Campaign>(this as Campaign, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Campaign&&(identical(other.id, id) || other.id == id)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardAmount, rewardAmount) || other.rewardAmount == rewardAmount)&&(identical(other.recruitCount, recruitCount) || other.recruitCount == recruitCount)&&(identical(other.contentGuide, contentGuide) || other.contentGuide == contentGuide)&&(identical(other.minFollowers, minFollowers) || other.minFollowers == minFollowers)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.applyDeadline, applyDeadline) || other.applyDeadline == applyDeadline)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.bookmarked, bookmarked) || other.bookmarked == bookmarked)&&(identical(other.applicantCount, applicantCount) || other.applicantCount == applicantCount)&&(identical(other.applied, applied) || other.applied == applied)&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.applicationStatus, applicationStatus) || other.applicationStatus == applicationStatus));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,companyId,title,description,category,type,rewardType,rewardAmount,recruitCount,contentGuide,minFollowers,thumbnailUrl,applyDeadline,status,createdAt,companyName,verified,bookmarked,applicantCount,applied,applicationId,applicationStatus]);

@override
String toString() {
  return 'Campaign(id: $id, companyId: $companyId, title: $title, description: $description, category: $category, type: $type, rewardType: $rewardType, rewardAmount: $rewardAmount, recruitCount: $recruitCount, contentGuide: $contentGuide, minFollowers: $minFollowers, thumbnailUrl: $thumbnailUrl, applyDeadline: $applyDeadline, status: $status, createdAt: $createdAt, companyName: $companyName, verified: $verified, bookmarked: $bookmarked, applicantCount: $applicantCount, applied: $applied, applicationId: $applicationId, applicationStatus: $applicationStatus)';
}


}

/// @nodoc
abstract mixin class $CampaignCopyWith<$Res>  {
  factory $CampaignCopyWith(Campaign value, $Res Function(Campaign) _then) = _$CampaignCopyWithImpl;
@useResult
$Res call({
 String id, String companyId, String title, String? description, String? category, CampaignType type, String? rewardType, int? rewardAmount, int recruitCount, String? contentGuide, int minFollowers, String? thumbnailUrl, DateTime? applyDeadline, CampaignStatus status, DateTime? createdAt, String? companyName, bool verified, bool bookmarked, int? applicantCount, bool applied, String? applicationId, String? applicationStatus
});




}
/// @nodoc
class _$CampaignCopyWithImpl<$Res>
    implements $CampaignCopyWith<$Res> {
  _$CampaignCopyWithImpl(this._self, this._then);

  final Campaign _self;
  final $Res Function(Campaign) _then;

/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? companyId = null,Object? title = null,Object? description = freezed,Object? category = freezed,Object? type = null,Object? rewardType = freezed,Object? rewardAmount = freezed,Object? recruitCount = null,Object? contentGuide = freezed,Object? minFollowers = null,Object? thumbnailUrl = freezed,Object? applyDeadline = freezed,Object? status = null,Object? createdAt = freezed,Object? companyName = freezed,Object? verified = null,Object? bookmarked = null,Object? applicantCount = freezed,Object? applied = null,Object? applicationId = freezed,Object? applicationStatus = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CampaignType,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String?,rewardAmount: freezed == rewardAmount ? _self.rewardAmount : rewardAmount // ignore: cast_nullable_to_non_nullable
as int?,recruitCount: null == recruitCount ? _self.recruitCount : recruitCount // ignore: cast_nullable_to_non_nullable
as int,contentGuide: freezed == contentGuide ? _self.contentGuide : contentGuide // ignore: cast_nullable_to_non_nullable
as String?,minFollowers: null == minFollowers ? _self.minFollowers : minFollowers // ignore: cast_nullable_to_non_nullable
as int,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,applyDeadline: freezed == applyDeadline ? _self.applyDeadline : applyDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,applicantCount: freezed == applicantCount ? _self.applicantCount : applicantCount // ignore: cast_nullable_to_non_nullable
as int?,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as bool,applicationId: freezed == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String?,applicationStatus: freezed == applicationStatus ? _self.applicationStatus : applicationStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Campaign].
extension CampaignPatterns on Campaign {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Campaign value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Campaign() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Campaign value)  $default,){
final _that = this;
switch (_that) {
case _Campaign():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Campaign value)?  $default,){
final _that = this;
switch (_that) {
case _Campaign() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String companyId,  String title,  String? description,  String? category,  CampaignType type,  String? rewardType,  int? rewardAmount,  int recruitCount,  String? contentGuide,  int minFollowers,  String? thumbnailUrl,  DateTime? applyDeadline,  CampaignStatus status,  DateTime? createdAt,  String? companyName,  bool verified,  bool bookmarked,  int? applicantCount,  bool applied,  String? applicationId,  String? applicationStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Campaign() when $default != null:
return $default(_that.id,_that.companyId,_that.title,_that.description,_that.category,_that.type,_that.rewardType,_that.rewardAmount,_that.recruitCount,_that.contentGuide,_that.minFollowers,_that.thumbnailUrl,_that.applyDeadline,_that.status,_that.createdAt,_that.companyName,_that.verified,_that.bookmarked,_that.applicantCount,_that.applied,_that.applicationId,_that.applicationStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String companyId,  String title,  String? description,  String? category,  CampaignType type,  String? rewardType,  int? rewardAmount,  int recruitCount,  String? contentGuide,  int minFollowers,  String? thumbnailUrl,  DateTime? applyDeadline,  CampaignStatus status,  DateTime? createdAt,  String? companyName,  bool verified,  bool bookmarked,  int? applicantCount,  bool applied,  String? applicationId,  String? applicationStatus)  $default,) {final _that = this;
switch (_that) {
case _Campaign():
return $default(_that.id,_that.companyId,_that.title,_that.description,_that.category,_that.type,_that.rewardType,_that.rewardAmount,_that.recruitCount,_that.contentGuide,_that.minFollowers,_that.thumbnailUrl,_that.applyDeadline,_that.status,_that.createdAt,_that.companyName,_that.verified,_that.bookmarked,_that.applicantCount,_that.applied,_that.applicationId,_that.applicationStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String companyId,  String title,  String? description,  String? category,  CampaignType type,  String? rewardType,  int? rewardAmount,  int recruitCount,  String? contentGuide,  int minFollowers,  String? thumbnailUrl,  DateTime? applyDeadline,  CampaignStatus status,  DateTime? createdAt,  String? companyName,  bool verified,  bool bookmarked,  int? applicantCount,  bool applied,  String? applicationId,  String? applicationStatus)?  $default,) {final _that = this;
switch (_that) {
case _Campaign() when $default != null:
return $default(_that.id,_that.companyId,_that.title,_that.description,_that.category,_that.type,_that.rewardType,_that.rewardAmount,_that.recruitCount,_that.contentGuide,_that.minFollowers,_that.thumbnailUrl,_that.applyDeadline,_that.status,_that.createdAt,_that.companyName,_that.verified,_that.bookmarked,_that.applicantCount,_that.applied,_that.applicationId,_that.applicationStatus);case _:
  return null;

}
}

}

/// @nodoc


class _Campaign implements Campaign {
  const _Campaign({required this.id, required this.companyId, required this.title, this.description, this.category, this.type = CampaignType.delivery, this.rewardType, this.rewardAmount, this.recruitCount = 1, this.contentGuide, this.minFollowers = 0, this.thumbnailUrl, this.applyDeadline, this.status = CampaignStatus.draft, this.createdAt, this.companyName, this.verified = false, this.bookmarked = false, this.applicantCount, this.applied = false, this.applicationId, this.applicationStatus});
  

@override final  String id;
@override final  String companyId;
@override final  String title;
@override final  String? description;
@override final  String? category;
@override@JsonKey() final  CampaignType type;
@override final  String? rewardType;
@override final  int? rewardAmount;
@override@JsonKey() final  int recruitCount;
@override final  String? contentGuide;
@override@JsonKey() final  int minFollowers;
@override final  String? thumbnailUrl;
@override final  DateTime? applyDeadline;
@override@JsonKey() final  CampaignStatus status;
@override final  DateTime? createdAt;
@override final  String? companyName;
@override@JsonKey() final  bool verified;
@override@JsonKey() final  bool bookmarked;
@override final  int? applicantCount;
@override@JsonKey() final  bool applied;
@override final  String? applicationId;
@override final  String? applicationStatus;

/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignCopyWith<_Campaign> get copyWith => __$CampaignCopyWithImpl<_Campaign>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Campaign&&(identical(other.id, id) || other.id == id)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardAmount, rewardAmount) || other.rewardAmount == rewardAmount)&&(identical(other.recruitCount, recruitCount) || other.recruitCount == recruitCount)&&(identical(other.contentGuide, contentGuide) || other.contentGuide == contentGuide)&&(identical(other.minFollowers, minFollowers) || other.minFollowers == minFollowers)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.applyDeadline, applyDeadline) || other.applyDeadline == applyDeadline)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.bookmarked, bookmarked) || other.bookmarked == bookmarked)&&(identical(other.applicantCount, applicantCount) || other.applicantCount == applicantCount)&&(identical(other.applied, applied) || other.applied == applied)&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.applicationStatus, applicationStatus) || other.applicationStatus == applicationStatus));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,companyId,title,description,category,type,rewardType,rewardAmount,recruitCount,contentGuide,minFollowers,thumbnailUrl,applyDeadline,status,createdAt,companyName,verified,bookmarked,applicantCount,applied,applicationId,applicationStatus]);

@override
String toString() {
  return 'Campaign(id: $id, companyId: $companyId, title: $title, description: $description, category: $category, type: $type, rewardType: $rewardType, rewardAmount: $rewardAmount, recruitCount: $recruitCount, contentGuide: $contentGuide, minFollowers: $minFollowers, thumbnailUrl: $thumbnailUrl, applyDeadline: $applyDeadline, status: $status, createdAt: $createdAt, companyName: $companyName, verified: $verified, bookmarked: $bookmarked, applicantCount: $applicantCount, applied: $applied, applicationId: $applicationId, applicationStatus: $applicationStatus)';
}


}

/// @nodoc
abstract mixin class _$CampaignCopyWith<$Res> implements $CampaignCopyWith<$Res> {
  factory _$CampaignCopyWith(_Campaign value, $Res Function(_Campaign) _then) = __$CampaignCopyWithImpl;
@override @useResult
$Res call({
 String id, String companyId, String title, String? description, String? category, CampaignType type, String? rewardType, int? rewardAmount, int recruitCount, String? contentGuide, int minFollowers, String? thumbnailUrl, DateTime? applyDeadline, CampaignStatus status, DateTime? createdAt, String? companyName, bool verified, bool bookmarked, int? applicantCount, bool applied, String? applicationId, String? applicationStatus
});




}
/// @nodoc
class __$CampaignCopyWithImpl<$Res>
    implements _$CampaignCopyWith<$Res> {
  __$CampaignCopyWithImpl(this._self, this._then);

  final _Campaign _self;
  final $Res Function(_Campaign) _then;

/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? companyId = null,Object? title = null,Object? description = freezed,Object? category = freezed,Object? type = null,Object? rewardType = freezed,Object? rewardAmount = freezed,Object? recruitCount = null,Object? contentGuide = freezed,Object? minFollowers = null,Object? thumbnailUrl = freezed,Object? applyDeadline = freezed,Object? status = null,Object? createdAt = freezed,Object? companyName = freezed,Object? verified = null,Object? bookmarked = null,Object? applicantCount = freezed,Object? applied = null,Object? applicationId = freezed,Object? applicationStatus = freezed,}) {
  return _then(_Campaign(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CampaignType,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String?,rewardAmount: freezed == rewardAmount ? _self.rewardAmount : rewardAmount // ignore: cast_nullable_to_non_nullable
as int?,recruitCount: null == recruitCount ? _self.recruitCount : recruitCount // ignore: cast_nullable_to_non_nullable
as int,contentGuide: freezed == contentGuide ? _self.contentGuide : contentGuide // ignore: cast_nullable_to_non_nullable
as String?,minFollowers: null == minFollowers ? _self.minFollowers : minFollowers // ignore: cast_nullable_to_non_nullable
as int,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,applyDeadline: freezed == applyDeadline ? _self.applyDeadline : applyDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,applicantCount: freezed == applicantCount ? _self.applicantCount : applicantCount // ignore: cast_nullable_to_non_nullable
as int?,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as bool,applicationId: freezed == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String?,applicationStatus: freezed == applicationStatus ? _self.applicationStatus : applicationStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
