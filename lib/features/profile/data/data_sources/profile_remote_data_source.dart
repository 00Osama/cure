import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<void> createProfile(Map<String, dynamic> data);

  Future<void> updateProfileFields(String role, Map<String, dynamic> fields);

  Future<void> updateFcmToken(String role, String token);

  Future<void> deleteProfile(String role);

  Future<void> deleteAuthAccount();

  Future<void> logout();

  Future<ProfileModel?> getProfileById(String id);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl({
    required this._firestore,
    required this._firebaseAuth,
  });

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> createProfile(Map<String, dynamic> data) async {
    await _firestore
        .collection(data['role'] == 'nurse' ? 'nurses' : 'patients')
        .doc(_requireCurrentEmail())
        .set(data);
  }

  @override
  Future<void> updateProfileFields(
    String role,
    Map<String, dynamic> fields,
  ) async {
    await _firestore
        .collection(role == 'nurse' ? 'nurses' : 'patients')
        .doc(_requireCurrentEmail())
        .update(fields);
  }

  @override
  Future<void> updateFcmToken(String role, String token) async {
    await updateProfileFields(role, {'fcm_token': token});
  }

  @override
  Future<void> deleteProfile(String role) async {
    await _firestore
        .collection(role == 'nurse' ? 'nurses' : 'patients')
        .doc(_requireCurrentEmail())
        .delete();
  }

  @override
  Future<void> deleteAuthAccount() async {
    await _firebaseAuth.currentUser?.delete();
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<ProfileModel?> getProfileById(String id) async {
    final document = await _findProfileDocument(id);
    if (document == null) return null;
    return ProfileModel.fromJson(document.data());
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> _findProfileDocument(
    String id,
  ) async {
    for (final collectionName in _profileCollections) {
      final query = await _firestore
          .collection(collectionName)
          .where('id', isEqualTo: id)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) return query.docs.first;
    }

    return null;
  }

  String _requireCurrentEmail() {
    final email = _firebaseAuth.currentUser?.email;
    if (email == null || email.isEmpty) {
      throw StateError('Missing current user email.');
    }
    return email;
  }
}

const _profileCollections = ['nurses', 'patients'];
