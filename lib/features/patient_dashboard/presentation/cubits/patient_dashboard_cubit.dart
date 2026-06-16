import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cure/core/utils/result.dart';
import '../../domain/usecase/patient_dashboard_usecase.dart';
import 'patient_dashboard_state.dart';

class PatientDashboardCubit extends Cubit<PatientDashboardState> {
  PatientDashboardCubit(this._useCase) : super(const PatientDashboardState());

  final PatientDashboardUseCase _useCase;

  Future<void> load() async {
    emit(state.copyWith(status: PatientDashboardStatus.loading));

    final activeResult = await _useCase.getActiveBookings();
    final completedResult = await _useCase.getCompletedBookings();

    if (activeResult is Failure || completedResult is Failure) {
      emit(
        state.copyWith(
          status: PatientDashboardStatus.error,
          errorMessage: 'Could not load bookings.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: PatientDashboardStatus.loaded,
        activeBookings: (activeResult as Success).data,
        completedBookings: (completedResult as Success).data,
      ),
    );
  }

  Future<void> closeBooking(String bookingId) async {
    emit(state.copyWith(closingBookingId: bookingId));
    final result = await _useCase.closeBooking(bookingId);

    if (result is Failure) {
      emit(
        state.copyWith(
          status: PatientDashboardStatus.error,
          errorMessage: result.error.toString(),
        ),
      );
      return;
    }

    await load();
  }
}
