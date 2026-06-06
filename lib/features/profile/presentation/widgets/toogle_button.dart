import 'package:cure/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const ToggleButton({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.black : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
