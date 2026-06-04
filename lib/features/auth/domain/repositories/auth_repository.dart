import 'package:cure/features/auth/domain/entities/nurse.dart';
import 'package:cure/features/auth/domain/entities/patient.dart';
import 'package:cure/features/auth/domain/entities/user.dart';
import '../../../../shared/utils/result.dart';

// outline for auth operations

abstract class AuthRepository {
  // patient register outline
  Future<Result<User>> patientRegister({
    required Patient patient,
    required String password,
  });

  // nurse register outline
  Future<Result<User>> nurseRegister({
    required Nurse nurse,
    required String password,
  });

  // signIn outline
  Future<Result<User>> signIn({
    required String email,
    required String password,
  });

  // signOut outline
  Future<Result<void>> signOut();

  // restoreSession outlint
  Future<Result<User?>> restoreSession();

  // getCurrentUser outline
  Future<User?> getCurrentUser();
}
