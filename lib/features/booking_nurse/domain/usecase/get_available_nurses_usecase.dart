import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/utils/result.dart';
import '../entities/nurses_page_result.dart';
import '../repositories/nurse_repository.dart';

class GetAvailableNursesUseCase {
  const GetAvailableNursesUseCase(this._repository);

  final NurseRepository _repository;

  Future<Result<NursesPageResult>> call({
    required int limit,
    DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  }) {
    return _repository.getAvailableNurses(
      limit: limit,
      startAfterDocument: startAfterDocument,
    );
  }
}
