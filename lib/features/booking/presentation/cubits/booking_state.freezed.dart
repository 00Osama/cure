// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingState {

 BookingStep get step; bool get isLoading; List<Service> get services; Service? get selectedService; List<AvailabilitySlot> get slots; AvailabilitySlot? get selectedSlot; String? get region; DateTime? get scheduledAt; String? get address; String? get remarks; Booking? get confirmed; String? get error;
/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingStateCopyWith<BookingState> get copyWith => _$BookingStateCopyWithImpl<BookingState>(this as BookingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingState&&(identical(other.step, step) || other.step == step)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.services, services)&&(identical(other.selectedService, selectedService) || other.selectedService == selectedService)&&const DeepCollectionEquality().equals(other.slots, slots)&&(identical(other.selectedSlot, selectedSlot) || other.selectedSlot == selectedSlot)&&(identical(other.region, region) || other.region == region)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.address, address) || other.address == address)&&(identical(other.remarks, remarks) || other.remarks == remarks)&&(identical(other.confirmed, confirmed) || other.confirmed == confirmed)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,step,isLoading,const DeepCollectionEquality().hash(services),selectedService,const DeepCollectionEquality().hash(slots),selectedSlot,region,scheduledAt,address,remarks,confirmed,error);

@override
String toString() {
  return 'BookingState(step: $step, isLoading: $isLoading, services: $services, selectedService: $selectedService, slots: $slots, selectedSlot: $selectedSlot, region: $region, scheduledAt: $scheduledAt, address: $address, remarks: $remarks, confirmed: $confirmed, error: $error)';
}


}

/// @nodoc
abstract mixin class $BookingStateCopyWith<$Res>  {
  factory $BookingStateCopyWith(BookingState value, $Res Function(BookingState) _then) = _$BookingStateCopyWithImpl;
@useResult
$Res call({
 BookingStep step, bool isLoading, List<Service> services, Service? selectedService, List<AvailabilitySlot> slots, AvailabilitySlot? selectedSlot, String? region, DateTime? scheduledAt, String? address, String? remarks, Booking? confirmed, String? error
});


$ServiceCopyWith<$Res>? get selectedService;$AvailabilitySlotCopyWith<$Res>? get selectedSlot;$BookingCopyWith<$Res>? get confirmed;

}
/// @nodoc
class _$BookingStateCopyWithImpl<$Res>
    implements $BookingStateCopyWith<$Res> {
  _$BookingStateCopyWithImpl(this._self, this._then);

  final BookingState _self;
  final $Res Function(BookingState) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? isLoading = null,Object? services = null,Object? selectedService = freezed,Object? slots = null,Object? selectedSlot = freezed,Object? region = freezed,Object? scheduledAt = freezed,Object? address = freezed,Object? remarks = freezed,Object? confirmed = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as BookingStep,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<Service>,selectedService: freezed == selectedService ? _self.selectedService : selectedService // ignore: cast_nullable_to_non_nullable
as Service?,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<AvailabilitySlot>,selectedSlot: freezed == selectedSlot ? _self.selectedSlot : selectedSlot // ignore: cast_nullable_to_non_nullable
as AvailabilitySlot?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,remarks: freezed == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String?,confirmed: freezed == confirmed ? _self.confirmed : confirmed // ignore: cast_nullable_to_non_nullable
as Booking?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceCopyWith<$Res>? get selectedService {
    if (_self.selectedService == null) {
    return null;
  }

  return $ServiceCopyWith<$Res>(_self.selectedService!, (value) {
    return _then(_self.copyWith(selectedService: value));
  });
}/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AvailabilitySlotCopyWith<$Res>? get selectedSlot {
    if (_self.selectedSlot == null) {
    return null;
  }

  return $AvailabilitySlotCopyWith<$Res>(_self.selectedSlot!, (value) {
    return _then(_self.copyWith(selectedSlot: value));
  });
}/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingCopyWith<$Res>? get confirmed {
    if (_self.confirmed == null) {
    return null;
  }

  return $BookingCopyWith<$Res>(_self.confirmed!, (value) {
    return _then(_self.copyWith(confirmed: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingState].
extension BookingStatePatterns on BookingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingState value)  $default,){
final _that = this;
switch (_that) {
case _BookingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingState value)?  $default,){
final _that = this;
switch (_that) {
case _BookingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BookingStep step,  bool isLoading,  List<Service> services,  Service? selectedService,  List<AvailabilitySlot> slots,  AvailabilitySlot? selectedSlot,  String? region,  DateTime? scheduledAt,  String? address,  String? remarks,  Booking? confirmed,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingState() when $default != null:
return $default(_that.step,_that.isLoading,_that.services,_that.selectedService,_that.slots,_that.selectedSlot,_that.region,_that.scheduledAt,_that.address,_that.remarks,_that.confirmed,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BookingStep step,  bool isLoading,  List<Service> services,  Service? selectedService,  List<AvailabilitySlot> slots,  AvailabilitySlot? selectedSlot,  String? region,  DateTime? scheduledAt,  String? address,  String? remarks,  Booking? confirmed,  String? error)  $default,) {final _that = this;
switch (_that) {
case _BookingState():
return $default(_that.step,_that.isLoading,_that.services,_that.selectedService,_that.slots,_that.selectedSlot,_that.region,_that.scheduledAt,_that.address,_that.remarks,_that.confirmed,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BookingStep step,  bool isLoading,  List<Service> services,  Service? selectedService,  List<AvailabilitySlot> slots,  AvailabilitySlot? selectedSlot,  String? region,  DateTime? scheduledAt,  String? address,  String? remarks,  Booking? confirmed,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _BookingState() when $default != null:
return $default(_that.step,_that.isLoading,_that.services,_that.selectedService,_that.slots,_that.selectedSlot,_that.region,_that.scheduledAt,_that.address,_that.remarks,_that.confirmed,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _BookingState implements BookingState {
  const _BookingState({this.step = BookingStep.selectService, this.isLoading = false, final  List<Service> services = const <Service>[], this.selectedService, final  List<AvailabilitySlot> slots = const <AvailabilitySlot>[], this.selectedSlot, this.region, this.scheduledAt, this.address, this.remarks, this.confirmed, this.error}): _services = services,_slots = slots;
  

@override@JsonKey() final  BookingStep step;
@override@JsonKey() final  bool isLoading;
 final  List<Service> _services;
@override@JsonKey() List<Service> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}

@override final  Service? selectedService;
 final  List<AvailabilitySlot> _slots;
@override@JsonKey() List<AvailabilitySlot> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}

@override final  AvailabilitySlot? selectedSlot;
@override final  String? region;
@override final  DateTime? scheduledAt;
@override final  String? address;
@override final  String? remarks;
@override final  Booking? confirmed;
@override final  String? error;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingStateCopyWith<_BookingState> get copyWith => __$BookingStateCopyWithImpl<_BookingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingState&&(identical(other.step, step) || other.step == step)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._services, _services)&&(identical(other.selectedService, selectedService) || other.selectedService == selectedService)&&const DeepCollectionEquality().equals(other._slots, _slots)&&(identical(other.selectedSlot, selectedSlot) || other.selectedSlot == selectedSlot)&&(identical(other.region, region) || other.region == region)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.address, address) || other.address == address)&&(identical(other.remarks, remarks) || other.remarks == remarks)&&(identical(other.confirmed, confirmed) || other.confirmed == confirmed)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,step,isLoading,const DeepCollectionEquality().hash(_services),selectedService,const DeepCollectionEquality().hash(_slots),selectedSlot,region,scheduledAt,address,remarks,confirmed,error);

@override
String toString() {
  return 'BookingState(step: $step, isLoading: $isLoading, services: $services, selectedService: $selectedService, slots: $slots, selectedSlot: $selectedSlot, region: $region, scheduledAt: $scheduledAt, address: $address, remarks: $remarks, confirmed: $confirmed, error: $error)';
}


}

/// @nodoc
abstract mixin class _$BookingStateCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory _$BookingStateCopyWith(_BookingState value, $Res Function(_BookingState) _then) = __$BookingStateCopyWithImpl;
@override @useResult
$Res call({
 BookingStep step, bool isLoading, List<Service> services, Service? selectedService, List<AvailabilitySlot> slots, AvailabilitySlot? selectedSlot, String? region, DateTime? scheduledAt, String? address, String? remarks, Booking? confirmed, String? error
});


@override $ServiceCopyWith<$Res>? get selectedService;@override $AvailabilitySlotCopyWith<$Res>? get selectedSlot;@override $BookingCopyWith<$Res>? get confirmed;

}
/// @nodoc
class __$BookingStateCopyWithImpl<$Res>
    implements _$BookingStateCopyWith<$Res> {
  __$BookingStateCopyWithImpl(this._self, this._then);

  final _BookingState _self;
  final $Res Function(_BookingState) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? isLoading = null,Object? services = null,Object? selectedService = freezed,Object? slots = null,Object? selectedSlot = freezed,Object? region = freezed,Object? scheduledAt = freezed,Object? address = freezed,Object? remarks = freezed,Object? confirmed = freezed,Object? error = freezed,}) {
  return _then(_BookingState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as BookingStep,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,services: null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<Service>,selectedService: freezed == selectedService ? _self.selectedService : selectedService // ignore: cast_nullable_to_non_nullable
as Service?,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<AvailabilitySlot>,selectedSlot: freezed == selectedSlot ? _self.selectedSlot : selectedSlot // ignore: cast_nullable_to_non_nullable
as AvailabilitySlot?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,remarks: freezed == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String?,confirmed: freezed == confirmed ? _self.confirmed : confirmed // ignore: cast_nullable_to_non_nullable
as Booking?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceCopyWith<$Res>? get selectedService {
    if (_self.selectedService == null) {
    return null;
  }

  return $ServiceCopyWith<$Res>(_self.selectedService!, (value) {
    return _then(_self.copyWith(selectedService: value));
  });
}/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AvailabilitySlotCopyWith<$Res>? get selectedSlot {
    if (_self.selectedSlot == null) {
    return null;
  }

  return $AvailabilitySlotCopyWith<$Res>(_self.selectedSlot!, (value) {
    return _then(_self.copyWith(selectedSlot: value));
  });
}/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingCopyWith<$Res>? get confirmed {
    if (_self.confirmed == null) {
    return null;
  }

  return $BookingCopyWith<$Res>(_self.confirmed!, (value) {
    return _then(_self.copyWith(confirmed: value));
  });
}
}

// dart format on
