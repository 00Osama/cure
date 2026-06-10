import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<void> call({
    required String name,
    required String phoneNumber,
    required DateTime dateOfBirth,
    required String gender,
    String? yearOfExperience,
    String? region,
    String? skillSet,
    String? profileImagePath,
  }) {
    return _repository.updateProfile(
      name: name,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
      gender: gender,
      yearOfExperience: yearOfExperience,
      region: region,
      skillSet: skillSet,
      profileImagePath: profileImagePath,
    );
  }
}
