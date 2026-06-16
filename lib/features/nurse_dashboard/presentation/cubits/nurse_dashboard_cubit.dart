import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cure/core/utils/result.dart';
import '../../domain/usecase/nurse_dashboard_usecase.dart';
import 'nurse_dashboard_state.dart';

class NurseDashboardCubit extends Cubit<NurseDashboardState> {
  NurseDashboardCubit(this._useCase) : super(const NurseDashboardState());

  final NurseDashboardUseCase _useCase;

  Future<void> load() async {
    emit(state.copyWith(status: NurseDashboardStatus.loading));

    final activeResult = await _useCase.getActiveBookings();
    final completedResult = await _useCase.getCompletedBookings();

    if (activeResult is Failure || completedResult is Failure) {
      emit(
        state.copyWith(
          status: NurseDashboardStatus.error,
          errorMessage: 'Could not load bookings.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: NurseDashboardStatus.loaded,
        activeBookings: (activeResult as Success).data,
        completedBookings: (completedResult as Success).data,
      ),
    );
  }
}
