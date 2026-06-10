import 'dart:io';

import 'package:cure/core/network/api_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data_sources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl({
    required this._remoteDataSource,
    required this._firebaseAuth,
  });

  final ProfileRemoteDataSource _remoteDataSource;
  final FirebaseAuth _firebaseAuth;

  String? get _currentUid => _firebaseAuth.currentUser?.uid;

  @override
  Future<Profile?> getProfile() async {
    final uid = _requireCurrentUid();
    final model = await _remoteDataSource.getProfileById(uid);
    return model?.toEntity();
  }

  @override
  Future<void> updateProfile({
    required String name,
    required String phoneNumber,
    required DateTime dateOfBirth,
    required String gender,
    String? yearOfExperience,
    String? region,
    String? skillSet,
    String? profileImagePath,
  }) async {
    final uid = _requireCurrentUid();
    final profile = await getProfile();
    if (profile == null) {
      throw StateError('Profile is not loaded.');
    }

    final fields = <String, dynamic>{
      'name': name.trim(),
      'phone_number': phoneNumber.trim(),
      'date_of_birth': dateOfBirth.toIso8601String(),
      'gender': gender,
    };

    if (profile.isNurse) {
      fields.addAll({
        'year_of_experience': yearOfExperience,
        'region': region,
        'skill_set': skillSet?.trim(),
      });
    }

    if (profileImagePath != null) {
      fields['profile_image_url'] = profileImagePath;
    }

    await _remoteDataSource.updateProfileFields(uid, fields);
  }

  @override
  Future<String?> uploadProfileImage(String imagePath) async {
    final uid = _requireCurrentUid();
    final profile = await getProfile();
    if (profile == null) {
      throw StateError('Profile is not loaded.');
    }

    final localPath = await _copyProfileImageLocally(
      uid: uid,
      sourcePath: imagePath,
    );
    final remoteUrl = await _uploadProfileImage(
      localPath: localPath,
      uid: uid,
      role: profile.role,
    );
    return remoteUrl ?? localPath;
  }

  @override
  Future<void> updateFcmToken(String token) async {
    final uid = _currentUid;
    if (uid == null) return;
    await _remoteDataSource.updateFcmToken(uid, token);
  }

  @override
  Future<void> deleteAccount() async {
    final uid = _requireCurrentUid();
    await _remoteDataSource.deleteProfile(uid);
    await _remoteDataSource.deleteAuthAccount();
  }

  @override
  Future<void> logout() {
    return _remoteDataSource.logout();
  }

  String _requireCurrentUid() {
    final uid = _currentUid;
    if (uid == null) {
      throw StateError('Missing current user.');
    }
    return uid;
  }

  Future<String> _copyProfileImageLocally({
    required String uid,
    required String sourcePath,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    final extension = sourcePath.split('.').last;
    final target = File(
      '${directory.path}${Platform.pathSeparator}profile_$uid.$extension',
    );
    return File(sourcePath).copy(target.path).then((file) => file.path);
  }

  Future<String?> _uploadProfileImage({
    required String localPath,
    required String uid,
    required String role,
  }) async {
    if (!ApiConfig.hasAnonKey) return null;

    final bucket = role == 'nurse'
        ? 'nurses_profile_images'
        : 'patients_profile_images';
    final extension = localPath.split('.').last;
    final storagePath =
        '${uid}_${DateTime.now().millisecondsSinceEpoch}.$extension';

    await Supabase.instance.client.storage
        .from(bucket)
        .upload(storagePath, File(localPath));

    return Supabase.instance.client.storage
        .from(bucket)
        .getPublicUrl(storagePath);
  }
}
