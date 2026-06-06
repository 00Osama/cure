import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const NotificationTile({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.notifications_none_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
      title: Text(
        S().notifications,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      trailing: Transform.scale(
        scale: 0.9,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.white,
          activeTrackColor: Colors.green,
          inactiveThumbColor: Colors.white70,
          inactiveTrackColor: Colors.white24,
        ),
      ),
    );
  }
}
