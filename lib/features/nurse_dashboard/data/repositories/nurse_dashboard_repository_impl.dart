import 'package:cure/core/utils/result.dart';

import '../../domain/entities/nurse_dashboard_booking.dart';
import '../../domain/repositories/nurse_dashboard_repository.dart';
import '../datasources/nurse_dashboard_remote_data_source.dart';

class NurseDashboardRepositoryImpl implements NurseDashboardRepository {
  const NurseDashboardRepositoryImpl(this._remoteDataSource);

  final NurseDashboardRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<NurseDashboardBooking>>> getActiveBookings() async {
    try {
      final models = await _remoteDataSource.getActiveBookings();
      return Success(models.map((model) => model.toEntity()).toList());
    } catch (error) {
      return Failure(Exception(error.toString()));
    }
  }

  @override
  Future<Result<List<NurseDashboardBooking>>> getCompletedBookings() async {
    try {
      final models = await _remoteDataSource.getCompletedBookings();
      return Success(models.map((model) => model.toEntity()).toList());
    } catch (error) {
      return Failure(Exception(error.toString()));
    }
  }
}
