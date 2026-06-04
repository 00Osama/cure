import 'package:cure/features/auth/domain/entities/nurse.dart';
import 'package:cure/features/auth/domain/entities/patient.dart';
import 'package:cure/features/auth/domain/entities/user.dart' as domain;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../shared/utils/result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_datasource.dart' as datasource;
import '../models/user_model.dart';

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
  Future<Result<domain.User>> nurseRegister({
    required Nurse nurse,
    required String password,
  }) async {
    try {
      // Create auth user via remote data source (password-based)
      final createdAuthModel = await remoteDataSource.register(
        email: nurse.email,
        password: password,
      );

      final authUserId = createdAuthModel.id;

      // Insert profile row using auth user id
      final inserted = await supabaseClient
          .from('users')
          .insert({
            'id': authUserId,
            'name': nurse.name,
            'email': nurse.email,
            'phone_number': nurse.phoneNumber,
            'date_of_birth': nurse.dateOfBirth.toIso8601String(),
            'gender': nurse.gender,
            'role': 'nurse',
            'year_of_experience': nurse.yearOfExperience,
            'region': nurse.region,
            'skill_set': nurse.skillSet,
          })
          .select()
          .single();

      // Only persist session if Supabase actually has a current session
      if (supabaseClient.auth.currentSession != null) {
        await _saveSession();
      }

      final userModel = UserModel.fromJson(inserted);
      return Success(userModel.toDomain());
    } catch (e) {
      return Failure(Exception('Nurse registration failed: $e'));
    }
  }

  @override
  Future<Result<domain.User>> patientRegister({
    required Patient patient,
    required String password,
  }) async {
    try {
      // Create auth user via remote data source (password-based)
      final createdAuthModel = await remoteDataSource.register(
        email: patient.email,
        password: password,
      );

      final authUserId = createdAuthModel.id;

      // Insert profile row using auth user id
      final inserted = await supabaseClient
          .from('users')
          .insert({
            'id': authUserId,
            'name': patient.name,
            'email': patient.email,
            'phone_number': patient.phoneNumber,
            'date_of_birth': patient.dateOfBirth.toIso8601String(),
            'gender': patient.gender,
            'role': 'patient',

            // nurse fields null
            'year_of_experience': null,
            'region': null,
            'skill_set': null,
          })
          .select()
          .single();

      // Only persist session if Supabase actually has a current session
      if (supabaseClient.auth.currentSession != null) {
        await _saveSession();
      }

      final userModel = UserModel.fromJson(inserted);
      return Success(userModel.toDomain());
    } catch (e) {
      return Failure(Exception('Patient registration failed: $e'));
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

      // Persist session after successful sign in
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
      await secureStorage.write(key: _sessionKey, value: 'true');
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
