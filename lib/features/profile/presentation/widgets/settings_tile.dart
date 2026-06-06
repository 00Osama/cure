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
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: textColor ?? Colors.white, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.white38),
    );
  }
}
