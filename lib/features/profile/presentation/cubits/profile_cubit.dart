import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/delete_account_use_case.dart';
import '../../domain/use_cases/get_profile_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this._getProfileUseCase,
    required this._deleteAccountUseCase,
    required this._logoutUseCase,
  }) : super(const ProfileState());

  final GetProfileUseCase _getProfileUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final LogoutUseCase _logoutUseCase;

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final profile = await _getProfileUseCase();
      emit(state.copyWith(status: ProfileStatus.success, profile: profile));
    } catch (e) {
      emit(
        state.copyWith(status: ProfileStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<bool> deleteAccount(String role) async {
    emit(state.copyWith(status: ProfileStatus.deleting));
    try {
      await _deleteAccountUseCase(role);
      emit(state.copyWith(status: ProfileStatus.deleted));
      return true;
    } catch (e) {
      emit(
        state.copyWith(status: ProfileStatus.error, errorMessage: e.toString()),
      );
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await _logoutUseCase();
      return true;
    } catch (e) {
      emit(
        state.copyWith(status: ProfileStatus.error, errorMessage: e.toString()),
      );
      return false;
    }
  }
}
