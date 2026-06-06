import 'package:cure/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Colors.white54,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}
