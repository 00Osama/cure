import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/result.dart';
import '../../domain/usecase/get_available_nurses_usecase.dart';
import 'nurses_state.dart';

class NursesCubit extends Cubit<NursesState> {
  NursesCubit(this._getAvailableNursesUseCase) : super(const NursesState());

  static const int pageSize = 10;

  final GetAvailableNursesUseCase _getAvailableNursesUseCase;
  bool _isLoading = false;

  Future<void> loadFirstPage() async {
    if (_isLoading) return;
    _isLoading = true;
    emit(state.copyWith(status: NursesStatus.loading));

    final result = await _getAvailableNursesUseCase(limit: pageSize);
    _isLoading = false;

    switch (result) {
      case Success(:final data):
        emit(
          state.copyWith(
            status: NursesStatus.loaded,
            nurses: data.nurses,
            lastDocument: data.lastDocument,
            hasMore: data.hasMore,
          ),
        );
      case Failure(:final error):
        emit(
          state.copyWith(
            status: NursesStatus.error,
            errorMessage: error.toString(),
          ),
        );
    }
  }

  Future<void> loadNextPage() async {
    if (_isLoading || !state.hasMore || state.lastDocument == null) return;
    _isLoading = true;
    emit(state.copyWith(status: NursesStatus.loadingMore));

    final result = await _getAvailableNursesUseCase(
      limit: pageSize,
      startAfterDocument: state.lastDocument,
    );
    _isLoading = false;

    switch (result) {
      case Success(:final data):
        emit(
          state.copyWith(
            status: NursesStatus.loaded,
            nurses: [...state.nurses, ...data.nurses],
            lastDocument: data.lastDocument,
            hasMore: data.hasMore,
          ),
        );
      case Failure(:final error):
        emit(
          state.copyWith(
            status: NursesStatus.error,
            errorMessage: error.toString(),
          ),
        );
    }
  }
}
