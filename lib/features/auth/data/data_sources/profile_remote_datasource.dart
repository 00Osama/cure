import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<void> createProfile(Map<String, dynamic> data);

  Future<UserModel?> getProfileById(String id);
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
}
