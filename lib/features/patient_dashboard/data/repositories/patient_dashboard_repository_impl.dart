import 'package:cure/core/utils/result.dart';
import '../../domain/entities/patient_dashboard_booking.dart';
import '../../domain/repositories/patient_dashboard_repository.dart';
import '../datasources/patient_dashboard_remote_data_source.dart';

class PatientDashboardRepositoryImpl implements PatientDashboardRepository {
  const PatientDashboardRepositoryImpl(this._remoteDataSource);

  final PatientDashboardRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<PatientDashboardBooking>>> getActiveBookings() async {
    try {
      final models = await _remoteDataSource.getActiveBookings();
      return Success(models.map((model) => model.toEntity()).toList());
    } catch (error) {
      return Failure(Exception(error.toString()));
    }
  }

  @override
  Future<Result<List<PatientDashboardBooking>>> getCompletedBookings() async {
    try {
      final models = await _remoteDataSource.getCompletedBookings();
      return Success(models.map((model) => model.toEntity()).toList());
    } catch (error) {
      return Failure(Exception(error.toString()));
    }
  }

  @override
  Future<Result<void>> closeBooking(String bookingId) async {
    try {
      await _remoteDataSource.closeBooking(bookingId);
      return const Success(null);
    } catch (error) {
      return Failure(Exception(error.toString()));
    }
  }
}
