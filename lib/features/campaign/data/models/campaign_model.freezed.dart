// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompanyBrief {

@JsonKey(name: 'company_name') String? get companyName; bool get verified;
/// Create a copy of CompanyBrief
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyBriefCopyWith<CompanyBrief> get copyWith => _$CompanyBriefCopyWithImpl<CompanyBrief>(this as CompanyBrief, _$identity);

  /// Serializes this CompanyBrief to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyBrief&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.verified, verified) || other.verified == verified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,companyName,verified);

@override
String toString() {
  return 'CompanyBrief(companyName: $companyName, verified: $verified)';
}


}

/// @nodoc
abstract mixin class $CompanyBriefCopyWith<$Res>  {
  factory $CompanyBriefCopyWith(CompanyBrief value, $Res Function(CompanyBrief) _then) = _$CompanyBriefCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'company_name') String? companyName, bool verified
});




}
/// @nodoc
class _$CompanyBriefCopyWithImpl<$Res>
    implements $CompanyBriefCopyWith<$Res> {
  _$CompanyBriefCopyWithImpl(this._self, this._then);

  final CompanyBrief _self;
  final $Res Function(CompanyBrief) _then;

/// Create a copy of CompanyBrief
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? companyName = freezed,Object? verified = null,}) {
  return _then(_self.copyWith(
companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyBrief].
extension CompanyBriefPatterns on CompanyBrief {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyBrief value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyBrief() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyBrief value)  $default,){
final _that = this;
switch (_that) {
case _CompanyBrief():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyBrief value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyBrief() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'company_name')  String? companyName,  bool verified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyBrief() when $default != null:
return $default(_that.companyName,_that.verified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'company_name')  String? companyName,  bool verified)  $default,) {final _that = this;
switch (_that) {
case _CompanyBrief():
return $default(_that.companyName,_that.verified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'company_name')  String? companyName,  bool verified)?  $default,) {final _that = this;
switch (_that) {
case _CompanyBrief() when $default != null:
return $default(_that.companyName,_that.verified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompanyBrief implements CompanyBrief {
  const _CompanyBrief({@JsonKey(name: 'company_name') this.companyName, this.verified = false});
  factory _CompanyBrief.fromJson(Map<String, dynamic> json) => _$CompanyBriefFromJson(json);

@override@JsonKey(name: 'company_name') final  String? companyName;
@override@JsonKey() final  bool verified;

/// Create a copy of CompanyBrief
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyBriefCopyWith<_CompanyBrief> get copyWith => __$CompanyBriefCopyWithImpl<_CompanyBrief>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompanyBriefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyBrief&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.verified, verified) || other.verified == verified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,companyName,verified);

@override
String toString() {
  return 'CompanyBrief(companyName: $companyName, verified: $verified)';
}


}

/// @nodoc
abstract mixin class _$CompanyBriefCopyWith<$Res> implements $CompanyBriefCopyWith<$Res> {
  factory _$CompanyBriefCopyWith(_CompanyBrief value, $Res Function(_CompanyBrief) _then) = __$CompanyBriefCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'company_name') String? companyName, bool verified
});




}
/// @nodoc
class __$CompanyBriefCopyWithImpl<$Res>
    implements _$CompanyBriefCopyWith<$Res> {
  __$CompanyBriefCopyWithImpl(this._self, this._then);

  final _CompanyBrief _self;
  final $Res Function(_CompanyBrief) _then;

/// Create a copy of CompanyBrief
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? companyName = freezed,Object? verified = null,}) {
  return _then(_CompanyBrief(
companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CampaignModel {

 String get id;@JsonKey(name: 'company_id') String get companyId; String get title; String? get description; String? get category; String get type;@JsonKey(name: 'reward_type') String? get rewardType;@JsonKey(name: 'reward_amount') int? get rewardAmount;@JsonKey(name: 'recruit_count') int get recruitCount;@JsonKey(name: 'content_guide') String? get contentGuide;@JsonKey(name: 'min_followers') int get minFollowers;@JsonKey(name: 'thumbnail_url') String? get thumbnailUrl;@JsonKey(name: 'apply_deadline') String? get applyDeadline; String get status;@JsonKey(name: 'created_at') String? get createdAt; bool get bookmarked;@JsonKey(name: 'applicant_count') int? get applicantCount; bool get applied;@JsonKey(name: 'application_id') String? get applicationId;@JsonKey(name: 'application_status') String? get applicationStatus; CompanyBrief? get company;
/// Create a copy of CampaignModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignModelCopyWith<CampaignModel> get copyWith => _$CampaignModelCopyWithImpl<CampaignModel>(this as CampaignModel, _$identity);

  /// Serializes this CampaignModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignModel&&(identical(other.id, id) || other.id == id)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardAmount, rewardAmount) || other.rewardAmount == rewardAmount)&&(identical(other.recruitCount, recruitCount) || other.recruitCount == recruitCount)&&(identical(other.contentGuide, contentGuide) || other.contentGuide == contentGuide)&&(identical(other.minFollowers, minFollowers) || other.minFollowers == minFollowers)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.applyDeadline, applyDeadline) || other.applyDeadline == applyDeadline)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.bookmarked, bookmarked) || other.bookmarked == bookmarked)&&(identical(other.applicantCount, applicantCount) || other.applicantCount == applicantCount)&&(identical(other.applied, applied) || other.applied == applied)&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.applicationStatus, applicationStatus) || other.applicationStatus == applicationStatus)&&(identical(other.company, company) || other.company == company));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,companyId,title,description,category,type,rewardType,rewardAmount,recruitCount,contentGuide,minFollowers,thumbnailUrl,applyDeadline,status,createdAt,bookmarked,applicantCount,applied,applicationId,applicationStatus,company]);

@override
String toString() {
  return 'CampaignModel(id: $id, companyId: $companyId, title: $title, description: $description, category: $category, type: $type, rewardType: $rewardType, rewardAmount: $rewardAmount, recruitCount: $recruitCount, contentGuide: $contentGuide, minFollowers: $minFollowers, thumbnailUrl: $thumbnailUrl, applyDeadline: $applyDeadline, status: $status, createdAt: $createdAt, bookmarked: $bookmarked, applicantCount: $applicantCount, applied: $applied, applicationId: $applicationId, applicationStatus: $applicationStatus, company: $company)';
}


}

/// @nodoc
abstract mixin class $CampaignModelCopyWith<$Res>  {
  factory $CampaignModelCopyWith(CampaignModel value, $Res Function(CampaignModel) _then) = _$CampaignModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'company_id') String companyId, String title, String? description, String? category, String type,@JsonKey(name: 'reward_type') String? rewardType,@JsonKey(name: 'reward_amount') int? rewardAmount,@JsonKey(name: 'recruit_count') int recruitCount,@JsonKey(name: 'content_guide') String? contentGuide,@JsonKey(name: 'min_followers') int minFollowers,@JsonKey(name: 'thumbnail_url') String? thumbnailUrl,@JsonKey(name: 'apply_deadline') String? applyDeadline, String status,@JsonKey(name: 'created_at') String? createdAt, bool bookmarked,@JsonKey(name: 'applicant_count') int? applicantCount, bool applied,@JsonKey(name: 'application_id') String? applicationId,@JsonKey(name: 'application_status') String? applicationStatus, CompanyBrief? company
});


$CompanyBriefCopyWith<$Res>? get company;

}
/// @nodoc
class _$CampaignModelCopyWithImpl<$Res>
    implements $CampaignModelCopyWith<$Res> {
  _$CampaignModelCopyWithImpl(this._self, this._then);

  final CampaignModel _self;
  final $Res Function(CampaignModel) _then;

/// Create a copy of CampaignModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? companyId = null,Object? title = null,Object? description = freezed,Object? category = freezed,Object? type = null,Object? rewardType = freezed,Object? rewardAmount = freezed,Object? recruitCount = null,Object? contentGuide = freezed,Object? minFollowers = null,Object? thumbnailUrl = freezed,Object? applyDeadline = freezed,Object? status = null,Object? createdAt = freezed,Object? bookmarked = null,Object? applicantCount = freezed,Object? applied = null,Object? applicationId = freezed,Object? applicationStatus = freezed,Object? company = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String?,rewardAmount: freezed == rewardAmount ? _self.rewardAmount : rewardAmount // ignore: cast_nullable_to_non_nullable
as int?,recruitCount: null == recruitCount ? _self.recruitCount : recruitCount // ignore: cast_nullable_to_non_nullable
as int,contentGuide: freezed == contentGuide ? _self.contentGuide : contentGuide // ignore: cast_nullable_to_non_nullable
as String?,minFollowers: null == minFollowers ? _self.minFollowers : minFollowers // ignore: cast_nullable_to_non_nullable
as int,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,applyDeadline: freezed == applyDeadline ? _self.applyDeadline : applyDeadline // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,applicantCount: freezed == applicantCount ? _self.applicantCount : applicantCount // ignore: cast_nullable_to_non_nullable
as int?,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as bool,applicationId: freezed == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String?,applicationStatus: freezed == applicationStatus ? _self.applicationStatus : applicationStatus // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as CompanyBrief?,
  ));
}
/// Create a copy of CampaignModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompanyBriefCopyWith<$Res>? get company {
    if (_self.company == null) {
    return null;
  }

  return $CompanyBriefCopyWith<$Res>(_self.company!, (value) {
    return _then(_self.copyWith(company: value));
  });
}
}


/// Adds pattern-matching-related methods to [CampaignModel].
extension CampaignModelPatterns on CampaignModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignModel value)  $default,){
final _that = this;
switch (_that) {
case _CampaignModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignModel value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'company_id')  String companyId,  String title,  String? description,  String? category,  String type, @JsonKey(name: 'reward_type')  String? rewardType, @JsonKey(name: 'reward_amount')  int? rewardAmount, @JsonKey(name: 'recruit_count')  int recruitCount, @JsonKey(name: 'content_guide')  String? contentGuide, @JsonKey(name: 'min_followers')  int minFollowers, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl, @JsonKey(name: 'apply_deadline')  String? applyDeadline,  String status, @JsonKey(name: 'created_at')  String? createdAt,  bool bookmarked, @JsonKey(name: 'applicant_count')  int? applicantCount,  bool applied, @JsonKey(name: 'application_id')  String? applicationId, @JsonKey(name: 'application_status')  String? applicationStatus,  CompanyBrief? company)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignModel() when $default != null:
return $default(_that.id,_that.companyId,_that.title,_that.description,_that.category,_that.type,_that.rewardType,_that.rewardAmount,_that.recruitCount,_that.contentGuide,_that.minFollowers,_that.thumbnailUrl,_that.applyDeadline,_that.status,_that.createdAt,_that.bookmarked,_that.applicantCount,_that.applied,_that.applicationId,_that.applicationStatus,_that.company);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'company_id')  String companyId,  String title,  String? description,  String? category,  String type, @JsonKey(name: 'reward_type')  String? rewardType, @JsonKey(name: 'reward_amount')  int? rewardAmount, @JsonKey(name: 'recruit_count')  int recruitCount, @JsonKey(name: 'content_guide')  String? contentGuide, @JsonKey(name: 'min_followers')  int minFollowers, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl, @JsonKey(name: 'apply_deadline')  String? applyDeadline,  String status, @JsonKey(name: 'created_at')  String? createdAt,  bool bookmarked, @JsonKey(name: 'applicant_count')  int? applicantCount,  bool applied, @JsonKey(name: 'application_id')  String? applicationId, @JsonKey(name: 'application_status')  String? applicationStatus,  CompanyBrief? company)  $default,) {final _that = this;
switch (_that) {
case _CampaignModel():
return $default(_that.id,_that.companyId,_that.title,_that.description,_that.category,_that.type,_that.rewardType,_that.rewardAmount,_that.recruitCount,_that.contentGuide,_that.minFollowers,_that.thumbnailUrl,_that.applyDeadline,_that.status,_that.createdAt,_that.bookmarked,_that.applicantCount,_that.applied,_that.applicationId,_that.applicationStatus,_that.company);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'company_id')  String companyId,  String title,  String? description,  String? category,  String type, @JsonKey(name: 'reward_type')  String? rewardType, @JsonKey(name: 'reward_amount')  int? rewardAmount, @JsonKey(name: 'recruit_count')  int recruitCount, @JsonKey(name: 'content_guide')  String? contentGuide, @JsonKey(name: 'min_followers')  int minFollowers, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl, @JsonKey(name: 'apply_deadline')  String? applyDeadline,  String status, @JsonKey(name: 'created_at')  String? createdAt,  bool bookmarked, @JsonKey(name: 'applicant_count')  int? applicantCount,  bool applied, @JsonKey(name: 'application_id')  String? applicationId, @JsonKey(name: 'application_status')  String? applicationStatus,  CompanyBrief? company)?  $default,) {final _that = this;
switch (_that) {
case _CampaignModel() when $default != null:
return $default(_that.id,_that.companyId,_that.title,_that.description,_that.category,_that.type,_that.rewardType,_that.rewardAmount,_that.recruitCount,_that.contentGuide,_that.minFollowers,_that.thumbnailUrl,_that.applyDeadline,_that.status,_that.createdAt,_that.bookmarked,_that.applicantCount,_that.applied,_that.applicationId,_that.applicationStatus,_that.company);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampaignModel extends CampaignModel {
  const _CampaignModel({required this.id, @JsonKey(name: 'company_id') required this.companyId, required this.title, this.description, this.category, this.type = 'delivery', @JsonKey(name: 'reward_type') this.rewardType, @JsonKey(name: 'reward_amount') this.rewardAmount, @JsonKey(name: 'recruit_count') this.recruitCount = 1, @JsonKey(name: 'content_guide') this.contentGuide, @JsonKey(name: 'min_followers') this.minFollowers = 0, @JsonKey(name: 'thumbnail_url') this.thumbnailUrl, @JsonKey(name: 'apply_deadline') this.applyDeadline, this.status = 'draft', @JsonKey(name: 'created_at') this.createdAt, this.bookmarked = false, @JsonKey(name: 'applicant_count') this.applicantCount, this.applied = false, @JsonKey(name: 'application_id') this.applicationId, @JsonKey(name: 'application_status') this.applicationStatus, this.company}): super._();
  factory _CampaignModel.fromJson(Map<String, dynamic> json) => _$CampaignModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'company_id') final  String companyId;
@override final  String title;
@override final  String? description;
@override final  String? category;
@override@JsonKey() final  String type;
@override@JsonKey(name: 'reward_type') final  String? rewardType;
@override@JsonKey(name: 'reward_amount') final  int? rewardAmount;
@override@JsonKey(name: 'recruit_count') final  int recruitCount;
@override@JsonKey(name: 'content_guide') final  String? contentGuide;
@override@JsonKey(name: 'min_followers') final  int minFollowers;
@override@JsonKey(name: 'thumbnail_url') final  String? thumbnailUrl;
@override@JsonKey(name: 'apply_deadline') final  String? applyDeadline;
@override@JsonKey() final  String status;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey() final  bool bookmarked;
@override@JsonKey(name: 'applicant_count') final  int? applicantCount;
@override@JsonKey() final  bool applied;
@override@JsonKey(name: 'application_id') final  String? applicationId;
@override@JsonKey(name: 'application_status') final  String? applicationStatus;
@override final  CompanyBrief? company;

/// Create a copy of CampaignModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignModelCopyWith<_CampaignModel> get copyWith => __$CampaignModelCopyWithImpl<_CampaignModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampaignModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignModel&&(identical(other.id, id) || other.id == id)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardAmount, rewardAmount) || other.rewardAmount == rewardAmount)&&(identical(other.recruitCount, recruitCount) || other.recruitCount == recruitCount)&&(identical(other.contentGuide, contentGuide) || other.contentGuide == contentGuide)&&(identical(other.minFollowers, minFollowers) || other.minFollowers == minFollowers)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.applyDeadline, applyDeadline) || other.applyDeadline == applyDeadline)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.bookmarked, bookmarked) || other.bookmarked == bookmarked)&&(identical(other.applicantCount, applicantCount) || other.applicantCount == applicantCount)&&(identical(other.applied, applied) || other.applied == applied)&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.applicationStatus, applicationStatus) || other.applicationStatus == applicationStatus)&&(identical(other.company, company) || other.company == company));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,companyId,title,description,category,type,rewardType,rewardAmount,recruitCount,contentGuide,minFollowers,thumbnailUrl,applyDeadline,status,createdAt,bookmarked,applicantCount,applied,applicationId,applicationStatus,company]);

@override
String toString() {
  return 'CampaignModel(id: $id, companyId: $companyId, title: $title, description: $description, category: $category, type: $type, rewardType: $rewardType, rewardAmount: $rewardAmount, recruitCount: $recruitCount, contentGuide: $contentGuide, minFollowers: $minFollowers, thumbnailUrl: $thumbnailUrl, applyDeadline: $applyDeadline, status: $status, createdAt: $createdAt, bookmarked: $bookmarked, applicantCount: $applicantCount, applied: $applied, applicationId: $applicationId, applicationStatus: $applicationStatus, company: $company)';
}


}

/// @nodoc
abstract mixin class _$CampaignModelCopyWith<$Res> implements $CampaignModelCopyWith<$Res> {
  factory _$CampaignModelCopyWith(_CampaignModel value, $Res Function(_CampaignModel) _then) = __$CampaignModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'company_id') String companyId, String title, String? description, String? category, String type,@JsonKey(name: 'reward_type') String? rewardType,@JsonKey(name: 'reward_amount') int? rewardAmount,@JsonKey(name: 'recruit_count') int recruitCount,@JsonKey(name: 'content_guide') String? contentGuide,@JsonKey(name: 'min_followers') int minFollowers,@JsonKey(name: 'thumbnail_url') String? thumbnailUrl,@JsonKey(name: 'apply_deadline') String? applyDeadline, String status,@JsonKey(name: 'created_at') String? createdAt, bool bookmarked,@JsonKey(name: 'applicant_count') int? applicantCount, bool applied,@JsonKey(name: 'application_id') String? applicationId,@JsonKey(name: 'application_status') String? applicationStatus, CompanyBrief? company
});


@override $CompanyBriefCopyWith<$Res>? get company;

}
/// @nodoc
class __$CampaignModelCopyWithImpl<$Res>
    implements _$CampaignModelCopyWith<$Res> {
  __$CampaignModelCopyWithImpl(this._self, this._then);

  final _CampaignModel _self;
  final $Res Function(_CampaignModel) _then;

/// Create a copy of CampaignModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? companyId = null,Object? title = null,Object? description = freezed,Object? category = freezed,Object? type = null,Object? rewardType = freezed,Object? rewardAmount = freezed,Object? recruitCount = null,Object? contentGuide = freezed,Object? minFollowers = null,Object? thumbnailUrl = freezed,Object? applyDeadline = freezed,Object? status = null,Object? createdAt = freezed,Object? bookmarked = null,Object? applicantCount = freezed,Object? applied = null,Object? applicationId = freezed,Object? applicationStatus = freezed,Object? company = freezed,}) {
  return _then(_CampaignModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String?,rewardAmount: freezed == rewardAmount ? _self.rewardAmount : rewardAmount // ignore: cast_nullable_to_non_nullable
as int?,recruitCount: null == recruitCount ? _self.recruitCount : recruitCount // ignore: cast_nullable_to_non_nullable
as int,contentGuide: freezed == contentGuide ? _self.contentGuide : contentGuide // ignore: cast_nullable_to_non_nullable
as String?,minFollowers: null == minFollowers ? _self.minFollowers : minFollowers // ignore: cast_nullable_to_non_nullable
as int,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,applyDeadline: freezed == applyDeadline ? _self.applyDeadline : applyDeadline // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,applicantCount: freezed == applicantCount ? _self.applicantCount : applicantCount // ignore: cast_nullable_to_non_nullable
as int?,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as bool,applicationId: freezed == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String?,applicationStatus: freezed == applicationStatus ? _self.applicationStatus : applicationStatus // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as CompanyBrief?,
  ));
}

/// Create a copy of CampaignModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompanyBriefCopyWith<$Res>? get company {
    if (_self.company == null) {
    return null;
  }

  return $CompanyBriefCopyWith<$Res>(_self.company!, (value) {
    return _then(_self.copyWith(company: value));
  });
}
}

// dart format on
