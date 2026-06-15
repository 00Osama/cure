import '../../../../core/utils/result.dart';
import '../entities/booking.dart';
import '../entities/booking_status.dart';

abstract class BookingRepository {
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
