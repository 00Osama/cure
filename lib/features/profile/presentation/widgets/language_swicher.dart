import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';

class LanguageSwitcherTile extends StatelessWidget {
  final bool isArabic;
  final ValueChanged<bool> onChanged;

  const LanguageSwitcherTile({
    super.key,
    required this.isArabic,
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
        child: const Icon(Icons.language, color: Colors.white, size: 20),
      ),
      title: Text(
        S().language,
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
            _LanguageButton(
              flag: "🇺🇸",
              selected: !isArabic,
              onTap: () => onChanged(false),
            ),
            _LanguageButton(
              flag: "🇸🇦",
              selected: isArabic,
              onTap: () => onChanged(true),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String flag;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageButton({
    required this.flag,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 50,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(flag, style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}
