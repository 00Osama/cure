import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/available_nurse_model.dart';

class NursePageData {
  const NursePageData({
    required this.nurses,
    required this.lastDocument,
    required this.hasMore,
  });

  final List<AvailableNurseModel> nurses;
  final DocumentSnapshot<Map<String, dynamic>>? lastDocument;
  final bool hasMore;
}

abstract class NurseRemoteDataSource {
  Future<NursePageData> getAvailableNurses({
    required int limit,
    DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  });
}

class NurseRemoteDataSourceImpl implements NurseRemoteDataSource {
  const NurseRemoteDataSourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<NursePageData> getAvailableNurses({
    required int limit,
    DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  }) async {
    return _getPage(
      query: _nursesQuery(limit: limit),
      limit: limit,
      startAfterDocument: startAfterDocument,
    );
  }

  Query<Map<String, dynamic>> _nursesQuery({required int limit}) {
    return _firestore
        .collection('nurses')
        .orderBy('name')
        .limit(limit);
  }

  Future<NursePageData> _getPage({
    required Query<Map<String, dynamic>> query,
    required int limit,
    DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  }) async {
    final pageQuery = startAfterDocument == null
        ? query
        : query.startAfterDocument(startAfterDocument);

    final snapshot = await pageQuery.get();
    final models = snapshot.docs
        .map((doc) {
          final data = doc.data();
          data['id'] = data['id'] ?? doc.id;
          return AvailableNurseModel.fromJson(data);
        })
        .toList();

    return NursePageData(
      nurses: models,
      lastDocument: snapshot.docs.isEmpty ? null : snapshot.docs.last,
      hasMore: snapshot.docs.length == limit,
    );
  }
}
