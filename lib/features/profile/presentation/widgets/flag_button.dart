import 'package:cure/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class FlagButton extends StatelessWidget {
  final String flag;
  final bool selected;
  final VoidCallback onTap;

  const FlagButton({
    super.key,
    required this.flag,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: 50,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(flag, style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}
