/// Lifecycle of a booking.
///
/// The legal transitions below form a **deterministic state machine**. All
/// status changes must go through [transition], which rejects illegal moves —
/// this is the single enforcement point (called by the use case before any
/// network write, and unit-tested directly).
enum BookingStatus { requested, confirmed, inProgress, completed, cancelled }

/// Thrown when an illegal status transition is attempted.
class InvalidTransitionException implements Exception {
  const InvalidTransitionException(this.from, this.to);

  final BookingStatus from;
  final BookingStatus to;

  @override
  String toString() =>
      'InvalidTransitionException: cannot move from ${from.name} to ${to.name}';
}

const Map<BookingStatus, Set<BookingStatus>> _allowedTransitions = {
  BookingStatus.requested: {BookingStatus.confirmed, BookingStatus.cancelled},
  BookingStatus.confirmed: {BookingStatus.inProgress, BookingStatus.cancelled},
  BookingStatus.inProgress: {BookingStatus.completed, BookingStatus.cancelled},
  BookingStatus.completed: {}, // terminal
  BookingStatus.cancelled: {}, // terminal
};

/// Whether [to] is a legal next state from [from].
bool canTransition(BookingStatus from, BookingStatus to) =>
    _allowedTransitions[from]?.contains(to) ?? false;

/// Returns [to] if the move is legal, otherwise throws
/// [InvalidTransitionException].
BookingStatus transition(BookingStatus from, BookingStatus to) {
  if (!canTransition(from, to)) {
    throw InvalidTransitionException(from, to);
  }
  return to;
}

bool isTerminal(BookingStatus s) =>
    s == BookingStatus.completed || s == BookingStatus.cancelled;

/// Active = currently in the pipeline (requested/confirmed/inProgress).
bool isActive(BookingStatus s) => !isTerminal(s);

/// Serialization to/from the Supabase `booking_status` enum text
/// (intentionally identical to `BookingStatus.name`).
String statusToApi(BookingStatus s) => s.name;

BookingStatus statusFromApi(String value) => BookingStatus.values.firstWhere(
  (e) => e.name == value,
  orElse: () => BookingStatus.requested,
);
