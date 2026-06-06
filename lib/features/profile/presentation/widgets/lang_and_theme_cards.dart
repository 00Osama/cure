import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const ThemeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: selected ? color : Colors.grey.shade400,
              width: selected ? 3 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: .4),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: color.withValues(alpha: .2),
                child: Icon(icon, color: color),
              ),
              const SizedBox(height: 12),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageCard extends StatelessWidget {
  final String title;
  final String icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const LanguageCard({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          constraints: const BoxConstraints(minHeight: 130),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: selected ? color : Colors.grey.shade400,
              width: selected ? 3 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: .4),
                      blurRadius: 18,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: color.withValues(alpha: .15),
                    child: Text(icon),
                  ),
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
