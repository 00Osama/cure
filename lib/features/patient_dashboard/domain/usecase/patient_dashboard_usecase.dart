import 'package:cure/core/utils/result.dart';
import '../entities/patient_dashboard_booking.dart';
import '../repositories/patient_dashboard_repository.dart';

class PatientDashboardUseCase {
  const PatientDashboardUseCase(this._repository);

  final PatientDashboardRepository _repository;

  Future<Result<List<PatientDashboardBooking>>> getActiveBookings() {
    return _repository.getActiveBookings();
  }

  Future<Result<List<PatientDashboardBooking>>> getCompletedBookings() {
    return _repository.getCompletedBookings();
  }

  Future<Result<void>> closeBooking(String bookingId) {
    return _repository.closeBooking(bookingId);
  }
}
