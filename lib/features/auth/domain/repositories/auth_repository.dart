import '../../../../core/utils/result.dart';
import '../entities/user.dart';



abstract class AuthRepository {
  
  // register outline
  Future<Result<User>> register({
    required String email,
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
