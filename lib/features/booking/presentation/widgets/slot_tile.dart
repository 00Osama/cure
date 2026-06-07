import 'package:flutter/material.dart';

import 'package:cure/features/booking/domain/entities/availability_slot.dart';
import 'package:cure/shared/models/app_colors.dart';

class SlotTile extends StatelessWidget {
  const SlotTile({
    super.key,
    required this.slot,
    required this.selected,
    required this.onTap,
  });

  final AvailabilitySlot slot;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final start = TimeOfDay.fromDateTime(slot.startsAt).format(context);
    final end = TimeOfDay.fromDateTime(slot.endsAt).format(context);
    final primary = theme.colorScheme.primary;
    final colors = AppColors.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? primary.withValues(alpha: 0.18) : colors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? primary : colors.border,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.schedule,
              size: 18,
              color: selected ? primary : colors.onSurfaceMuted,
            ),
            const SizedBox(width: 10),
            Text(
              '$start – $end',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurface,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (selected) Icon(Icons.check_circle, color: primary, size: 20),
          ],
        ),
      ),
    );
  }
}
