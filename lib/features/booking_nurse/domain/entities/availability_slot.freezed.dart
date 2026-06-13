// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'availability_slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AvailabilitySlot {

 String get id; String get nurseId; String get region; DateTime get startsAt; DateTime get endsAt; bool get isBooked;
/// Create a copy of AvailabilitySlot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailabilitySlotCopyWith<AvailabilitySlot> get copyWith => _$AvailabilitySlotCopyWithImpl<AvailabilitySlot>(this as AvailabilitySlot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailabilitySlot&&(identical(other.id, id) || other.id == id)&&(identical(other.nurseId, nurseId) || other.nurseId == nurseId)&&(identical(other.region, region) || other.region == region)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.isBooked, isBooked) || other.isBooked == isBooked));
}


@override
int get hashCode => Object.hash(runtimeType,id,nurseId,region,startsAt,endsAt,isBooked);

@override
String toString() {
  return 'AvailabilitySlot(id: $id, nurseId: $nurseId, region: $region, startsAt: $startsAt, endsAt: $endsAt, isBooked: $isBooked)';
}


}

/// @nodoc
abstract mixin class $AvailabilitySlotCopyWith<$Res>  {
  factory $AvailabilitySlotCopyWith(AvailabilitySlot value, $Res Function(AvailabilitySlot) _then) = _$AvailabilitySlotCopyWithImpl;
@useResult
$Res call({
 String id, String nurseId, String region, DateTime startsAt, DateTime endsAt, bool isBooked
});




}
/// @nodoc
class _$AvailabilitySlotCopyWithImpl<$Res>
    implements $AvailabilitySlotCopyWith<$Res> {
  _$AvailabilitySlotCopyWithImpl(this._self, this._then);

  final AvailabilitySlot _self;
  final $Res Function(AvailabilitySlot) _then;

/// Create a copy of AvailabilitySlot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nurseId = null,Object? region = null,Object? startsAt = null,Object? endsAt = null,Object? isBooked = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nurseId: null == nurseId ? _self.nurseId : nurseId // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,isBooked: null == isBooked ? _self.isBooked : isBooked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AvailabilitySlot].
extension AvailabilitySlotPatterns on AvailabilitySlot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailabilitySlot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailabilitySlot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailabilitySlot value)  $default,){
final _that = this;
switch (_that) {
case _AvailabilitySlot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailabilitySlot value)?  $default,){
final _that = this;
switch (_that) {
case _AvailabilitySlot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nurseId,  String region,  DateTime startsAt,  DateTime endsAt,  bool isBooked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailabilitySlot() when $default != null:
return $default(_that.id,_that.nurseId,_that.region,_that.startsAt,_that.endsAt,_that.isBooked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nurseId,  String region,  DateTime startsAt,  DateTime endsAt,  bool isBooked)  $default,) {final _that = this;
switch (_that) {
case _AvailabilitySlot():
return $default(_that.id,_that.nurseId,_that.region,_that.startsAt,_that.endsAt,_that.isBooked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nurseId,  String region,  DateTime startsAt,  DateTime endsAt,  bool isBooked)?  $default,) {final _that = this;
switch (_that) {
case _AvailabilitySlot() when $default != null:
return $default(_that.id,_that.nurseId,_that.region,_that.startsAt,_that.endsAt,_that.isBooked);case _:
  return null;

}
}

}

/// @nodoc


class _AvailabilitySlot implements AvailabilitySlot {
  const _AvailabilitySlot({required this.id, required this.nurseId, required this.region, required this.startsAt, required this.endsAt, this.isBooked = false});
  

@override final  String id;
@override final  String nurseId;
@override final  String region;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override@JsonKey() final  bool isBooked;

/// Create a copy of AvailabilitySlot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailabilitySlotCopyWith<_AvailabilitySlot> get copyWith => __$AvailabilitySlotCopyWithImpl<_AvailabilitySlot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailabilitySlot&&(identical(other.id, id) || other.id == id)&&(identical(other.nurseId, nurseId) || other.nurseId == nurseId)&&(identical(other.region, region) || other.region == region)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.isBooked, isBooked) || other.isBooked == isBooked));
}


@override
int get hashCode => Object.hash(runtimeType,id,nurseId,region,startsAt,endsAt,isBooked);

@override
String toString() {
  return 'AvailabilitySlot(id: $id, nurseId: $nurseId, region: $region, startsAt: $startsAt, endsAt: $endsAt, isBooked: $isBooked)';
}


}

/// @nodoc
abstract mixin class _$AvailabilitySlotCopyWith<$Res> implements $AvailabilitySlotCopyWith<$Res> {
  factory _$AvailabilitySlotCopyWith(_AvailabilitySlot value, $Res Function(_AvailabilitySlot) _then) = __$AvailabilitySlotCopyWithImpl;
@override @useResult
$Res call({
 String id, String nurseId, String region, DateTime startsAt, DateTime endsAt, bool isBooked
});




}
/// @nodoc
class __$AvailabilitySlotCopyWithImpl<$Res>
    implements _$AvailabilitySlotCopyWith<$Res> {
  __$AvailabilitySlotCopyWithImpl(this._self, this._then);

  final _AvailabilitySlot _self;
  final $Res Function(_AvailabilitySlot) _then;

/// Create a copy of AvailabilitySlot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nurseId = null,Object? region = null,Object? startsAt = null,Object? endsAt = null,Object? isBooked = null,}) {
  return _then(_AvailabilitySlot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nurseId: null == nurseId ? _self.nurseId : nurseId // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,isBooked: null == isBooked ? _self.isBooked : isBooked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
