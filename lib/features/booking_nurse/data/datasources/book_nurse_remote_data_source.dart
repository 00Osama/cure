import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BookNurseRemoteDataSource {
  Future<void> bookNurse(Map<String, dynamic> bookingDetails);
}

class BookNurseRemoteDataSourceImpl implements BookNurseRemoteDataSource {
  const BookNurseRemoteDataSourceImpl({
    required this._firestore,
    required this._firebaseAuth,
  });

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> bookNurse(Map<String, dynamic> bookingDetails) async {
    final patientEmail = _firebaseAuth.currentUser?.email;
    final nurseEmail = bookingDetails['nurse_email'] as String?;

    if (patientEmail == null) {
      throw Exception('Patient is not signed in.');
    }

    if (nurseEmail == null || nurseEmail.isEmpty) {
      throw Exception('Nurse email is missing.');
    }

    final bookingDoc = _firestore.collection('bookings').doc();
    final bookingData = {
      ...bookingDetails,
      'id': bookingDoc.id,
      'status': 'active',
      'created_at': FieldValue.serverTimestamp(),
    };

    final patientBookingDoc = _firestore
        .collection('patients')
        .doc(patientEmail)
        .collection('activeBookings')
        .doc(bookingDoc.id);

    final nurseBookingDoc = _firestore
        .collection('nurses')
        .doc(nurseEmail)
        .collection('activeBookings')
        .doc(bookingDoc.id);

    final batch = _firestore.batch();
    batch.set(bookingDoc, bookingData);
    batch.set(patientBookingDoc, bookingData);
    batch.set(nurseBookingDoc, bookingData);

    await batch.commit();
  }
}
