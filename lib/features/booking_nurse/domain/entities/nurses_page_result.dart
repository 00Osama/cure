import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure/features/auth/domain/entities/nurse.dart';

class NursesPageResult {
  const NursesPageResult({
    required this.nurses,
    required this.lastDocument,
    required this.hasMore,
  });

  final List<Nurse> nurses;
  final DocumentSnapshot<Map<String, dynamic>>? lastDocument;
  final bool hasMore;
}
