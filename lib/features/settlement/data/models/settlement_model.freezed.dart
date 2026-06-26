// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementModel {

 String get id;@JsonKey(name: 'application_id') String get applicationId; int get amount; String get status; String? get method;@JsonKey(name: 'paid_at') String? get paidAt; Map<String, dynamic>? get application;
/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementModelCopyWith<SettlementModel> get copyWith => _$SettlementModelCopyWithImpl<SettlementModel>(this as SettlementModel, _$identity);

  /// Serializes this SettlementModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.method, method) || other.method == method)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&const DeepCollectionEquality().equals(other.application, application));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,applicationId,amount,status,method,paidAt,const DeepCollectionEquality().hash(application));

@override
String toString() {
  return 'SettlementModel(id: $id, applicationId: $applicationId, amount: $amount, status: $status, method: $method, paidAt: $paidAt, application: $application)';
}


}

/// @nodoc
abstract mixin class $SettlementModelCopyWith<$Res>  {
  factory $SettlementModelCopyWith(SettlementModel value, $Res Function(SettlementModel) _then) = _$SettlementModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'application_id') String applicationId, int amount, String status, String? method,@JsonKey(name: 'paid_at') String? paidAt, Map<String, dynamic>? application
});




}
/// @nodoc
class _$SettlementModelCopyWithImpl<$Res>
    implements $SettlementModelCopyWith<$Res> {
  _$SettlementModelCopyWithImpl(this._self, this._then);

  final SettlementModel _self;
  final $Res Function(SettlementModel) _then;

/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? applicationId = null,Object? amount = null,Object? status = null,Object? method = freezed,Object? paidAt = freezed,Object? application = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,applicationId: null == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String?,application: freezed == application ? _self.application : application // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettlementModel].
extension SettlementModelPatterns on SettlementModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlementModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlementModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlementModel value)  $default,){
final _that = this;
switch (_that) {
case _SettlementModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlementModel value)?  $default,){
final _that = this;
switch (_that) {
case _SettlementModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'application_id')  String applicationId,  int amount,  String status,  String? method, @JsonKey(name: 'paid_at')  String? paidAt,  Map<String, dynamic>? application)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementModel() when $default != null:
return $default(_that.id,_that.applicationId,_that.amount,_that.status,_that.method,_that.paidAt,_that.application);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'application_id')  String applicationId,  int amount,  String status,  String? method, @JsonKey(name: 'paid_at')  String? paidAt,  Map<String, dynamic>? application)  $default,) {final _that = this;
switch (_that) {
case _SettlementModel():
return $default(_that.id,_that.applicationId,_that.amount,_that.status,_that.method,_that.paidAt,_that.application);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'application_id')  String applicationId,  int amount,  String status,  String? method, @JsonKey(name: 'paid_at')  String? paidAt,  Map<String, dynamic>? application)?  $default,) {final _that = this;
switch (_that) {
case _SettlementModel() when $default != null:
return $default(_that.id,_that.applicationId,_that.amount,_that.status,_that.method,_that.paidAt,_that.application);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettlementModel extends SettlementModel {
  const _SettlementModel({required this.id, @JsonKey(name: 'application_id') required this.applicationId, this.amount = 0, this.status = 'pending', this.method, @JsonKey(name: 'paid_at') this.paidAt, final  Map<String, dynamic>? application}): _application = application,super._();
  factory _SettlementModel.fromJson(Map<String, dynamic> json) => _$SettlementModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'application_id') final  String applicationId;
@override@JsonKey() final  int amount;
@override@JsonKey() final  String status;
@override final  String? method;
@override@JsonKey(name: 'paid_at') final  String? paidAt;
 final  Map<String, dynamic>? _application;
@override Map<String, dynamic>? get application {
  final value = _application;
  if (value == null) return null;
  if (_application is EqualUnmodifiableMapView) return _application;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementModelCopyWith<_SettlementModel> get copyWith => __$SettlementModelCopyWithImpl<_SettlementModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettlementModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.method, method) || other.method == method)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&const DeepCollectionEquality().equals(other._application, _application));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,applicationId,amount,status,method,paidAt,const DeepCollectionEquality().hash(_application));

@override
String toString() {
  return 'SettlementModel(id: $id, applicationId: $applicationId, amount: $amount, status: $status, method: $method, paidAt: $paidAt, application: $application)';
}


}

/// @nodoc
abstract mixin class _$SettlementModelCopyWith<$Res> implements $SettlementModelCopyWith<$Res> {
  factory _$SettlementModelCopyWith(_SettlementModel value, $Res Function(_SettlementModel) _then) = __$SettlementModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'application_id') String applicationId, int amount, String status, String? method,@JsonKey(name: 'paid_at') String? paidAt, Map<String, dynamic>? application
});




}
/// @nodoc
class __$SettlementModelCopyWithImpl<$Res>
    implements _$SettlementModelCopyWith<$Res> {
  __$SettlementModelCopyWithImpl(this._self, this._then);

  final _SettlementModel _self;
  final $Res Function(_SettlementModel) _then;

/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? applicationId = null,Object? amount = null,Object? status = null,Object? method = freezed,Object? paidAt = freezed,Object? application = freezed,}) {
  return _then(_SettlementModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,applicationId: null == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String?,application: freezed == application ? _self._application : application // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
