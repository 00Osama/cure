import 'package:cure/core/utils/result.dart';

import '../entities/patient_dashboard_booking.dart';

abstract class PatientDashboardRepository {
  Future<Result<List<PatientDashboardBooking>>> getActiveBookings();
  Future<Result<List<PatientDashboardBooking>>> getCompletedBookings();
  Future<Result<void>> closeBooking(String bookingId);
}
