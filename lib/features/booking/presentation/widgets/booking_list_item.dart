import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cure/features/booking/domain/entities/booking.dart';
import 'package:cure/features/booking/presentation/booking_l10n.dart';
import 'package:cure/shared/models/app_colors.dart';

/// Reusable summary row for a booking (used by the dashboard and the nurse
/// incoming list). Wrapped in a [Card] so the [ListTile] has a Material
/// surface for ink/background.
class BookingListItem extends StatelessWidget {
  const BookingListItem({
    super.key,
    required this.booking,
    this.onTap,
    this.trailing,
  });

  final Booking booking;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppColors.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final when = DateFormat.yMMMd(locale).add_jm().format(booking.scheduledAt);
    final title = serviceTitle(context, booking.serviceKey ?? '');

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        title: Text(
          title.isEmpty ? '#${booking.id.substring(0, 6)}' : title,
          style: theme.textTheme.titleSmall?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            '$when\n${booking.address}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceMuted,
            ),
          ),
        ),
        isThreeLine: true,
        trailing: trailing ?? _StatusChip(booking: booking),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final color = statusColor(booking.status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusLabel(context, booking.status),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
