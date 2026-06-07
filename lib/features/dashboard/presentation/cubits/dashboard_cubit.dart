import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cure/core/notifications/notification_service.dart';
import 'package:cure/features/booking/domain/entities/booking.dart';
import 'package:cure/features/booking/domain/entities/booking_status.dart';
import 'package:cure/features/dashboard/domain/usecase/dashboard_usecase.dart';
import 'package:cure/features/dashboard/presentation/cubits/dashboard_state.dart';
import 'package:cure/shared/utils/result.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required this.useCase,
    required this.patientId,
    this.notificationService,
  }) : super(const DashboardState.initial());

  final DashboardUseCase useCase;
  final String patientId;
  final NotificationService? notificationService;

  final Map<String, BookingStatus> _lastSeen = {};

  Future<void> load() async {
    emit(const DashboardState.loading());
    final result = await useCase.load(patientId);
    switch (result) {
      case Success(:final data):
        _notifyStatusChanges([...data.active, ...data.history]);
        emit(DashboardState.loaded(data));
      case Failure(:final error):
        emit(DashboardState.error(error.toString()));
    }
  }

  /// Poll-based status-change notifications: when a booking's status differs
  /// from the previously seen value, raise a local notification. A production
  /// setup would push this from a server (see README "FCM").
  void _notifyStatusChanges(List<Booking> bookings) {
    final service = notificationService;
    final firstLoad = _lastSeen.isEmpty;
    for (final booking in bookings) {
      final previous = _lastSeen[booking.id];
      _lastSeen[booking.id] = booking.status;
      if (service != null &&
          !firstLoad &&
          previous != null &&
          previous != booking.status) {
        service.showLocal(
          title: 'Booking update',
          body: 'Status changed to ${booking.status.name}',
        );
      }
    }
  }

  /// Cancels a booking, then refreshes. The deterministic state machine in the
  /// repository rejects illegal cancels, so a failed attempt simply leaves the
  /// booking unchanged after the refresh.
  Future<void> cancelBooking(Booking booking) async {
    await useCase.cancel(booking);
    await load();
  }
}
