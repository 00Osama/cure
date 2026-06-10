import 'package:flutter/material.dart';

import 'package:cure/features/booking/domain/entities/service.dart';
import 'package:cure/features/booking/presentation/booking_l10n.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/models/app_colors.dart';
import 'package:cure/core/widgets/directional_chevron.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service, required this.onTap});

  final Service service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppColors.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceTitle(context, service.key),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${S.of(context).price}: ${service.basePrice.toStringAsFixed(0)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const DirectionalChevron(),
            ],
          ),
        ),
      ),
    );
  }
}
