import 'package:cure/features/auth/domain/entities/nurse.dart';
import 'package:cure/features/auth/domain/entities/patient.dart';
import 'package:cure/features/auth/domain/entities/user.dart';
import '../../../../shared/utils/result.dart';
import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository authRepository;
  AuthUseCase({required this.authRepository});

  Future<Result<User>> patientRegisterUseCase({
    required Patient patient,
    required String password,
  }) {
    return authRepository.patientRegister(patient: patient, password: password);
  }

  Future<Result<User>> nurseRegisterUseCase({
    required Nurse nurse,
    required String password,
  }) {
    return authRepository.nurseRegister(nurse: nurse, password: password);
  }

  Future<Result<User>> signInUseCase({
    required String email,
    required String password,
  }) {
    return authRepository.signIn(email: email, password: password);
  }

  Future<Result<void>> signOutUseCase() {
    return authRepository.signOut();
  }

  Future<Result<User?>> restoreSession() {
    return authRepository.restoreSession();
  }

  Future<User?> getCurrentUser() {
    return authRepository.getCurrentUser();
  }
}
