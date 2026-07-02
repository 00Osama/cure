import '../repositories/profile_repository.dart';

class UploadProfileImageUseCase {
  const UploadProfileImageUseCase(this._repository);

  final ProfileRepository _repository;

  Future<String?> call(String imagePath) {
    return _repository.uploadProfileImage(imagePath);
  }
}
