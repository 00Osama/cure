import '../../../../core/utils/result.dart';
import '../entities/booking.dart';
import '../entities/booking_status.dart';
import '../repositories/booking_repository.dart';

class BookingUseCase {
  BookingUseCase({required this.repository});

  final BookingRepository repository;

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
