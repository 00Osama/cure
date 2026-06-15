import 'available_nurse.dart';

class NurseBooking {
  const NurseBooking({
    required this.serviceName,
    required this.address,
    required this.clinicalNotes,
    required this.dateTime,
    required this.nurse,
  });

  final String serviceName;
  final String address;
  final String clinicalNotes;
  final DateTime dateTime;
  final AvailableNurse nurse;
}
