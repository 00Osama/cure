import 'package:cure/features/auth/domain/entities/nurse.dart';
import 'package:cure/features/auth/domain/entities/user.dart';

class NurseBooking {
  const NurseBooking({
    required this.serviceName,
    required this.bookingAddress,
    required this.bookingClinicalNotes,
    required this.bookingDateTime,
    required this.patient,
    required this.nurse,
  });

  final String serviceName;
  final String bookingAddress;
  final DateTime bookingDateTime;
  final String bookingClinicalNotes;
  final User patient;
  final Nurse nurse;
}
