import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cure/features/booking/domain/entities/service.dart';
import 'package:cure/features/booking/presentation/cubits/booking_cubit.dart';
import 'package:cure/features/booking/presentation/cubits/booking_state.dart';
import 'package:cure/features/booking/presentation/pages/schedule_page.dart';
import 'package:cure/features/booking/presentation/widgets/service_card.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/core/widgets/loading_widget.dart';

/// Step 1 of the booking wizard: choose a clinical service. The
/// [BookingCubit] is provided by the caller (the Home tab) so the same
/// instance is shared across all wizard steps.
class ServiceSelectionPage extends StatelessWidget {
  const ServiceSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final colors = AppColors.of(context);
    return Scaffold(
      backgroundColor: colors.gradientEnd,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(s.bookService),
      ),
      body: BlocConsumer<BookingCubit, BookingState>(
        listenWhen: (p, c) => p.error != c.error,
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.services.isEmpty) {
            return const Center(child: LoadingWidget());
          }
          if (state.services.isEmpty) {
            return _Empty(
              message: state.error ?? s.noBookings,
              onRetry: () => context.read<BookingCubit>().loadServices(),
              retryLabel: s.retry,
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                s.selectService,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...state.services.map(
                (service) => ServiceCard(
                  service: service,
                  onTap: () => _goToSchedule(context, service),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _goToSchedule(BuildContext context, Service service) {
    final cubit = context.read<BookingCubit>();
    cubit.selectService(service);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider.value(value: cubit, child: const SchedulePage()),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({
    required this.message,
    required this.onRetry,
    required this.retryLabel,
  });

  final String message;
  final VoidCallback onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: TextStyle(color: colors.onSurfaceMuted)),
          const SizedBox(height: 12),
          OutlinedButton(onPressed: onRetry, child: Text(retryLabel)),
        ],
      ),
    );
  }
}
