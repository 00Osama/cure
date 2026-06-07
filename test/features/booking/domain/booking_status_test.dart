import 'package:cure/features/booking/domain/entities/booking_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BookingStatus deterministic state machine', () {
    test('legal transitions are allowed', () {
      expect(
        canTransition(BookingStatus.requested, BookingStatus.confirmed),
        isTrue,
      );
      expect(
        canTransition(BookingStatus.requested, BookingStatus.cancelled),
        isTrue,
      );
      expect(
        canTransition(BookingStatus.confirmed, BookingStatus.inProgress),
        isTrue,
      );
      expect(
        canTransition(BookingStatus.confirmed, BookingStatus.cancelled),
        isTrue,
      );
      expect(
        canTransition(BookingStatus.inProgress, BookingStatus.completed),
        isTrue,
      );
      expect(
        canTransition(BookingStatus.inProgress, BookingStatus.cancelled),
        isTrue,
      );
    });

    test('illegal transitions are rejected', () {
      expect(
        canTransition(BookingStatus.requested, BookingStatus.completed),
        isFalse,
      );
      expect(
        canTransition(BookingStatus.requested, BookingStatus.inProgress),
        isFalse,
      );
      expect(
        canTransition(BookingStatus.confirmed, BookingStatus.completed),
        isFalse,
      );
      expect(
        canTransition(BookingStatus.completed, BookingStatus.cancelled),
        isFalse,
      );
      expect(
        canTransition(BookingStatus.cancelled, BookingStatus.requested),
        isFalse,
      );
    });

    test('transition() returns the target for a legal move', () {
      expect(
        transition(BookingStatus.requested, BookingStatus.confirmed),
        BookingStatus.confirmed,
      );
    });

    test(
      'transition() throws InvalidTransitionException on an illegal move',
      () {
        expect(
          () => transition(BookingStatus.completed, BookingStatus.inProgress),
          throwsA(isA<InvalidTransitionException>()),
        );
      },
    );

    test('terminal vs active classification', () {
      expect(isTerminal(BookingStatus.completed), isTrue);
      expect(isTerminal(BookingStatus.cancelled), isTrue);
      expect(isActive(BookingStatus.requested), isTrue);
      expect(isActive(BookingStatus.confirmed), isTrue);
      expect(isActive(BookingStatus.inProgress), isTrue);
    });

    test('api serialization round-trips for every status', () {
      for (final status in BookingStatus.values) {
        expect(statusFromApi(statusToApi(status)), status);
      }
    });
  });
}
