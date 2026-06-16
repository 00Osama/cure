import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/patient_dashboard_booking.dart';

class PatientBookingModel {
  const PatientBookingModel({required this.id, required this.data});

  final String id;
  final Map<String, dynamic> data;

  factory PatientBookingModel.fromDocument(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    return PatientBookingModel(
      id: (data['id'] as String?) ?? document.id,
      data: data,
    );
  }

  PatientDashboardBooking toEntity() {
    return PatientDashboardBooking(
      id: id,
      serviceName: _string('service_name'),
      bookingAddress: _string('booking_address'),
      bookingDateTime: _dateTime('booking_dateTime'),
      patientClinicalNotes: _string('patient_clinicalNotes'),
      patientEmail: _string('patient_email'),
      patientName: _string('patient_name'),
      patientPhone: _string('patient_phone'),
      nurseEmail: _string('nurse_email'),
      nurseName: _string('nurse_name'),
      nursePhoneNumber: _string('nurse_phone_number'),
      status: _string('status', fallback: 'active'),
    );
  }

  String _string(String key, {String fallback = ''}) {
    final value = data[key];
    return value is String ? value : fallback;
  }

  DateTime _dateTime(String key) {
    final value = data[key];
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return DateTime.now();
  }
}
