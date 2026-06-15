import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_profile_use_case.dart';
import '../../domain/use_cases/update_profile_use_case.dart';
import '../../domain/use_cases/upload_profile_image_use_case.dart';
import 'edit_profile_info_state.dart';

class EditProfileInfoCubit extends Cubit<EditProfileInfoState> {
  EditProfileInfoCubit({
    required this._getProfileUseCase,
    required this._updateProfileUseCase,
    required this._uploadProfileImageUseCase,
  }) : super(const EditProfileInfoState());

  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final UploadProfileImageUseCase _uploadProfileImageUseCase;

  Future<void> loadProfile() async {
    emit(state.copyWith(status: EditProfileInfoStatus.loading));

    try {
      final profile = await _getProfileUseCase();
      emit(
        state.copyWith(status: EditProfileInfoStatus.loaded, profile: profile),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: EditProfileInfoStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void selectProfileImage(String imagePath) {
    emit(
      state.copyWith(
        status: EditProfileInfoStatus.loaded,
        selectedImagePath: imagePath,
      ),
    );
  }

  Future<void> saveProfile({
    required String name,
    required String phoneNumber,
    required DateTime dateOfBirth,
    required String gender,
    String? yearOfExperience,
    String? region,
    String? skillSet,
    String? role,
  }) async {
    final currentProfile = state.profile;
    if (currentProfile == null) {
      emit(
        state.copyWith(
          status: EditProfileInfoStatus.failure,
          errorMessage: 'Profile is not loaded.',
        ),
      );
      return;
    }

    final effectiveRole = role ?? currentProfile.role;
    emit(state.copyWith(status: EditProfileInfoStatus.saving));

    try {
      final selectedImagePath = state.selectedImagePath;
      String? profileImagePath;
      if (selectedImagePath != null &&
          selectedImagePath.isNotEmpty &&
          selectedImagePath != currentProfile.profileImagePath) {
        profileImagePath = await _uploadProfileImageUseCase(selectedImagePath);
      }

      await _updateProfileUseCase(
        name: name,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        gender: gender,
        yearOfExperience: yearOfExperience,
        region: region,
        skillSet: skillSet,
        profileImagePath: profileImagePath,
        role: effectiveRole,
      );

      final updatedProfile = await _getProfileUseCase();
      emit(
        state.copyWith(
          status: EditProfileInfoStatus.saved,
          profile: updatedProfile ?? state.profile,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: EditProfileInfoStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
