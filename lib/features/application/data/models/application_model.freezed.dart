// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApplicationModel {

 String get id;@JsonKey(name: 'campaign_id') String get campaignId;@JsonKey(name: 'influencer_id') String get influencerId; String get status; String? get message;@JsonKey(name: 'applied_at') String? get appliedAt; Map<String, dynamic>? get campaign; Map<String, dynamic>? get influencer;
/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationModelCopyWith<ApplicationModel> get copyWith => _$ApplicationModelCopyWithImpl<ApplicationModel>(this as ApplicationModel, _$identity);

  /// Serializes this ApplicationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.influencerId, influencerId) || other.influencerId == influencerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.appliedAt, appliedAt) || other.appliedAt == appliedAt)&&const DeepCollectionEquality().equals(other.campaign, campaign)&&const DeepCollectionEquality().equals(other.influencer, influencer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,campaignId,influencerId,status,message,appliedAt,const DeepCollectionEquality().hash(campaign),const DeepCollectionEquality().hash(influencer));

@override
String toString() {
  return 'ApplicationModel(id: $id, campaignId: $campaignId, influencerId: $influencerId, status: $status, message: $message, appliedAt: $appliedAt, campaign: $campaign, influencer: $influencer)';
}


}

/// @nodoc
abstract mixin class $ApplicationModelCopyWith<$Res>  {
  factory $ApplicationModelCopyWith(ApplicationModel value, $Res Function(ApplicationModel) _then) = _$ApplicationModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'campaign_id') String campaignId,@JsonKey(name: 'influencer_id') String influencerId, String status, String? message,@JsonKey(name: 'applied_at') String? appliedAt, Map<String, dynamic>? campaign, Map<String, dynamic>? influencer
});




}
/// @nodoc
class _$ApplicationModelCopyWithImpl<$Res>
    implements $ApplicationModelCopyWith<$Res> {
  _$ApplicationModelCopyWithImpl(this._self, this._then);

  final ApplicationModel _self;
  final $Res Function(ApplicationModel) _then;

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? campaignId = null,Object? influencerId = null,Object? status = null,Object? message = freezed,Object? appliedAt = freezed,Object? campaign = freezed,Object? influencer = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,influencerId: null == influencerId ? _self.influencerId : influencerId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,appliedAt: freezed == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as String?,campaign: freezed == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,influencer: freezed == influencer ? _self.influencer : influencer // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApplicationModel].
extension ApplicationModelPatterns on ApplicationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplicationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplicationModel value)  $default,){
final _that = this;
switch (_that) {
case _ApplicationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplicationModel value)?  $default,){
final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'campaign_id')  String campaignId, @JsonKey(name: 'influencer_id')  String influencerId,  String status,  String? message, @JsonKey(name: 'applied_at')  String? appliedAt,  Map<String, dynamic>? campaign,  Map<String, dynamic>? influencer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
return $default(_that.id,_that.campaignId,_that.influencerId,_that.status,_that.message,_that.appliedAt,_that.campaign,_that.influencer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'campaign_id')  String campaignId, @JsonKey(name: 'influencer_id')  String influencerId,  String status,  String? message, @JsonKey(name: 'applied_at')  String? appliedAt,  Map<String, dynamic>? campaign,  Map<String, dynamic>? influencer)  $default,) {final _that = this;
switch (_that) {
case _ApplicationModel():
return $default(_that.id,_that.campaignId,_that.influencerId,_that.status,_that.message,_that.appliedAt,_that.campaign,_that.influencer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'campaign_id')  String campaignId, @JsonKey(name: 'influencer_id')  String influencerId,  String status,  String? message, @JsonKey(name: 'applied_at')  String? appliedAt,  Map<String, dynamic>? campaign,  Map<String, dynamic>? influencer)?  $default,) {final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
return $default(_that.id,_that.campaignId,_that.influencerId,_that.status,_that.message,_that.appliedAt,_that.campaign,_that.influencer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApplicationModel extends ApplicationModel {
  const _ApplicationModel({required this.id, @JsonKey(name: 'campaign_id') required this.campaignId, @JsonKey(name: 'influencer_id') required this.influencerId, this.status = 'pending', this.message, @JsonKey(name: 'applied_at') this.appliedAt, final  Map<String, dynamic>? campaign, final  Map<String, dynamic>? influencer}): _campaign = campaign,_influencer = influencer,super._();
  factory _ApplicationModel.fromJson(Map<String, dynamic> json) => _$ApplicationModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'campaign_id') final  String campaignId;
@override@JsonKey(name: 'influencer_id') final  String influencerId;
@override@JsonKey() final  String status;
@override final  String? message;
@override@JsonKey(name: 'applied_at') final  String? appliedAt;
 final  Map<String, dynamic>? _campaign;
@override Map<String, dynamic>? get campaign {
  final value = _campaign;
  if (value == null) return null;
  if (_campaign is EqualUnmodifiableMapView) return _campaign;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _influencer;
@override Map<String, dynamic>? get influencer {
  final value = _influencer;
  if (value == null) return null;
  if (_influencer is EqualUnmodifiableMapView) return _influencer;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationModelCopyWith<_ApplicationModel> get copyWith => __$ApplicationModelCopyWithImpl<_ApplicationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplicationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.influencerId, influencerId) || other.influencerId == influencerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.appliedAt, appliedAt) || other.appliedAt == appliedAt)&&const DeepCollectionEquality().equals(other._campaign, _campaign)&&const DeepCollectionEquality().equals(other._influencer, _influencer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,campaignId,influencerId,status,message,appliedAt,const DeepCollectionEquality().hash(_campaign),const DeepCollectionEquality().hash(_influencer));

@override
String toString() {
  return 'ApplicationModel(id: $id, campaignId: $campaignId, influencerId: $influencerId, status: $status, message: $message, appliedAt: $appliedAt, campaign: $campaign, influencer: $influencer)';
}


}

/// @nodoc
abstract mixin class _$ApplicationModelCopyWith<$Res> implements $ApplicationModelCopyWith<$Res> {
  factory _$ApplicationModelCopyWith(_ApplicationModel value, $Res Function(_ApplicationModel) _then) = __$ApplicationModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'campaign_id') String campaignId,@JsonKey(name: 'influencer_id') String influencerId, String status, String? message,@JsonKey(name: 'applied_at') String? appliedAt, Map<String, dynamic>? campaign, Map<String, dynamic>? influencer
});




}
/// @nodoc
class __$ApplicationModelCopyWithImpl<$Res>
    implements _$ApplicationModelCopyWith<$Res> {
  __$ApplicationModelCopyWithImpl(this._self, this._then);

  final _ApplicationModel _self;
  final $Res Function(_ApplicationModel) _then;

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? campaignId = null,Object? influencerId = null,Object? status = null,Object? message = freezed,Object? appliedAt = freezed,Object? campaign = freezed,Object? influencer = freezed,}) {
  return _then(_ApplicationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,influencerId: null == influencerId ? _self.influencerId : influencerId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,appliedAt: freezed == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as String?,campaign: freezed == campaign ? _self._campaign : campaign // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,influencer: freezed == influencer ? _self._influencer : influencer // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
