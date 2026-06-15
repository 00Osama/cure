import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<void> createProfile(Map<String, dynamic> data);

  Future<ProfileModel?> getProfileById(String id);

  Future<void> updateFcmToken(String id, String token);

  Future<void> updateProfileFields(String id, Map<String, dynamic> fields);

  Future<void> deleteProfile(String role);

  Future<void> deleteAuthAccount();

  Future<void> logout();
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
        .doc(_firebaseAuth.currentUser!.email)
        .set(data);
  }

  @override
  Future<ProfileModel?> getProfileById(String id) async {
    final document = await _findProfileDocument(id);
    if (document == null) return null;
    return ProfileModel.fromJson(document.data());
  }

  @override
  Future<void> updateFcmToken(String id, String token) async {
    await updateProfileFields(id, {'fcm_token': token});
  }

  @override
  Future<void> updateProfileFields(
    String id,
    Map<String, dynamic> fields,
  ) async {
    final document = await _findProfileDocument(id);
    if (document == null) return;
    await document.reference.update(fields);
  }

  @override
  Future<void> deleteProfile(String role) async {
    await _firestore
        .collection(role == 'nurse' ? 'nurses' : 'patients')
        .doc(_firebaseAuth.currentUser!.email)
        .delete();
  }

  @override
  Future<void> deleteAuthAccount() async {
    _firebaseAuth.currentUser!.delete();
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
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
}

const _profileCollections = ['nurses', 'patients'];
