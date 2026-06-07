import '../../../../shared/utils/result.dart';
import '../entities/availability_slot.dart';
import '../entities/booking.dart';
import '../entities/booking_status.dart';
import '../entities/service.dart';

/// Contract for booking data access. Implementations live in the data layer;
/// every method returns a [Result] so callers handle success/failure
/// explicitly without try/catch.
abstract class BookingRepository {
  Future<Result<List<Service>>> getServices();

  Future<Result<List<AvailabilitySlot>>> getAvailability({
    required String region,
    required DateTime day,
  });

  Future<Result<Booking>> createBooking(Booking draft);

  Future<Result<List<Booking>>> getMyBookings(String patientId);

  /// Validates the transition (deterministic state machine) before persisting.
  Future<Result<Booking>> updateBookingStatus({
    required Booking booking,
    required BookingStatus target,
  });

  /// Read-only list of `requested` bookings (nurse "incoming" view).
  Future<Result<List<Booking>>> getIncomingRequests();
}
