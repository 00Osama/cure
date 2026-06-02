import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/user.dart' as domain;
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart' as datasource;

class AuthRepositoryImpl implements AuthRepository {
  final datasource.AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;
  final SupabaseClient supabaseClient;

  // Key for storing session flag in secure storage
  static const String _sessionKey = 'supabase_session_active';

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
    required this.supabaseClient,
  });

  @override
  Future<Result<domain.User>> register({
    required String email,
    required String password,
  }) async {
    try {
      // Call remote data source to register
      final userModel = await remoteDataSource.register(
        email: email,
        password: password,
      );

      // Persist session after successful registration (Requirement 1.1)
      await _saveSession();

      // Convert model to domain entity and return success
      return Success(userModel.toDomain());
    } on datasource.AuthException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(Exception('Unexpected error during registration: $e'));
    }
  }

  @override
  Future<Result<domain.User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Call remote data source to sign in
      final userModel = await remoteDataSource.signIn(
        email: email,
        password: password,
      );

      // Persist session after successful sign in (Requirement 1.2)
      await _saveSession();

      // Convert model to domain entity and return success
      return Success(userModel.toDomain());
    } on datasource.AuthException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(Exception('Unexpected error during sign in: $e'));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      // Sign out from Supabase
      await remoteDataSource.signOut();

      // Clear stored session (Requirement 1.5)
      await _clearSession();

      return const Success(null);
    } on datasource.AuthException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(Exception('Unexpected error during sign out: $e'));
    }
  }

  @override
  Future<Result<domain.User?>> restoreSession() async {
    try {
      // Check if we have a stored session flag
      final hasSession = await secureStorage.read(key: _sessionKey);

      if (hasSession == null) {
        // No stored session
        return const Success(null);
      }

      // Check if Supabase has a current session
      final currentSession = supabaseClient.auth.currentSession;

      if (currentSession == null) {
        // Session expired or invalid, clear it
        await _clearSession();
        return const Success(null);
      }

      // Get current user from Supabase
      final userModel = await remoteDataSource.getCurrentUser();

      if (userModel == null) {
        // No user found, clear session
        await _clearSession();
        return const Success(null);
      }

      // Session is valid, return user
      return Success(userModel.toDomain());
    } catch (e) {
      // On any error, clear the session and return null
      await _clearSession();
      return const Success(null);
    }
  }

  @override
  Future<domain.User?> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return userModel?.toDomain();
    } catch (e) {
      return null;
    }
  }

  /// Save session flag to secure storage
  Future<void> _saveSession() async {
    try {
      await secureStorage.write(
        key: _sessionKey,
        value: 'true',
      );
    } catch (e) {
      // Non-fatal: session persistence failed but auth succeeded
      // In production, this should be logged
    }
  }

  /// Clear session flag from secure storage
  Future<void> _clearSession() async {
    try {
      await secureStorage.delete(key: _sessionKey);
    } catch (e) {
      // Non-fatal: clearing session failed
      // In production, this should be logged
    }
  }
}
