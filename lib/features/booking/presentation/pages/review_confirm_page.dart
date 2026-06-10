import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:cure/features/auth/presentation/widgets/button.dart';
import 'package:cure/features/booking/presentation/booking_l10n.dart';
import 'package:cure/features/booking/presentation/cubits/booking_cubit.dart';
import 'package:cure/features/booking/presentation/cubits/booking_state.dart';
import 'package:cure/features/booking/presentation/pages/booking_success_page.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/models/app_colors.dart';
import 'package:cure/core/widgets/gradient_scaffold.dart';
import 'package:cure/core/widgets/loading_widget.dart';

/// Step 4: review the assembled booking and confirm. Navigation to the success
/// screen happens in a [BlocConsumer] listener once the booking is created.
class ReviewConfirmPage extends StatelessWidget {
  const ReviewConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final colors = AppColors.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(s.reviewBooking),
      ),
      body: BlocConsumer<BookingCubit, BookingState>(
        listenWhen: (p, c) => p.step != c.step || p.error != c.error,
        listener: (context, state) {
          if (state.step == BookingStep.success && state.confirmed != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BookingSuccessPage()),
            );
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${s.bookingFailed}: ${state.error!}'),
                backgroundColor: colors.danger,
              ),
            );
          }
        },
        builder: (context, state) {
          final service = state.selectedService;
          final scheduledAt = state.scheduledAt;
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _Row(
                    label: s.selectService,
                    value: service == null
                        ? '—'
                        : serviceTitle(context, service.key),
                  ),
                  _Row(
                    label: s.chooseDateTime,
                    value: scheduledAt == null
                        ? '—'
                        : DateFormat.yMMMMEEEEd(
                            locale,
                          ).add_jm().format(scheduledAt),
                  ),
                  _Row(label: s.addressLabel, value: state.address ?? '—'),
                  if ((state.remarks ?? '').isNotEmpty)
                    _Row(label: s.clinicalRemarks, value: state.remarks!),
                  _Row(
                    label: s.price,
                    value: service == null
                        ? '—'
                        : service.basePrice.toStringAsFixed(0),
                  ),
                  const SizedBox(height: 28),
                  AppPrimaryButton(
                    title: s.confirmBooking,
                    onPressed: () =>
                        context.read<BookingCubit>().confirmBooking(),
                  ),
                ],
              ),
              if (state.isLoading)
                const ColoredBox(
                  color: Colors.black54,
                  child: Center(child: LoadingWidget()),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: colors.onSurfaceMuted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(height: 20, color: colors.border),
        ],
      ),
    );
  }
}
