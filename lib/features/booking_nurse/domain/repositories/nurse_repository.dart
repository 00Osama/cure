import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/utils/result.dart';
import '../entities/nurses_page_result.dart';

abstract class NurseRepository {
  Future<Result<NursesPageResult>> getAvailableNurses({
    required int limit,
    DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  });
}
