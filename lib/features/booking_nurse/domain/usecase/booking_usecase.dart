import '../../../../core/utils/result.dart';
import '../entities/availability_slot.dart';
import '../entities/booking.dart';
import '../entities/booking_status.dart';
import '../entities/service.dart';
import '../repositories/booking_repository.dart';

/// Application use cases for booking, exposed as a single facade (mirrors the
/// existing `AuthUseCase` convention in this codebase). Each method delegates
/// to the repository and returns a [Result].
class BookingUseCase {
  BookingUseCase({required this.repository});

  final BookingRepository repository;

  Future<Result<List<Service>>> getServices() => repository.getServices();

  Future<Result<List<AvailabilitySlot>>> getAvailability({
    required String region,
    required DateTime day,
  }) => repository.getAvailability(region: region, day: day);

  Future<Result<Booking>> createBooking(Booking draft) =>
      repository.createBooking(draft);

  Future<Result<List<Booking>>> getMyBookings(String patientId) =>
      repository.getMyBookings(patientId);

  Future<Result<Booking>> updateStatus({
    required Booking booking,
    required BookingStatus target,
  }) => repository.updateBookingStatus(booking: booking, target: target);

  Future<Result<List<Booking>>> getIncomingRequests() =>
      repository.getIncomingRequests();
}
