import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

/// Exception thrown when authentication operations fail
class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

/// Remote data source for authentication operations using Firebase Auth
/// swap out any backend here

abstract class AuthRemoteDataSource {
  Future<UserModel> register({required String email, required String password});

  Future<UserModel> signIn({required String email, required String password});

  Future<void> signOut();

  Future<UserModel?> getCurrentUser();
}

/// Implementation of AuthRemoteDataSource using Firebase Auth
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  Future<UserModel> register({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw AuthException('Registration failed: No user returned');
      }
      return _convertToUserModel(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthException('email-already-in-use');
      } else if (e.code == 'weak-password') {
        throw AuthException('weak-password');
      } else if (e.code == 'invalid-email') {
        throw AuthException('invalid-email');
      } else {
        throw AuthException('Registration failed: ${e.message}');
      }
    } catch (e) {
      throw AuthException('Registration failed: $e');
    }
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user;
      return _convertToUserModel(user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('user-not-found');
      } else if (e.code == 'wrong-password') {
        throw AuthException('wrong-password');
      } else {
        throw AuthException('Unexpected error occurred. Please try again.');
      }
    } catch (e) {
      throw AuthException('Unexpected error occurred. Please try again.');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException('Sign out failed: ${e.message}');
    } catch (e) {
      throw AuthException('Sign out failed: $e');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        return null;
      }
      return _convertToUserModel(user);
    } catch (e) {
      throw AuthException('Failed to get current user: $e');
    }
  }

  UserModel _convertToUserModel(User firebaseUser) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: '',
      phoneNumber: '',
      profileImagePath: '',
      dateOfBirth: DateTime(2000, 1, 1),
      gender: '',
      role: '',
    );
  }
}
