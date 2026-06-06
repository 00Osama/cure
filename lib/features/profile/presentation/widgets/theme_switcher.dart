import 'package:cure/features/profile/presentation/widgets/leading_icon.dart';
import 'package:cure/features/profile/presentation/widgets/toogle_button.dart';
import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';

class ThemeSwitcherTile extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onChanged;

  const ThemeSwitcherTile({
    super.key,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const LeadingIcon(icon: Icons.dark_mode_outlined),
      title: Text(
        S().theme,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ToggleButton(
              title: S().light,
              selected: !isDark,
              onTap: () => onChanged(false),
            ),
            ToggleButton(
              title: S().dark,
              selected: isDark,
              onTap: () => onChanged(true),
            ),
          ],
        ),
      ),
    );
  }
}
