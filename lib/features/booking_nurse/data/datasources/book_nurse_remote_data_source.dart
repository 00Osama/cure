import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BookNurseRemoteDataSource {
  Future<void> bookNurse(Map<String, dynamic> bookingDetails);
}

class BookNurseRemoteDataSourceImpl implements BookNurseRemoteDataSource {
  const BookNurseRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
  }) : _firestore = firestore,
       _firebaseAuth = firebaseAuth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> bookNurse(Map<String, dynamic> bookingDetails) async {
    final patientEmail = _firebaseAuth.currentUser?.email;

    if (patientEmail == null) {
      throw Exception('Patient is not signed in.');
    }

    await _firestore
        .collection('patients')
        .doc(patientEmail)
        .collection('dashboard')
        .doc('activeBookings')
        .collection('bookings')
        .add(bookingDetails);
  }
}
