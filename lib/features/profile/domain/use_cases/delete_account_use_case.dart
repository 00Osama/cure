import '../repositories/profile_repository.dart';

class DeleteAccountUseCase {
  const DeleteAccountUseCase(this._repository);

  final ProfileRepository _repository;

  Future<void> call(String role) {
    return _repository.deleteAccount(role);
  }
}
