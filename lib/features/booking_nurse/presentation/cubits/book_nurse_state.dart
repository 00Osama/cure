enum BookNurseStatus { initial, loading, success, error }

class BookNurseState {
  const BookNurseState({
    this.status = BookNurseStatus.initial,
    this.errorMessage,
  });

  final BookNurseStatus status;
  final String? errorMessage;

  BookNurseState copyWith({
    BookNurseStatus? status,
    String? errorMessage,
  }) {
    return BookNurseState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
