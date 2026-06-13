import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/utils/failures.dart' as f;
import '../../../../core/utils/result.dart';
import '../../domain/entities/nurses_page_result.dart';
import '../../domain/repositories/nurse_repository.dart';
import '../datasources/nurse_remote_datasource.dart';

class NurseRepositoryImpl implements NurseRepository {
  const NurseRepositoryImpl(this._remoteDataSource);

  final NurseRemoteDataSource _remoteDataSource;

  @override
  Future<Result<NursesPageResult>> getAvailableNurses({
    required int limit,
    DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  }) async {
    try {
      final page = await _remoteDataSource.getAvailableNurses(
        limit: limit,
        startAfterDocument: startAfterDocument,
      );

      return Success(
        NursesPageResult(
          nurses: page.nurses.map((nurse) => nurse.toEntity()).toList(),
          lastDocument: page.lastDocument,
          hasMore: page.hasMore,
        ),
      );
    } catch (e) {
      return Failure(f.ServerFailure(e.toString()));
    }
  }
}
