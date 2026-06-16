import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/patient_booking_model.dart';

abstract class PatientDashboardRemoteDataSource {
  Future<List<PatientBookingModel>> getActiveBookings();
  Future<List<PatientBookingModel>> getCompletedBookings();
  Future<void> closeBooking(String bookingId);
}

class PatientDashboardRemoteDataSourceImpl
    implements PatientDashboardRemoteDataSource {
  const PatientDashboardRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
  }) : _firestore = firestore,
       _firebaseAuth = firebaseAuth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<PatientBookingModel>> getActiveBookings() {
    return _getBookings('activeBookings');
  }

  @override
  Future<List<PatientBookingModel>> getCompletedBookings() {
    return _getBookings('completedBookings');
  }

  @override
  Future<void> closeBooking(String bookingId) async {
    final patientEmail = _currentPatientEmail();
    final patientActiveDoc = _patientBookingDoc(
      patientEmail,
      'activeBookings',
      bookingId,
    );
    final patientSnapshot = await patientActiveDoc.get();

    if (!patientSnapshot.exists || patientSnapshot.data() == null) {
      throw Exception('Booking was not found.');
    }

    final bookingData = {
      ...patientSnapshot.data()!,
      'status': 'completed',
      'completed_at': FieldValue.serverTimestamp(),
    };
    final nurseEmail = bookingData['nurse_email'] as String?;

    if (nurseEmail == null || nurseEmail.isEmpty) {
      throw Exception('Nurse email is missing.');
    }

    final batch = _firestore.batch();
    batch.set(
      _patientBookingDoc(patientEmail, 'completedBookings', bookingId),
      bookingData,
    );
    batch.delete(patientActiveDoc);

    final nurseActiveDoc = _nurseBookingDoc(
      nurseEmail,
      'activeBookings',
      bookingId,
    );
    batch.set(
      _nurseBookingDoc(nurseEmail, 'completedBookings', bookingId),
      bookingData,
    );
    batch.delete(nurseActiveDoc);
    batch.set(_firestore.collection('bookings').doc(bookingId), bookingData);

    await batch.commit();
  }

  Future<List<PatientBookingModel>> _getBookings(String collectionName) async {
    final snapshot = await _firestore
        .collection('patients')
        .doc(_currentPatientEmail())
        .collection(collectionName)
        .orderBy('booking_dateTime', descending: true)
        .get();

    return snapshot.docs.map(PatientBookingModel.fromDocument).toList();
  }

  DocumentReference<Map<String, dynamic>> _patientBookingDoc(
    String patientEmail,
    String collectionName,
    String bookingId,
  ) {
    return _firestore
        .collection('patients')
        .doc(patientEmail)
        .collection(collectionName)
        .doc(bookingId);
  }

  DocumentReference<Map<String, dynamic>> _nurseBookingDoc(
    String nurseEmail,
    String collectionName,
    String bookingId,
  ) {
    return _firestore
        .collection('nurses')
        .doc(nurseEmail)
        .collection(collectionName)
        .doc(bookingId);
  }

  String _currentPatientEmail() {
    final email = _firebaseAuth.currentUser?.email;
    if (email == null || email.isEmpty) {
      throw Exception('Patient is not signed in.');
    }
    return email;
  }
}
