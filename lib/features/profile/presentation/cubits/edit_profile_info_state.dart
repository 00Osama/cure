import '../../domain/entities/profile.dart';

enum EditProfileInfoStatus { initial, loading, loaded, saving, saved, failure }

class EditProfileInfoState {
  const EditProfileInfoState({
    this.status = EditProfileInfoStatus.initial,
    this.profile,
    this.selectedImagePath,
    this.errorMessage,
  });

  final EditProfileInfoStatus status;
  final Profile? profile;
  final String? selectedImagePath;
  final String? errorMessage;

  String get imagePath {
    return selectedImagePath ?? profile?.profileImagePath ?? 'default';
  }

  bool get isLoading => status == EditProfileInfoStatus.loading;
  bool get isSaving => status == EditProfileInfoStatus.saving;

  EditProfileInfoState copyWith({
    EditProfileInfoStatus? status,
    Profile? profile,
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
