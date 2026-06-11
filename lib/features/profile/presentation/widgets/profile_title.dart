import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/core/widgets/directional_chevron.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final effectiveColor = textColor ?? colors.onSurface;
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: colors.iconBackground,
        child: Icon(icon, color: effectiveColor, size: 18),
      ),
      title: Text(
        title,
        style: TextStyle(color: effectiveColor, fontWeight: FontWeight.w600),
      ),
      trailing: const DirectionalChevron(),
    );
  }
}
