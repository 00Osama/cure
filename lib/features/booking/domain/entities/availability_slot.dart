import 'package:freezed_annotation/freezed_annotation.dart';

part 'availability_slot.freezed.dart';

/// A bookable time window offered by a nurse in a given region.
@freezed
abstract class AvailabilitySlot with _$AvailabilitySlot {
  const factory AvailabilitySlot({
    required String id,
    required String nurseId,
    required String region,
    required DateTime startsAt,
    required DateTime endsAt,
    @Default(false) bool isBooked,
  }) = _AvailabilitySlot;
}
