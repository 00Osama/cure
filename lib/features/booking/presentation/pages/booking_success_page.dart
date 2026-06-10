import 'package:flutter/material.dart';

import 'package:cure/features/auth/presentation/widgets/button.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/widgets/gradient_scaffold.dart';

/// Terminal step: confirmation. "Done" returns to the app shell (root route).
class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return GradientScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF27AE60),
                size: 96,
              ),
              const SizedBox(height: 24),
              Text(
                s.bookingConfirmed,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                s.bookingConfirmedSubtitle,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: AppPrimaryButton(
                  title: s.done,
                  onPressed: () =>
                      Navigator.of(context).popUntil((r) => r.isFirst),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
