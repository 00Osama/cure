import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';

class Slide3Problems extends StatefulWidget {
  const Slide3Problems({super.key});

  @override
  State<Slide3Problems> createState() => _Slide3ProblemsState();
}

class _Slide3ProblemsState extends State<Slide3Problems>
    with SingleTickerProviderStateMixin {
  late AnimationController _itemController;

  @override
  void initState() {
    super.initState();
    _itemController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF001833), Color(0xFF0758D1)],
            ),
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 50, 24, 120),
          child: Column(
            children: [
              // Title
              Text(
                s.splashSlide3Title,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                s.splashSlide3Subtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              // Problem boxes with staggered animation
              _buildAnimatedProblemBox(
                theme,
                s,
                0,
                s.waitingHours,
                s.waitingDesc,
                s.waitingPercent,
                '⏳',
              ),
              _buildAnimatedProblemBox(
                theme,
                s,
                1,
                s.priceManipulation,
                s.priceDesc,
                s.unfairPrice,
                '💰',
              ),
              _buildAnimatedProblemBox(
                theme,
                s,
                2,
                s.noVerification,
                s.noVerificationDesc,
                s.unsafeFeel,
                '❓',
              ),
              _buildAnimatedProblemBox(
                theme,
                s,
                3,
                s.noSystem,
                s.noSystemDesc,
                s.noApp,
                '📵',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedProblemBox(
    ThemeData theme,
    S s,
    int index,
    String title,
    String desc,
    String stat,
    String icon,
  ) {
    final begin = (index * 0.1);
    final end = (index * 0.1) + 0.3;

    return SlideTransition(
      position: _itemController.drive(
        Tween<Offset>(
          begin: const Offset(0.2, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Interval(begin, end, curve: Curves.easeOut))),
      ),
      child: FadeTransition(
        opacity: _itemController.drive(
          Tween<double>(begin: 0, end: 1).chain(
            CurveTween(curve: Interval(begin, end, curve: Curves.easeOut)),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(icon, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                desc,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF26E8F3).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  stat,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: const Color(0xFF26E8F3),
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
