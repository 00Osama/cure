import 'package:cure/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsSwitchTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.accent,
      title: const Text(
        "Notifications",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      secondary: const CircleAvatar(
        backgroundColor: Colors.white10,
        child: Icon(Icons.notifications_none, color: Colors.white),
      ),
    );
  }
}
