import 'package:cure/core/utils/result.dart';

import '../entities/nurse_dashboard_booking.dart';

abstract class NurseDashboardRepository {
  Future<Result<List<NurseDashboardBooking>>> getActiveBookings();
  Future<Result<List<NurseDashboardBooking>>> getCompletedBookings();
}
