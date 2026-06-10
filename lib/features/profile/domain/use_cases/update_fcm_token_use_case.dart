import '../repositories/profile_repository.dart';

class UpdateFcmTokenUseCase {
  const UpdateFcmTokenUseCase(this._repository);

  final ProfileRepository _repository;

  Future<void> call(String token) {
    return _repository.updateFcmToken(token);
  }
}
