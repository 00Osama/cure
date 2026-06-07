import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/availability_slot.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/service.dart';

part 'booking_state.freezed.dart';

/// Steps of the booking wizard (the UI-level progression).
enum BookingStep { selectService, schedule, details, review, success }

/// Single immutable state object driving the whole booking wizard. Keeping one
/// state with a [step] field (rather than separate classes per step) makes the
/// multi-screen flow deterministic and trivial to drive in `bloc_test`.
@freezed
abstract class BookingState with _$BookingState {
  const factory BookingState({
    @Default(BookingStep.selectService) BookingStep step,
    @Default(false) bool isLoading,
    @Default(<Service>[]) List<Service> services,
    Service? selectedService,
    @Default(<AvailabilitySlot>[]) List<AvailabilitySlot> slots,
    AvailabilitySlot? selectedSlot,
    String? region,
    DateTime? scheduledAt,
    String? address,
    String? remarks,
    Booking? confirmed,
    String? error,
  }) = _BookingState;
}
