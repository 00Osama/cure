import 'package:cure/features/booking/domain/entities/service.dart';
import 'package:cure/features/booking/domain/usecase/booking_usecase.dart';
import 'package:cure/features/booking/presentation/cubits/booking_cubit.dart';
import 'package:cure/features/booking/presentation/pages/service_selection_page.dart';
import 'package:cure/features/booking/presentation/widgets/service_card.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockUseCase extends Mock implements BookingUseCase {}

void main() {
  testWidgets('renders one ServiceCard per loaded service', (tester) async {
    final useCase = _MockUseCase();
    when(() => useCase.getServices()).thenAnswer(
      (_) async => const Success([
        Service(id: '1', key: 'basicCare', basePrice: 50),
        Service(id: '2', key: 'woundCare', basePrice: 80),
      ]),
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: BlocProvider(
          create: (_) =>
              BookingCubit(useCase: useCase, patientId: 'p')..loadServices(),
          child: const ServiceSelectionPage(),
        ),
      ),
    );

    // Let the async loadServices complete and rebuild.
    await tester.pump();
    await tester.pump();

    expect(find.byType(ServiceCard), findsNWidgets(2));
  });
}
