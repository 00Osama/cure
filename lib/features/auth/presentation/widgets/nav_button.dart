import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  const NavButton({
    super.key,
    required this.icon,
    required this.enabled,
    required this.onPressed,
    required this.isPrimary,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF032531);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isPrimary ? Colors.white : Colors.white.withValues(alpha: 0.12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.18),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: enabled ? onPressed : null,
          child: Center(
            child: Icon(
              icon,
              size: isPrimary ? 26 : 24,
              color: enabled
                  ? (isPrimary ? primaryColor : Colors.white)
                  : Colors.grey.shade500,
            ),
          ),
        ),
      ),
    );
  }
}
