import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:cure/features/booking/domain/entities/booking.dart';

part 'dashboard_summary.freezed.dart';

/// Aggregated view of a patient's bookings for the dashboard: the active and
/// historical lists plus per-status counts.
@freezed
abstract class DashboardSummary with _$DashboardSummary {
  const DashboardSummary._();

  const factory DashboardSummary({
    @Default(<Booking>[]) List<Booking> active,
    @Default(<Booking>[]) List<Booking> history,
    @Default(0) int requestedCount,
    @Default(0) int confirmedCount,
    @Default(0) int inProgressCount,
    @Default(0) int completedCount,
    @Default(0) int cancelledCount,
  }) = _DashboardSummary;

  int get total => active.length + history.length;
}
