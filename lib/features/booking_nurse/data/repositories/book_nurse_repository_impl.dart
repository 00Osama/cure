import '../../../../core/utils/result.dart';
import '../../domain/entities/nurse_booking.dart';
import '../../domain/repositories/book_nurse_repository.dart';
import '../datasources/book_nurse_remote_data_source.dart';

class BookNurseRepositoryImpl implements BookNurseRepository {
  const BookNurseRepositoryImpl(this._remoteDataSource);

  final BookNurseRemoteDataSource _remoteDataSource;

  @override
  Future<Result<void>> bookNurse(NurseBooking booking) async {
    try {
      await _remoteDataSource.bookNurse(_toJson(booking));
      return const Success(null);
    } catch (error) {
      return Failure(Exception(error.toString()));
    }
  }

  Map<String, dynamic> _toJson(NurseBooking booking) {
    final nurse = booking.nurse;
    final patient = booking.patient;

    return {
      // booking data
      'service_name': booking.serviceName,
      'booking_address': booking.bookingAddress,
      'booking_dateTime': booking.bookingDateTime,
      // patient data
      'patient_id': patient.id,
      'patient_email': patient.email,
      'patient_clinicalNotes': booking.bookingClinicalNotes,
      'patient_age': patient.age,
      'patient_name': patient.name,
      'patient_phone': patient.phoneNumber,
      'patient_gender': patient.gender,
      'patient_profile_image_url': patient.profileImageUrl,
      // nurse data
      'nurse_id': nurse.id,
      'nurse_name': nurse.name,
      'nurse_email': nurse.email,
      'nurse_phone_number': nurse.phoneNumber,
      'nurse_date_of_birth': nurse.dateOfBirth,
      'nurse_gender': nurse.gender,
      'nurse_profile_image_url': nurse.profileImageUrl,
      'nurse_year_of_experience': nurse.yearOfExperience,
      'nurse_region': nurse.region,
      'nurse_skill_set': nurse.skillSet,
    };
  }
}
