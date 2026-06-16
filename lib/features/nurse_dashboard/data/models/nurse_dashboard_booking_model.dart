import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/nurse_dashboard_booking.dart';

class NurseDashboardBookingModel {
  const NurseDashboardBookingModel({
    required this.id,
    required this.data,
  });

  final String id;
  final Map<String, dynamic> data;

  factory NurseDashboardBookingModel.fromDocument(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    return NurseDashboardBookingModel(
      id: (data['id'] as String?) ?? document.id,
      data: data,
    );
  }

  NurseDashboardBooking toEntity() {
    return NurseDashboardBooking(
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
