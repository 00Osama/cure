import 'package:cloud_firestore/cloud_firestore.dart';

import 'available_nurse.dart';

class NursesPageResult {
  const NursesPageResult({
    required this.nurses,
    required this.lastDocument,
    required this.hasMore,
  });

  final List<AvailableNurse> nurses;
  final DocumentSnapshot<Map<String, dynamic>>? lastDocument;
  final bool hasMore;
}
