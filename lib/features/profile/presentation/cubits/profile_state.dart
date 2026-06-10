import '../../domain/entities/profile.dart';

enum ProfileStatus { initial, loading, success, error, deleting, deleted }

class ProfileState {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.errorMessage,
  });

  final ProfileStatus status;
  final Profile? profile;
  final String? errorMessage;

  bool get isLoading => status == ProfileStatus.loading;
  bool get isDeleting => status == ProfileStatus.deleting;

  ProfileState copyWith({
    ProfileStatus? status,
    Profile? profile,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
    );
  }
}
