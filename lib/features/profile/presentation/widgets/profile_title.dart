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
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.white10,
        child: Icon(icon, color: textColor ?? Colors.white, size: 18),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
    );
  }
}
