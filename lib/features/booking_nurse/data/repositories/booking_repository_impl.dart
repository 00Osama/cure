import '../../../../core/network/network_exception_mapper.dart';
import '../../../../core/utils/failures.dart' as f;
import '../../../../core/utils/result.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_status.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_datasource.dart';
import '../models/booking_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  BookingRepositoryImpl({required this.remoteDataSource});

  final BookingRemoteDataSource remoteDataSource;

  @override
  Future<Result<Booking>> createBooking(Booking draft) async {
    try {
      final body = BookingModel.toInsertJson(
        patientId: draft.patientId,
        nurseId: draft.nurseId,
        serviceId: draft.serviceId,
        scheduledAt: draft.scheduledAt,
        address: draft.address,
        remarks: draft.remarks,
        price: draft.price,
        status: draft.status,
      );
      final model = await remoteDataSource.createBooking(body);
      return Success(model.toEntity());
    } catch (e) {
      return Failure(mapDioError(e));
    }
  }

  @override
  Future<Result<List<Booking>>> getMyBookings(String patientId) async {
    try {
      final models = await remoteDataSource.getMyBookings(patientId);
      return Success(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Failure(mapDioError(e));
    }
  }

  @override
  Future<Result<Booking>> updateBookingStatus({
    required Booking booking,
    required BookingStatus target,
  }) async {
    try {
      // Enforce the deterministic state machine BEFORE hitting the network —
      // an illegal transition never reaches the server.
      final next = transition(booking.status, target);
      final model = await remoteDataSource.updateStatus(
        bookingId: booking.id,
        status: next,
      );
      return Success(model.toEntity());
    } on InvalidTransitionException catch (e) {
      return Failure(f.ServerFailure(e.toString()));
    } catch (e) {
      return Failure(mapDioError(e));
    }
  }

  @override
  Future<Result<List<Booking>>> getIncomingRequests() async {
    try {
      final models = await remoteDataSource.getIncomingRequests();
      return Success(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Failure(mapDioError(e));
    }
  }
}
