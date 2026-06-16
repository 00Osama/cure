class PatientDashboardBooking {
  const PatientDashboardBooking({
    required this.id,
    required this.serviceName,
    required this.bookingAddress,
    required this.bookingDateTime,
    required this.patientClinicalNotes,
    required this.patientEmail,
    required this.patientName,
    required this.patientPhone,
    required this.nurseEmail,
    required this.nurseName,
    required this.nursePhoneNumber,
    required this.status,
  });

  final String id;
  final String serviceName;
  final String bookingAddress;
  final DateTime bookingDateTime;
  final String patientClinicalNotes;
  final String patientEmail;
  final String patientName;
  final String patientPhone;
  final String nurseEmail;
  final String nurseName;
  final String nursePhoneNumber;
  final String status;
}
