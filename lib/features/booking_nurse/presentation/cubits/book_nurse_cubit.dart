import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/result.dart';
import '../../domain/entities/nurse_booking.dart';
import '../../domain/usecase/book_nurse_usecase.dart';
import 'book_nurse_state.dart';

class BookNurseCubit extends Cubit<BookNurseState> {
  BookNurseCubit(this._bookNurseUseCase) : super(const BookNurseState());

  final BookNurseUseCase _bookNurseUseCase;

  Future<void> bookNurse(NurseBooking booking) async {
    emit(state.copyWith(status: BookNurseStatus.loading));

    final result = await _bookNurseUseCase(booking);

    switch (result) {
      case Success():
        emit(state.copyWith(status: BookNurseStatus.success));
      case Failure(:final error):
        emit(
          state.copyWith(
            status: BookNurseStatus.error,
            errorMessage: error.toString(),
          ),
        );
    }
  }
}
