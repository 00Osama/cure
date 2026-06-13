import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/available_nurse.dart';

enum NursesStatus { initial, loading, loaded, loadingMore, error }

class NursesState {
  const NursesState({
    this.status = NursesStatus.initial,
    this.nurses = const [],
    this.lastDocument,
    this.hasMore = true,
    this.errorMessage,
  });

  final NursesStatus status;
  final List<AvailableNurse> nurses;
  final DocumentSnapshot<Map<String, dynamic>>? lastDocument;
  final bool hasMore;
  final String? errorMessage;

  bool get isFirstLoad => status == NursesStatus.initial;

  NursesState copyWith({
    NursesStatus? status,
    List<AvailableNurse>? nurses,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    bool? hasMore,
    String? errorMessage,
  }) {
    return NursesState(
      status: status ?? this.status,
      nurses: nurses ?? this.nurses,
      lastDocument: lastDocument ?? this.lastDocument,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
    );
  }
}
