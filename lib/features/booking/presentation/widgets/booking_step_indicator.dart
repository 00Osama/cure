import 'package:flutter/material.dart';

import 'package:cure/features/booking/presentation/cubits/booking_state.dart';
import 'package:cure/core/theme_and_locals/app_colors.dart';

/// Compact progress dots for the four input steps of the booking wizard.
class BookingStepIndicator extends StatelessWidget {
  const BookingStepIndicator({super.key, required this.current});

  final BookingStep current;

  static const List<BookingStep> _steps = [
    BookingStep.selectService,
    BookingStep.schedule,
    BookingStep.details,
    BookingStep.review,
  ];

  @override
  Widget build(BuildContext context) {
    final idx = _steps.indexOf(current).clamp(0, _steps.length - 1);
    final primary = Theme.of(context).colorScheme.primary;
    final colors = AppColors.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_steps.length, (i) {
        final active = i <= idx;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: i == idx ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? primary : colors.border,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}
