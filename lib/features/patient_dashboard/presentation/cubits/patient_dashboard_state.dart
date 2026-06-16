import '../../domain/entities/patient_dashboard_booking.dart';

enum PatientDashboardStatus { initial, loading, loaded, error }

class PatientDashboardState {
  const PatientDashboardState({
    this.status = PatientDashboardStatus.initial,
    this.activeBookings = const [],
    this.completedBookings = const [],
    this.errorMessage,
    this.closingBookingId,
  });

  final PatientDashboardStatus status;
  final List<PatientDashboardBooking> activeBookings;
  final List<PatientDashboardBooking> completedBookings;
  final String? errorMessage;
  final String? closingBookingId;

  PatientDashboardState copyWith({
    PatientDashboardStatus? status,
    List<PatientDashboardBooking>? activeBookings,
    List<PatientDashboardBooking>? completedBookings,
    String? errorMessage,
    String? closingBookingId,
  }) {
    return PatientDashboardState(
      status: status ?? this.status,
      activeBookings: activeBookings ?? this.activeBookings,
      completedBookings: completedBookings ?? this.completedBookings,
      errorMessage: errorMessage,
      closingBookingId: closingBookingId,
    );
  }
}
