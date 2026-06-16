import '../../domain/entities/nurse_dashboard_booking.dart';

enum NurseDashboardStatus { initial, loading, loaded, error }

class NurseDashboardState {
  const NurseDashboardState({
    this.status = NurseDashboardStatus.initial,
    this.activeBookings = const [],
    this.completedBookings = const [],
    this.errorMessage,
  });

  final NurseDashboardStatus status;
  final List<NurseDashboardBooking> activeBookings;
  final List<NurseDashboardBooking> completedBookings;
  final String? errorMessage;

  NurseDashboardState copyWith({
    NurseDashboardStatus? status,
    List<NurseDashboardBooking>? activeBookings,
    List<NurseDashboardBooking>? completedBookings,
    String? errorMessage,
  }) {
    return NurseDashboardState(
      status: status ?? this.status,
      activeBookings: activeBookings ?? this.activeBookings,
      completedBookings: completedBookings ?? this.completedBookings,
      errorMessage: errorMessage,
    );
  }
}
