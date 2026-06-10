import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<void> createProfile(Map<String, dynamic> data);

  Future<ProfileModel?> getProfileById(String id);

  Future<void> updateFcmToken(String id, String token);

  Future<void> updateProfileFields(String id, Map<String, dynamic> fields);

  Future<void> deleteProfile(String id);

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
    await _firestore.collection('users').add(data);
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
  Future<void> deleteProfile(String id) async {
    final query = await _firestore
        .collection('users')
        .where('id', isEqualTo: id)
        .get();

    for (final document in query.docs) {
      await document.reference.delete();
    }
  }

  @override
  Future<void> deleteAuthAccount() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;
    await user.delete();
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> _findProfileDocument(
    String id,
  ) async {
    final query = await _firestore
        .collection('users')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    return query.docs.first;
  }
}
