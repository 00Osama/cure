import '../../../../core/utils/result.dart';
import '../entities/nurse_booking.dart';
import '../repositories/book_nurse_repository.dart';

class BookNurseUseCase {
  const BookNurseUseCase(this._repository);

  final BookNurseRepository _repository;

  Future<Result<void>> call(NurseBooking booking) {
    return _repository.bookNurse(booking);
  }
}
