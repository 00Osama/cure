import 'package:cure/features/auth/presentation/widgets/nav_button.dart';
import 'package:flutter/material.dart';

class SplashNavigationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;
  final bool previousEnabled;

  const SplashNavigationBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPreviousPressed,
    required this.onNextPressed,
    this.previousEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 32,
      left: 20,
      right: 20,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavButton(
              icon: Icons.chevron_left_rounded,
              enabled: previousEnabled,
              onPressed: onPreviousPressed,
              isPrimary: false,
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white.withValues(alpha: 0.10),
                border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(totalPages, (index) {
                  final isActive = index == currentPage;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOutCubic,
                      width: isActive ? 30 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isActive
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.30),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: Colors.white.withValues(alpha: 0.35),
                                  blurRadius: 12,
                                  spreadRadius: 1,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  );
                }),
              ),
            ),

            NavButton(
              icon: Icons.chevron_right_rounded,
              enabled: true,
              onPressed: onNextPressed,
              isPrimary: true,
            ),
          ],
        ),
      ),
    );
  }
}
