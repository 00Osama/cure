import 'package:bloc_test/bloc_test.dart';
import 'package:cure/features/booking/domain/entities/service.dart';
import 'package:cure/features/booking/domain/usecase/booking_usecase.dart';
import 'package:cure/features/booking/presentation/cubits/booking_cubit.dart';
import 'package:cure/features/booking/presentation/cubits/booking_state.dart';
import 'package:cure/core/utils/failures.dart' as f;
import 'package:cure/core/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockUseCase extends Mock implements BookingUseCase {}

void main() {
  late _MockUseCase useCase;
  const service = Service(id: '1', key: 'basicCare', basePrice: 50);

  setUp(() => useCase = _MockUseCase());

  blocTest<BookingCubit, BookingState>(
    'loadServices emits loading then the loaded services',
    build: () {
      when(
        () => useCase.getServices(),
      ).thenAnswer((_) async => const Success([service]));
      return BookingCubit(useCase: useCase, patientId: 'p');
    },
    act: (cubit) => cubit.loadServices(),
    expect: () => [
      isA<BookingState>().having((s) => s.isLoading, 'isLoading', true),
      isA<BookingState>()
          .having((s) => s.isLoading, 'isLoading', false)
          .having((s) => s.services.length, 'services', 1),
    ],
  );

  blocTest<BookingCubit, BookingState>(
    'loadServices surfaces an error message on failure',
    build: () {
      when(
        () => useCase.getServices(),
      ).thenAnswer((_) async => Failure(const f.NetworkFailure('offline')));
      return BookingCubit(useCase: useCase, patientId: 'p');
    },
    act: (cubit) => cubit.loadServices(),
    expect: () => [
      isA<BookingState>().having((s) => s.isLoading, 'isLoading', true),
      isA<BookingState>()
          .having((s) => s.isLoading, 'isLoading', false)
          .having((s) => s.error, 'error', isNotNull),
    ],
  );

  blocTest<BookingCubit, BookingState>(
    'selectService advances the wizard to the schedule step',
    build: () => BookingCubit(useCase: useCase, patientId: 'p'),
    act: (cubit) => cubit.selectService(service),
    expect: () => [
      isA<BookingState>()
          .having((s) => s.step, 'step', BookingStep.schedule)
          .having((s) => s.selectedService, 'selectedService', service),
    ],
  );
}
