import 'dart:io';
import 'package:cure/core/network/api_config.dart';
import 'package:cure/features/profile/data_sources/profile_remote_datasource.dart';
import 'package:cure/features/auth/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum EditProfileInfoStatus { initial, loading, loaded, saving, saved, failure }

class EditProfileInfoState {
  const EditProfileInfoState({
    this.status = EditProfileInfoStatus.initial,
    this.profile,
    this.selectedImagePath,
    this.errorMessage,
  });

  final EditProfileInfoStatus status;
  final UserModel? profile;
  final String? selectedImagePath;
  final String? errorMessage;

  String get imagePath {
    return selectedImagePath ?? profile?.profileImagePath ?? 'default';
  }

  bool get isLoading => status == EditProfileInfoStatus.loading;
  bool get isSaving => status == EditProfileInfoStatus.saving;

  EditProfileInfoState copyWith({
    EditProfileInfoStatus? status,
    UserModel? profile,
    String? selectedImagePath,
    String? errorMessage,
  }) {
    return EditProfileInfoState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      selectedImagePath: selectedImagePath ?? this.selectedImagePath,
      errorMessage: errorMessage,
    );
  }
}

class EditProfileInfoCubit extends Cubit<EditProfileInfoState> {
  EditProfileInfoCubit({
    required this._profileRemoteDataSource,
    required this._currentUid,
  }) : super(const EditProfileInfoState());

  final ProfileRemoteDataSource _profileRemoteDataSource;
  final String? Function() _currentUid;

  Future<void> loadProfile() async {
    emit(state.copyWith(status: EditProfileInfoStatus.loading));
    final uid = _currentUid();
    if (uid == null) {
      emit(
        state.copyWith(
          status: EditProfileInfoStatus.failure,
          errorMessage: 'Missing current user.',
        ),
      );
      return;
    }

    try {
      final profile = await _profileRemoteDataSource.getProfileById(uid);
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
  }) async {
    final uid = _currentUid();
    final profile = state.profile;
    if (uid == null || profile == null) {
      emit(
        state.copyWith(
          status: EditProfileInfoStatus.failure,
          errorMessage: 'Profile is not loaded.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: EditProfileInfoStatus.saving));

    try {
      final fields = <String, dynamic>{
        'name': name.trim(),
        'phone_number': phoneNumber.trim(),
        'date_of_birth': dateOfBirth.toIso8601String(),
        'gender': gender,
      };

      if (profile.role == 'nurse') {
        fields.addAll({
          'year_of_experience': yearOfExperience,
          'region': region,
          'skill_set': skillSet?.trim(),
        });
      }

      final selectedImagePath = state.selectedImagePath;
      if (selectedImagePath != null &&
          selectedImagePath.isNotEmpty &&
          selectedImagePath != profile.profileImagePath) {
        final localPath = await _copyProfileImageLocally(
          uid: uid,
          sourcePath: selectedImagePath,
        );
        final remoteUrl = await _uploadProfileImage(
          localPath: localPath,
          uid: uid,
          role: profile.role,
        );
        fields['profile_image_url'] = remoteUrl ?? localPath;
      }

      await _profileRemoteDataSource.updateProfileFields(uid, fields);
      final updatedProfile = await _profileRemoteDataSource.getProfileById(uid);
      emit(
        state.copyWith(
          status: EditProfileInfoStatus.saved,
          profile: updatedProfile ?? profile,
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

  Future<String> _copyProfileImageLocally({
    required String uid,
    required String sourcePath,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    final extension = sourcePath.split('.').last;
    final target = File(
      '${directory.path}${Platform.pathSeparator}profile_$uid.$extension',
    );
    return File(sourcePath).copy(target.path).then((file) => file.path);
  }

  Future<String?> _uploadProfileImage({
    required String localPath,
    required String uid,
    required String role,
  }) async {
    if (!ApiConfig.hasAnonKey) return null;

    final bucket = role == 'nurse'
        ? 'nurses_profile_images'
        : 'patients_profile_images';
    final extension = localPath.split('.').last;
    final storagePath =
        '${uid}_${DateTime.now().millisecondsSinceEpoch}.$extension';

    await Supabase.instance.client.storage
        .from(bucket)
        .upload(storagePath, File(localPath));

    return Supabase.instance.client.storage
        .from(bucket)
        .getPublicUrl(storagePath);
  }
}
