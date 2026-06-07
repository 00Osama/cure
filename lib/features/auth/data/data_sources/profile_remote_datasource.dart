import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<void> createProfile(Map<String, dynamic> data);

  Future<UserModel?> getProfileById(String id);

  /// Persists the device FCM token on the user's profile document.
  Future<void> updateFcmToken(String id, String token);

  /// Updates arbitrary fields on the user's profile document.
  Future<void> updateProfileFields(String id, Map<String, dynamic> fields);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  ProfileRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> createProfile(Map<String, dynamic> data) async {
    await firestore.collection('users').add(data);
  }

  @override
  Future<UserModel?> getProfileById(String id) async {
    final query = await firestore
        .collection('users')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;

    final data = query.docs.first.data();
    return UserModel.fromJson(data);
  }

  @override
  Future<void> updateFcmToken(String id, String token) async {
    final query = await firestore
        .collection('users')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();
    if (query.docs.isEmpty) return;
    await query.docs.first.reference.update({'fcm_token': token});
  }

  @override
  Future<void> updateProfileFields(
    String id,
    Map<String, dynamic> fields,
  ) async {
    final query = await firestore
        .collection('users')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();
    if (query.docs.isEmpty) return;
    await query.docs.first.reference.update(fields);
  }
}
