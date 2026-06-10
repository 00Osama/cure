import 'package:cure/generated/l10n.dart';
import 'package:cure/core/models/app_colors.dart';
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
    final colors = AppColors.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: colors.iconBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.notifications_none_rounded,
          color: colors.onSurface,
          size: 20,
        ),
      ),
      title: Text(
        S.of(context).notifications,
        style: TextStyle(color: colors.onSurface, fontWeight: FontWeight.w600),
      ),
      trailing: Transform.scale(
        scale: 0.9,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.white,
          activeTrackColor: colors.success,
          inactiveThumbColor: colors.onSurfaceSubtle,
          inactiveTrackColor: colors.border,
        ),
      ),
    );
  }
}
