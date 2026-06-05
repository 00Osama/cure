import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';

class Slide4Solution extends StatefulWidget {
  const Slide4Solution({super.key});

  @override
  State<Slide4Solution> createState() => _Slide4SolutionState();
}

class _Slide4SolutionState extends State<Slide4Solution>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.center,
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
        FadeTransition(
          opacity: _fadeController,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Solution icon with gradient
                SizedBox(
                  width: 100,
                  height: 100,

                  child: const Center(
                    child: Text('🌱', style: TextStyle(fontSize: 52)),
                  ),
                ),
                const SizedBox(height: 32),
                // Title
                Text(
                  s.splashSlide4Title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 24),
                // Subtitle
                Text(
                  s.splashSlide4Subtitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                    height: 1.8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40),
                // Benefits
                Column(
                  children: [
                    _buildBenefitItem(theme, '⚡', '15 دقيقة أو أقل'),
                    const SizedBox(height: 16),
                    _buildBenefitItem(theme, '🔒', 'ممرضون معتمدون مختارون'),
                    const SizedBox(height: 16),
                    _buildBenefitItem(theme, '💯', 'أسعار شفافة وعادلة'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitItem(ThemeData theme, String icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
