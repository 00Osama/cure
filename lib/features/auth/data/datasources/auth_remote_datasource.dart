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
  /// Register a new user with email and password
  Future<UserModel> register({
    required String email,
    required String password,
  });

  /// Sign in with email and password
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  /// Sign out the current user
  Future<void> signOut();

  /// Get the current authenticated user
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
      // Validate credentials before making the call (Requirement 1.3)
      _validateCredentials(email, password);

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
      // Validate credentials before making the call (Requirement 1.3)
      _validateCredentials(email, password);

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

  /// Validate email and password credentials (Requirement 1.3)
  /// Throws AuthException if credentials are empty, incomplete, or malformed
  void _validateCredentials(String email, String password) {
    // Check if email or password is empty
    if (email.trim().isEmpty) {
      throw AuthException('Email cannot be empty');
    }

    if (password.isEmpty) {
      throw AuthException('Password cannot be empty');
    }

    // Validate email format
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(email)) {
      throw AuthException('Invalid email format');
    }

    // Validate password length (minimum 6 characters)
    if (password.length < 6) {
      throw AuthException('Password must be at least 6 characters');
    }
  }

  /// Convert Supabase User to UserModel
  UserModel _convertToUserModel(User supabaseUser) {
    return UserModel(
      id: supabaseUser.id,
      email: supabaseUser.email ?? '',
      displayName: supabaseUser.userMetadata?['display_name'] as String?,
    );
  }
}
