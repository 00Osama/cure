import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/nurse_dashboard_booking_model.dart';

abstract class NurseDashboardRemoteDataSource {
  Future<List<NurseDashboardBookingModel>> getActiveBookings();
  Future<List<NurseDashboardBookingModel>> getCompletedBookings();
}

class NurseDashboardRemoteDataSourceImpl
    implements NurseDashboardRemoteDataSource {
  const NurseDashboardRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
  }) : _firestore = firestore,
       _firebaseAuth = firebaseAuth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<NurseDashboardBookingModel>> getActiveBookings() {
    return _getBookings('activeBookings');
  }

  @override
  Future<List<NurseDashboardBookingModel>> getCompletedBookings() {
    return _getBookings('completedBookings');
  }

  Future<List<NurseDashboardBookingModel>> _getBookings(
    String collectionName,
  ) async {
    final snapshot = await _firestore
        .collection('nurses')
        .doc(_currentNurseEmail())
        .collection(collectionName)
        .orderBy('booking_dateTime', descending: true)
        .get();

    return snapshot.docs.map(NurseDashboardBookingModel.fromDocument).toList();
  }

  String _currentNurseEmail() {
    final email = _firebaseAuth.currentUser?.email;
    if (email == null || email.isEmpty) {
      throw Exception('Nurse is not signed in.');
    }
    return email;
  }
}
