import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

/// Exception thrown when authentication operations fail
class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

/// Remote data source for authentication operations using Supabase
/// swap out any backend here

abstract class AuthRemoteDataSource {
  Future<UserModel> register({required String email, required String password});

  Future<UserModel> signIn({required String email, required String password});

  Future<void> signOut();

  Future<UserModel?> getCurrentUser();
}

/// Implementation of AuthRemoteDataSource using Supabase
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<UserModel> register({
    required String email,
    required String password,
  }) async {
    try {
      // Call Supabase Auth to register
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      // Check if user was created
      if (response.user == null) {
        throw AuthException('Registration failed: No user returned');
      }

      // Convert Supabase user to our UserModel
      return _convertToUserModel(response.user!);
    } on AuthException {
      rethrow;
    } on AuthApiException catch (e) {
      throw AuthException('Registration failed: ${e.message}');
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
      // Call Supabase Auth to sign in
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // Check if user was authenticated
      if (response.user == null) {
        throw AuthException('Sign in failed: No user returned');
      }

      // Convert Supabase user to our UserModel
      return _convertToUserModel(response.user!);
    } on AuthException {
      rethrow;
    } on AuthApiException catch (e) {
      throw AuthException('Sign in failed: ${e.message}');
    } catch (e) {
      throw AuthException('Sign in failed: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } on AuthApiException catch (e) {
      throw AuthException('Sign out failed: ${e.message}');
    } catch (e) {
      throw AuthException('Sign out failed: $e');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = supabaseClient.auth.currentUser;

      if (user == null) {
        return null;
      }

      return _convertToUserModel(user);
    } catch (e) {
      throw AuthException('Failed to get current user: $e');
    }
  }

  /// Convert Supabase User to UserModel
  UserModel _convertToUserModel(User supabaseUser) {
    final metadata = supabaseUser.userMetadata ?? <String, dynamic>{};
    final parsedDob = () {
      final dobRaw = metadata['date_of_birth'] as String?;
      if (dobRaw == null) return DateTime.fromMillisecondsSinceEpoch(0);
      try {
        return DateTime.parse(dobRaw);
      } catch (_) {
        return DateTime.fromMillisecondsSinceEpoch(0);
      }
    }();

    return UserModel(
      id: supabaseUser.id,
      email: supabaseUser.email ?? '',
      name: (metadata['display_name'] as String?) ?? '',
      phoneNumber: metadata['phone_number'] as String?,
      dateOfBirth: parsedDob,
      gender: (metadata['gender'] as String?) ?? '',
      role: (metadata['role'] as String?) ?? '',
      yearOfExperience: metadata['year_of_experience'] as String?,
      region: metadata['region'] as String?,
      skillSet: metadata['skill_set'] as String?,
    );
  }
}
