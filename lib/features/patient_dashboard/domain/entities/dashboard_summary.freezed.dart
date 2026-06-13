// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardSummary {

 List<Booking> get active; List<Booking> get history; int get requestedCount; int get confirmedCount; int get inProgressCount; int get completedCount; int get cancelledCount;
/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardSummaryCopyWith<DashboardSummary> get copyWith => _$DashboardSummaryCopyWithImpl<DashboardSummary>(this as DashboardSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardSummary&&const DeepCollectionEquality().equals(other.active, active)&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.requestedCount, requestedCount) || other.requestedCount == requestedCount)&&(identical(other.confirmedCount, confirmedCount) || other.confirmedCount == confirmedCount)&&(identical(other.inProgressCount, inProgressCount) || other.inProgressCount == inProgressCount)&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount)&&(identical(other.cancelledCount, cancelledCount) || other.cancelledCount == cancelledCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(active),const DeepCollectionEquality().hash(history),requestedCount,confirmedCount,inProgressCount,completedCount,cancelledCount);

@override
String toString() {
  return 'DashboardSummary(active: $active, history: $history, requestedCount: $requestedCount, confirmedCount: $confirmedCount, inProgressCount: $inProgressCount, completedCount: $completedCount, cancelledCount: $cancelledCount)';
}


}

/// @nodoc
abstract mixin class $DashboardSummaryCopyWith<$Res>  {
  factory $DashboardSummaryCopyWith(DashboardSummary value, $Res Function(DashboardSummary) _then) = _$DashboardSummaryCopyWithImpl;
@useResult
$Res call({
 List<Booking> active, List<Booking> history, int requestedCount, int confirmedCount, int inProgressCount, int completedCount, int cancelledCount
});




}
/// @nodoc
class _$DashboardSummaryCopyWithImpl<$Res>
    implements $DashboardSummaryCopyWith<$Res> {
  _$DashboardSummaryCopyWithImpl(this._self, this._then);

  final DashboardSummary _self;
  final $Res Function(DashboardSummary) _then;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? active = null,Object? history = null,Object? requestedCount = null,Object? confirmedCount = null,Object? inProgressCount = null,Object? completedCount = null,Object? cancelledCount = null,}) {
  return _then(_self.copyWith(
active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as List<Booking>,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<Booking>,requestedCount: null == requestedCount ? _self.requestedCount : requestedCount // ignore: cast_nullable_to_non_nullable
as int,confirmedCount: null == confirmedCount ? _self.confirmedCount : confirmedCount // ignore: cast_nullable_to_non_nullable
as int,inProgressCount: null == inProgressCount ? _self.inProgressCount : inProgressCount // ignore: cast_nullable_to_non_nullable
as int,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,cancelledCount: null == cancelledCount ? _self.cancelledCount : cancelledCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardSummary].
extension DashboardSummaryPatterns on DashboardSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardSummary value)  $default,){
final _that = this;
switch (_that) {
case _DashboardSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardSummary value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Booking> active,  List<Booking> history,  int requestedCount,  int confirmedCount,  int inProgressCount,  int completedCount,  int cancelledCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
return $default(_that.active,_that.history,_that.requestedCount,_that.confirmedCount,_that.inProgressCount,_that.completedCount,_that.cancelledCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Booking> active,  List<Booking> history,  int requestedCount,  int confirmedCount,  int inProgressCount,  int completedCount,  int cancelledCount)  $default,) {final _that = this;
switch (_that) {
case _DashboardSummary():
return $default(_that.active,_that.history,_that.requestedCount,_that.confirmedCount,_that.inProgressCount,_that.completedCount,_that.cancelledCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Booking> active,  List<Booking> history,  int requestedCount,  int confirmedCount,  int inProgressCount,  int completedCount,  int cancelledCount)?  $default,) {final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
return $default(_that.active,_that.history,_that.requestedCount,_that.confirmedCount,_that.inProgressCount,_that.completedCount,_that.cancelledCount);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardSummary extends DashboardSummary {
  const _DashboardSummary({final  List<Booking> active = const <Booking>[], final  List<Booking> history = const <Booking>[], this.requestedCount = 0, this.confirmedCount = 0, this.inProgressCount = 0, this.completedCount = 0, this.cancelledCount = 0}): _active = active,_history = history,super._();
  

 final  List<Booking> _active;
@override@JsonKey() List<Booking> get active {
  if (_active is EqualUnmodifiableListView) return _active;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_active);
}

 final  List<Booking> _history;
@override@JsonKey() List<Booking> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

@override@JsonKey() final  int requestedCount;
@override@JsonKey() final  int confirmedCount;
@override@JsonKey() final  int inProgressCount;
@override@JsonKey() final  int completedCount;
@override@JsonKey() final  int cancelledCount;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardSummaryCopyWith<_DashboardSummary> get copyWith => __$DashboardSummaryCopyWithImpl<_DashboardSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardSummary&&const DeepCollectionEquality().equals(other._active, _active)&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.requestedCount, requestedCount) || other.requestedCount == requestedCount)&&(identical(other.confirmedCount, confirmedCount) || other.confirmedCount == confirmedCount)&&(identical(other.inProgressCount, inProgressCount) || other.inProgressCount == inProgressCount)&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount)&&(identical(other.cancelledCount, cancelledCount) || other.cancelledCount == cancelledCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_active),const DeepCollectionEquality().hash(_history),requestedCount,confirmedCount,inProgressCount,completedCount,cancelledCount);

@override
String toString() {
  return 'DashboardSummary(active: $active, history: $history, requestedCount: $requestedCount, confirmedCount: $confirmedCount, inProgressCount: $inProgressCount, completedCount: $completedCount, cancelledCount: $cancelledCount)';
}


}

/// @nodoc
abstract mixin class _$DashboardSummaryCopyWith<$Res> implements $DashboardSummaryCopyWith<$Res> {
  factory _$DashboardSummaryCopyWith(_DashboardSummary value, $Res Function(_DashboardSummary) _then) = __$DashboardSummaryCopyWithImpl;
@override @useResult
$Res call({
 List<Booking> active, List<Booking> history, int requestedCount, int confirmedCount, int inProgressCount, int completedCount, int cancelledCount
});




}
/// @nodoc
class __$DashboardSummaryCopyWithImpl<$Res>
    implements _$DashboardSummaryCopyWith<$Res> {
  __$DashboardSummaryCopyWithImpl(this._self, this._then);

  final _DashboardSummary _self;
  final $Res Function(_DashboardSummary) _then;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? active = null,Object? history = null,Object? requestedCount = null,Object? confirmedCount = null,Object? inProgressCount = null,Object? completedCount = null,Object? cancelledCount = null,}) {
  return _then(_DashboardSummary(
active: null == active ? _self._active : active // ignore: cast_nullable_to_non_nullable
as List<Booking>,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<Booking>,requestedCount: null == requestedCount ? _self.requestedCount : requestedCount // ignore: cast_nullable_to_non_nullable
as int,confirmedCount: null == confirmedCount ? _self.confirmedCount : confirmedCount // ignore: cast_nullable_to_non_nullable
as int,inProgressCount: null == inProgressCount ? _self.inProgressCount : inProgressCount // ignore: cast_nullable_to_non_nullable
as int,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,cancelledCount: null == cancelledCount ? _self.cancelledCount : cancelledCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
