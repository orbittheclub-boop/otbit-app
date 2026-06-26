// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Settlement {

 String get id; String get applicationId; int get amount; SettlementStatus get status; String? get method; DateTime? get paidAt; String? get campaignTitle; String? get companyName; String? get influencerName;
/// Create a copy of Settlement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementCopyWith<Settlement> get copyWith => _$SettlementCopyWithImpl<Settlement>(this as Settlement, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Settlement&&(identical(other.id, id) || other.id == id)&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.method, method) || other.method == method)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.campaignTitle, campaignTitle) || other.campaignTitle == campaignTitle)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.influencerName, influencerName) || other.influencerName == influencerName));
}


@override
int get hashCode => Object.hash(runtimeType,id,applicationId,amount,status,method,paidAt,campaignTitle,companyName,influencerName);

@override
String toString() {
  return 'Settlement(id: $id, applicationId: $applicationId, amount: $amount, status: $status, method: $method, paidAt: $paidAt, campaignTitle: $campaignTitle, companyName: $companyName, influencerName: $influencerName)';
}


}

/// @nodoc
abstract mixin class $SettlementCopyWith<$Res>  {
  factory $SettlementCopyWith(Settlement value, $Res Function(Settlement) _then) = _$SettlementCopyWithImpl;
@useResult
$Res call({
 String id, String applicationId, int amount, SettlementStatus status, String? method, DateTime? paidAt, String? campaignTitle, String? companyName, String? influencerName
});




}
/// @nodoc
class _$SettlementCopyWithImpl<$Res>
    implements $SettlementCopyWith<$Res> {
  _$SettlementCopyWithImpl(this._self, this._then);

  final Settlement _self;
  final $Res Function(Settlement) _then;

/// Create a copy of Settlement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? applicationId = null,Object? amount = null,Object? status = null,Object? method = freezed,Object? paidAt = freezed,Object? campaignTitle = freezed,Object? companyName = freezed,Object? influencerName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,applicationId: null == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SettlementStatus,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,campaignTitle: freezed == campaignTitle ? _self.campaignTitle : campaignTitle // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,influencerName: freezed == influencerName ? _self.influencerName : influencerName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Settlement].
extension SettlementPatterns on Settlement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Settlement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Settlement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Settlement value)  $default,){
final _that = this;
switch (_that) {
case _Settlement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Settlement value)?  $default,){
final _that = this;
switch (_that) {
case _Settlement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String applicationId,  int amount,  SettlementStatus status,  String? method,  DateTime? paidAt,  String? campaignTitle,  String? companyName,  String? influencerName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Settlement() when $default != null:
return $default(_that.id,_that.applicationId,_that.amount,_that.status,_that.method,_that.paidAt,_that.campaignTitle,_that.companyName,_that.influencerName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String applicationId,  int amount,  SettlementStatus status,  String? method,  DateTime? paidAt,  String? campaignTitle,  String? companyName,  String? influencerName)  $default,) {final _that = this;
switch (_that) {
case _Settlement():
return $default(_that.id,_that.applicationId,_that.amount,_that.status,_that.method,_that.paidAt,_that.campaignTitle,_that.companyName,_that.influencerName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String applicationId,  int amount,  SettlementStatus status,  String? method,  DateTime? paidAt,  String? campaignTitle,  String? companyName,  String? influencerName)?  $default,) {final _that = this;
switch (_that) {
case _Settlement() when $default != null:
return $default(_that.id,_that.applicationId,_that.amount,_that.status,_that.method,_that.paidAt,_that.campaignTitle,_that.companyName,_that.influencerName);case _:
  return null;

}
}

}

/// @nodoc


class _Settlement implements Settlement {
  const _Settlement({required this.id, required this.applicationId, this.amount = 0, this.status = SettlementStatus.pending, this.method, this.paidAt, this.campaignTitle, this.companyName, this.influencerName});
  

@override final  String id;
@override final  String applicationId;
@override@JsonKey() final  int amount;
@override@JsonKey() final  SettlementStatus status;
@override final  String? method;
@override final  DateTime? paidAt;
@override final  String? campaignTitle;
@override final  String? companyName;
@override final  String? influencerName;

/// Create a copy of Settlement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementCopyWith<_Settlement> get copyWith => __$SettlementCopyWithImpl<_Settlement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Settlement&&(identical(other.id, id) || other.id == id)&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.method, method) || other.method == method)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.campaignTitle, campaignTitle) || other.campaignTitle == campaignTitle)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.influencerName, influencerName) || other.influencerName == influencerName));
}


@override
int get hashCode => Object.hash(runtimeType,id,applicationId,amount,status,method,paidAt,campaignTitle,companyName,influencerName);

@override
String toString() {
  return 'Settlement(id: $id, applicationId: $applicationId, amount: $amount, status: $status, method: $method, paidAt: $paidAt, campaignTitle: $campaignTitle, companyName: $companyName, influencerName: $influencerName)';
}


}

/// @nodoc
abstract mixin class _$SettlementCopyWith<$Res> implements $SettlementCopyWith<$Res> {
  factory _$SettlementCopyWith(_Settlement value, $Res Function(_Settlement) _then) = __$SettlementCopyWithImpl;
@override @useResult
$Res call({
 String id, String applicationId, int amount, SettlementStatus status, String? method, DateTime? paidAt, String? campaignTitle, String? companyName, String? influencerName
});




}
/// @nodoc
class __$SettlementCopyWithImpl<$Res>
    implements _$SettlementCopyWith<$Res> {
  __$SettlementCopyWithImpl(this._self, this._then);

  final _Settlement _self;
  final $Res Function(_Settlement) _then;

/// Create a copy of Settlement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? applicationId = null,Object? amount = null,Object? status = null,Object? method = freezed,Object? paidAt = freezed,Object? campaignTitle = freezed,Object? companyName = freezed,Object? influencerName = freezed,}) {
  return _then(_Settlement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,applicationId: null == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SettlementStatus,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,campaignTitle: freezed == campaignTitle ? _self.campaignTitle : campaignTitle // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,influencerName: freezed == influencerName ? _self.influencerName : influencerName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
