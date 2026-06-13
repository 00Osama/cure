import 'package:cure/features/booking_nurse/data/datasources/booking_remote_datasource.dart';
import 'package:cure/features/booking_nurse/data/models/service_model.dart';
import 'package:cure/features/booking_nurse/data/repositories/booking_repository_impl.dart';
import 'package:cure/features/booking_nurse/domain/entities/booking.dart';
import 'package:cure/features/booking_nurse/domain/entities/booking_status.dart';
import 'package:cure/features/booking_nurse/domain/entities/service.dart';
import 'package:cure/core/utils/failures.dart' as f;
import 'package:cure/core/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDataSource extends Mock implements BookingRemoteDataSource {}

void main() {
  setUpAll(() => registerFallbackValue(BookingStatus.requested));

  late _MockDataSource ds;
  late BookingRepositoryImpl repo;

  setUp(() {
    ds = _MockDataSource();
    repo = BookingRepositoryImpl(remoteDataSource: ds);
  });

  test('getServices maps models to entities on success', () async {
    when(() => ds.getServices()).thenAnswer(
      (_) async => [
        const ServiceModel(id: '1', key: 'basicCare', basePrice: 50),
      ],
    );

    final result = await repo.getServices();

    expect(result, isA<Success<List<Service>>>());
    expect((result as Success<List<Service>>).data.first.key, 'basicCare');
  });

  test('getServices maps a thrown failure to Result.Failure', () async {
    when(() => ds.getServices()).thenThrow(const f.NetworkFailure('offline'));

    final result = await repo.getServices();

    expect(result, isA<Failure<List<Service>>>());
  });

  test(
    'updateBookingStatus rejects an illegal transition without a network call',
    () async {
      final completed = Booking(
        id: 'b',
        patientId: 'p',
        serviceId: 's',
        scheduledAt: DateTime(2026),
        status: BookingStatus.completed,
        address: 'a',
        price: 1,
      );

      final result = await repo.updateBookingStatus(
        booking: completed,
        target: BookingStatus.inProgress,
      );

      expect(result, isA<Failure<Booking>>());
      verifyNever(
        () => ds.updateStatus(
          bookingId: any(named: 'bookingId'),
          status: any(named: 'status'),
        ),
      );
    },
  );
}
