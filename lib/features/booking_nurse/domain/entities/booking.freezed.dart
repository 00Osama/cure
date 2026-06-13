// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Booking {

 String get id; String get patientId; String? get nurseId; String get serviceId; String? get serviceKey; DateTime get scheduledAt; BookingStatus get status; String? get remarks; String get address; double get price; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingCopyWith<Booking> get copyWith => _$BookingCopyWithImpl<Booking>(this as Booking, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.nurseId, nurseId) || other.nurseId == nurseId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceKey, serviceKey) || other.serviceKey == serviceKey)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.remarks, remarks) || other.remarks == remarks)&&(identical(other.address, address) || other.address == address)&&(identical(other.price, price) || other.price == price)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,patientId,nurseId,serviceId,serviceKey,scheduledAt,status,remarks,address,price,createdAt,updatedAt);

@override
String toString() {
  return 'Booking(id: $id, patientId: $patientId, nurseId: $nurseId, serviceId: $serviceId, serviceKey: $serviceKey, scheduledAt: $scheduledAt, status: $status, remarks: $remarks, address: $address, price: $price, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BookingCopyWith<$Res>  {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) _then) = _$BookingCopyWithImpl;
@useResult
$Res call({
 String id, String patientId, String? nurseId, String serviceId, String? serviceKey, DateTime scheduledAt, BookingStatus status, String? remarks, String address, double price, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$BookingCopyWithImpl<$Res>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._self, this._then);

  final Booking _self;
  final $Res Function(Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? patientId = null,Object? nurseId = freezed,Object? serviceId = null,Object? serviceKey = freezed,Object? scheduledAt = null,Object? status = null,Object? remarks = freezed,Object? address = null,Object? price = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as String,nurseId: freezed == nurseId ? _self.nurseId : nurseId // ignore: cast_nullable_to_non_nullable
as String?,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceKey: freezed == serviceKey ? _self.serviceKey : serviceKey // ignore: cast_nullable_to_non_nullable
as String?,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,remarks: freezed == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Booking].
extension BookingPatterns on Booking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Booking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Booking value)  $default,){
final _that = this;
switch (_that) {
case _Booking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Booking value)?  $default,){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String patientId,  String? nurseId,  String serviceId,  String? serviceKey,  DateTime scheduledAt,  BookingStatus status,  String? remarks,  String address,  double price,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.patientId,_that.nurseId,_that.serviceId,_that.serviceKey,_that.scheduledAt,_that.status,_that.remarks,_that.address,_that.price,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String patientId,  String? nurseId,  String serviceId,  String? serviceKey,  DateTime scheduledAt,  BookingStatus status,  String? remarks,  String address,  double price,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Booking():
return $default(_that.id,_that.patientId,_that.nurseId,_that.serviceId,_that.serviceKey,_that.scheduledAt,_that.status,_that.remarks,_that.address,_that.price,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String patientId,  String? nurseId,  String serviceId,  String? serviceKey,  DateTime scheduledAt,  BookingStatus status,  String? remarks,  String address,  double price,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.patientId,_that.nurseId,_that.serviceId,_that.serviceKey,_that.scheduledAt,_that.status,_that.remarks,_that.address,_that.price,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Booking implements Booking {
  const _Booking({required this.id, required this.patientId, this.nurseId, required this.serviceId, this.serviceKey, required this.scheduledAt, required this.status, this.remarks, required this.address, required this.price, this.createdAt, this.updatedAt});
  

@override final  String id;
@override final  String patientId;
@override final  String? nurseId;
@override final  String serviceId;
@override final  String? serviceKey;
@override final  DateTime scheduledAt;
@override final  BookingStatus status;
@override final  String? remarks;
@override final  String address;
@override final  double price;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingCopyWith<_Booking> get copyWith => __$BookingCopyWithImpl<_Booking>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.nurseId, nurseId) || other.nurseId == nurseId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceKey, serviceKey) || other.serviceKey == serviceKey)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.remarks, remarks) || other.remarks == remarks)&&(identical(other.address, address) || other.address == address)&&(identical(other.price, price) || other.price == price)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,patientId,nurseId,serviceId,serviceKey,scheduledAt,status,remarks,address,price,createdAt,updatedAt);

@override
String toString() {
  return 'Booking(id: $id, patientId: $patientId, nurseId: $nurseId, serviceId: $serviceId, serviceKey: $serviceKey, scheduledAt: $scheduledAt, status: $status, remarks: $remarks, address: $address, price: $price, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BookingCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$BookingCopyWith(_Booking value, $Res Function(_Booking) _then) = __$BookingCopyWithImpl;
@override @useResult
$Res call({
 String id, String patientId, String? nurseId, String serviceId, String? serviceKey, DateTime scheduledAt, BookingStatus status, String? remarks, String address, double price, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$BookingCopyWithImpl<$Res>
    implements _$BookingCopyWith<$Res> {
  __$BookingCopyWithImpl(this._self, this._then);

  final _Booking _self;
  final $Res Function(_Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? patientId = null,Object? nurseId = freezed,Object? serviceId = null,Object? serviceKey = freezed,Object? scheduledAt = null,Object? status = null,Object? remarks = freezed,Object? address = null,Object? price = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Booking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as String,nurseId: freezed == nurseId ? _self.nurseId : nurseId // ignore: cast_nullable_to_non_nullable
as String?,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceKey: freezed == serviceKey ? _self.serviceKey : serviceKey // ignore: cast_nullable_to_non_nullable
as String?,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,remarks: freezed == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
