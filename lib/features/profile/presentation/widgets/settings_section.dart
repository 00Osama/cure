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
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            color: colors.onSurfaceSubtle,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: colors.surfaceHigh,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.border),
          ),
          // ListTiles paint their background and ink splashes on the nearest
          // Material ancestor. Without this, the colored Container above would
          // hide those effects (and Flutter logs a warning). A transparent
          // Material lets the Container's color show through while giving the
          // tiles a surface to ink on; clipBehavior keeps splashes rounded.
          child: Material(
            type: MaterialType.transparency,
            child: Column(children: children),
          ),
        ),
      ],
    );
  }
}
