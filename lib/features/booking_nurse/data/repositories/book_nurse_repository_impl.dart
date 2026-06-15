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

    return {
      'serviceName': booking.serviceName,
      'address': booking.address,
      'clinicalNotes': booking.clinicalNotes,
      'dateTime': booking.dateTime,
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
