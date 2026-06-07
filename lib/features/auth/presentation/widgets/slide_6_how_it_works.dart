import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';

class Slide6HowItWorks extends StatefulWidget {
  const Slide6HowItWorks({super.key});

  @override
  State<Slide6HowItWorks> createState() => _Slide6HowItWorksState();
}

class _Slide6HowItWorksState extends State<Slide6HowItWorks>
    with SingleTickerProviderStateMixin {
  late AnimationController _itemController;

  @override
  void initState() {
    super.initState();
    _itemController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
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
              colors: [Color(0xFF0758D1), Color(0xFF001833)],
            ),
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 50, 24, 120),
          child: Column(
            children: [
              // Title
              Text(
                s.howItWorks,
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
                s.threeSteps,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 32),
              // Step boxes with staggered animation
              _buildAnimatedStepBox(
                theme,
                0,
                '1',
                s.step1Title,
                s.step1Desc,
                '🛍️',
              ),
              const SizedBox(height: 14),
              _buildAnimatedStepBox(
                theme,
                1,
                '2',
                s.step2Title,
                s.step2Desc,
                '📍',
              ),
              const SizedBox(height: 14),
              _buildAnimatedStepBox(
                theme,
                2,
                '3',
                s.step3Title,
                s.step3Desc,
                '👨‍⚕️',
              ),
              const SizedBox(height: 14),
              _buildAnimatedStepBox(
                theme,
                3,
                '4',
                s.step4Title,
                s.step4Desc,
                '⭐',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedStepBox(
    ThemeData theme,
    int index,
    String step,
    String title,
    String desc,
    String icon,
  ) {
    final begin = (index * 0.1);
    final end = (index * 0.1) + 0.25;

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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Step circle
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Color(0xff6b5ce7),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        step,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Icon and title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(icon, style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                title,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Description
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 58),
                child: Text(
                  desc,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                    height: 1.5,
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
