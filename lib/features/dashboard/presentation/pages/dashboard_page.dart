import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cure/features/booking/domain/entities/booking.dart';
import 'package:cure/features/booking/presentation/widgets/booking_list_item.dart';
import 'package:cure/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:cure/features/dashboard/presentation/cubits/dashboard_cubit.dart';
import 'package:cure/features/dashboard/presentation/cubits/dashboard_state.dart';
import 'package:cure/features/dashboard/presentation/widgets/summary_card.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/models/app_colors.dart';
import 'package:cure/core/widgets/loading_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
        title: Text(s.dashboardTitle),
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return switch (state) {
            DashboardInitial() ||
            DashboardLoading() => const Center(child: LoadingWidget()),
            DashboardError(:final message) => _ErrorView(message: message),
            DashboardLoaded(:final summary) => _LoadedView(summary: summary),
          };
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final colors = AppColors.of(context);
    return RefreshIndicator(
      onRefresh: () => context.read<DashboardCubit>().load(),
      child: ListView(
        children: [
          const SizedBox(height: 120),
          Center(
            child: Column(
              children: [
                Text(message, style: TextStyle(color: colors.onSurfaceMuted)),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => context.read<DashboardCubit>().load(),
                  child: Text(s.retry),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView({required this.summary});

  final DashboardSummary summary;

  Future<void> _confirmCancel(BuildContext context, Booking booking) async {
    final s = S.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(s.cancelBooking),
        content: Text(s.cancelBookingConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(s.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(s.confirm),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      context.read<DashboardCubit>().cancelBooking(booking);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final colors = AppColors.of(context);
    return RefreshIndicator(
      onRefresh: () => context.read<DashboardCubit>().load(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: SummaryCard(
                  label: s.totalBookings,
                  value: '${summary.total}',
                  color: const Color(0xFF29E2F6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SummaryCard(
                  label: s.activeLabel,
                  value: '${summary.active.length}',
                  color: const Color(0xFFFFB020),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SummaryCard(
                  label: s.completedLabel,
                  value: '${summary.completedCount}',
                  color: const Color(0xFF27AE60),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (summary.total == 0)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Text(
                  s.noBookings,
                  style: TextStyle(color: colors.onSurfaceMuted),
                ),
              ),
            ),
          if (summary.active.isNotEmpty) ...[
            _SectionTitle(text: s.activeRequests),
            ...summary.active.map(
              (b) => BookingListItem(
                booking: b,
                onTap: () => _confirmCancel(context, b),
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (summary.history.isNotEmpty) ...[
            _SectionTitle(text: s.bookingHistory),
            ...summary.history.map((b) => BookingListItem(booking: b)),
          ],
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: colors.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
