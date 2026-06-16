import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:flutter/material.dart';

class BookingInfoRow extends StatelessWidget {
  const BookingInfoRow({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: colors.onSurfaceMuted),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: colors.onSurfaceMuted, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
