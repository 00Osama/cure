import '../../../profile/data_sources/profile_remote_datasource.dart';
import 'package:cure/features/auth/domain/entities/nurse.dart';
import 'package:cure/features/auth/domain/entities/patient.dart';
import 'package:cure/features/auth/domain/entities/user.dart' as domain;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/utils/result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_datasource.dart' as datasource;
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final datasource.AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;
  final ProfileRemoteDataSource profileRemoteDataSource;

  // Key for storing session flag in secure storage
  static const String _sessionKey = 'auth_session_active';

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
    required this.profileRemoteDataSource,
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
      Map<String, String?> nurseData = {
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
        'profile_image_url': nurse.profileImageUrl,
      };

      // Insert profile row using auth user id
      await profileRemoteDataSource.createProfile(nurseData);

      // Persist session if Firebase has a current user
      final currentUser = await remoteDataSource.getCurrentUser();
      if (currentUser != null) {
        await _saveSession();
      }

      final userModel = UserModel.fromJson(nurseData);
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
      Map<String, String?> patientData = {
        'id': authUserId,
        'name': patient.name,
        'email': patient.email,
        'phone_number': patient.phoneNumber,
        'date_of_birth': patient.dateOfBirth.toIso8601String(),
        'gender': patient.gender,
        'role': 'patient',
        'year_of_experience': null,
        'region': null,
        'skill_set': null,
        'profile_image_url': patient.profileImageUrl,
      };

      // Insert profile row using auth user id
      await profileRemoteDataSource.createProfile(patientData);

      // Persist session if Firebase has a current user
      final currentUser = await remoteDataSource.getCurrentUser();
      if (currentUser != null) {
        await _saveSession();
      }

      final userModel = UserModel.fromJson(patientData);
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
      // 1. Sign in
      final authUser = await remoteDataSource.signIn(
        email: email.trim().toLowerCase(),
        password: password,
      );

      // 2. Fetch profile from Firestore
      final profile = await _fetchUserProfile(authUser.id);

      if (profile == null) {
        return Failure(Exception('User profile not found after sign in'));
      }

      // 3. Save session flag
      await _saveSession();

      // 4. Return domain model
      return Success(profile.toDomain());
    } on datasource.AuthException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(Exception('Unexpected error during sign in'));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      // Sign out from authentication backend
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
        return const Success(null);
      }

      final currentUser = await remoteDataSource.getCurrentUser();
      if (currentUser == null) {
        await _clearSession();
        return const Success(null);
      }

      final profile = await _fetchUserProfile(currentUser.id);
      if (profile == null) {
        await _clearSession();
        return const Success(null);
      }

      return Success(profile.toDomain());
    } catch (e) {
      await _clearSession();
      return const Success(null);
    }
  }

  @override
  Future<domain.User?> getCurrentUser() async {
    try {
      final currentUser = await remoteDataSource.getCurrentUser();
      if (currentUser == null) {
        return null;
      }
      final profile = await _fetchUserProfile(currentUser.id);
      return profile?.toDomain();
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

  /// Fetches a user profile document from Firestore by auth user id.
  Future<UserModel?> _fetchUserProfile(String id) async {
    try {
      return await profileRemoteDataSource.getProfileById(id);
    } catch (e) {
      return null;
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
