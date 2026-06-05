import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';

class Slide1Welcome extends StatefulWidget {
  final AnimationController pulseController;

  const Slide1Welcome({super.key, required this.pulseController});

  @override
  State<Slide1Welcome> createState() => _Slide1WelcomeState();
}

class _Slide1WelcomeState extends State<Slide1Welcome>
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
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
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
        FadeTransition(
          opacity: _fadeController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated Logo
              ScaleTransition(
                scale: widget.pulseController,
                child: Image.asset(
                  'lib/assets/images/crop_cure_logo.png',
                  height: 140,
                ),
              ),
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Text(
                      S.of(context).splashSlide1Line1,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.of(context).splashSlide1Line2,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Color(0xFF7ED957),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.of(context).splashSlide1Line3,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
