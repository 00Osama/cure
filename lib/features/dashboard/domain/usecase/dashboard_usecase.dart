import 'package:cure/features/booking/domain/entities/booking.dart';
import 'package:cure/features/booking/domain/entities/booking_status.dart';
import 'package:cure/features/booking/domain/repositories/booking_repository.dart';
import 'package:cure/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:cure/shared/utils/result.dart';

/// Builds the dashboard aggregate from the patient's bookings. Reuses the
/// booking repository (the dashboard is a read-only projection of bookings).
class DashboardUseCase {
  DashboardUseCase({required this.bookingRepository});

  final BookingRepository bookingRepository;

  Future<Result<DashboardSummary>> load(String patientId) async {
    final result = await bookingRepository.getMyBookings(patientId);
    switch (result) {
      case Success(:final data):
        return Success(summarize(data));
      case Failure(:final error):
        return Failure(error);
    }
  }

  Future<Result<Booking>> cancel(Booking booking) => bookingRepository
      .updateBookingStatus(booking: booking, target: BookingStatus.cancelled);

  /// Pure aggregation — split out so it can be unit-tested directly.
  DashboardSummary summarize(List<Booking> bookings) {
    int count(BookingStatus s) => bookings.where((b) => b.status == s).length;
    return DashboardSummary(
      active: bookings.where((b) => isActive(b.status)).toList(),
      history: bookings.where((b) => isTerminal(b.status)).toList(),
      requestedCount: count(BookingStatus.requested),
      confirmedCount: count(BookingStatus.confirmed),
      inProgressCount: count(BookingStatus.inProgress),
      completedCount: count(BookingStatus.completed),
      cancelledCount: count(BookingStatus.cancelled),
    );
  }
}
