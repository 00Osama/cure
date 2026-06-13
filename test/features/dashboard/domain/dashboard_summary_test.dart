import 'package:cure/features/booking_nurse/domain/entities/booking.dart';
import 'package:cure/features/booking_nurse/domain/entities/booking_status.dart';
import 'package:cure/features/booking_nurse/domain/repositories/booking_repository.dart';
import 'package:cure/features/patient_dashboard/domain/usecase/dashboard_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockBookingRepository extends Mock implements BookingRepository {}

Booking _booking(String id, BookingStatus status) => Booking(
  id: id,
  patientId: 'p',
  serviceId: 's',
  scheduledAt: DateTime(2026, 1, 1, 10),
  status: status,
  address: 'addr',
  price: 10,
);

void main() {
  final useCase = DashboardUseCase(bookingRepository: _MockBookingRepository());

  test('summarize partitions active vs history and counts by status', () {
    final summary = useCase.summarize([
      _booking('1', BookingStatus.requested),
      _booking('2', BookingStatus.confirmed),
      _booking('3', BookingStatus.inProgress),
      _booking('4', BookingStatus.completed),
      _booking('5', BookingStatus.cancelled),
    ]);

    expect(summary.active.length, 3);
    expect(summary.history.length, 2);
    expect(summary.total, 5);
    expect(summary.requestedCount, 1);
    expect(summary.confirmedCount, 1);
    expect(summary.inProgressCount, 1);
    expect(summary.completedCount, 1);
    expect(summary.cancelledCount, 1);
  });

  test('summarize of empty list yields an empty summary', () {
    final summary = useCase.summarize([]);
    expect(summary.total, 0);
    expect(summary.active, isEmpty);
    expect(summary.history, isEmpty);
  });
}
