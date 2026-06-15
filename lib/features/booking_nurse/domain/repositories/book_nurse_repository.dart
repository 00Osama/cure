import '../../../../core/utils/result.dart';
import '../entities/nurse_booking.dart';

abstract class BookNurseRepository {
  Future<Result<void>> bookNurse(NurseBooking booking);
}
