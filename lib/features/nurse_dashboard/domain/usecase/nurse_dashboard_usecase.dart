import 'package:cure/core/utils/result.dart';

import '../entities/nurse_dashboard_booking.dart';
import '../repositories/nurse_dashboard_repository.dart';

class NurseDashboardUseCase {
  const NurseDashboardUseCase(this._repository);

  final NurseDashboardRepository _repository;

  Future<Result<List<NurseDashboardBooking>>> getActiveBookings() {
    return _repository.getActiveBookings();
  }

  Future<Result<List<NurseDashboardBooking>>> getCompletedBookings() {
    return _repository.getCompletedBookings();
  }
}
