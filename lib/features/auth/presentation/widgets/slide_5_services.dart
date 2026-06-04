import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';

class Slide5Services extends StatefulWidget {
  const Slide5Services({super.key});

  @override
  State<Slide5Services> createState() => _Slide5ServicesState();
}

class _Slide5ServicesState extends State<Slide5Services>
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 120),
            child: Column(
              children: [
                // Title
                Text(
                  s.splashSlide5Title,
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
                  s.splashSlide5Subtitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                // Intro
                Text(
                  s.servicesIntro,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white60,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                // Service categories
                _buildServiceCategory(
                  theme,
                  s.basicCareTitle,
                  s.basicCareItems,
                ),
                const SizedBox(height: 12),
                _buildServiceCategory(
                  theme,
                  s.woundCareTitle,
                  s.woundCareItems,
                ),
                const SizedBox(height: 12),
                _buildServiceCategory(
                  theme,
                  s.elderlyCareTitle,
                  s.elderlyCareItems,
                ),
                const SizedBox(height: 12),
                _buildServiceCategory(
                  theme,
                  s.chronicCareTitle,
                  s.chronicCareItems,
                ),
                const SizedBox(height: 12),
                _buildServiceCategory(
                  theme,
                  s.postOpCareTitle,
                  s.postOpCareItems,
                ),
                const SizedBox(height: 12),
                _buildServiceCategory(
                  theme,
                  s.respiratoryCareTitle,
                  s.respiratoryCareItems,
                ),
                const SizedBox(height: 12),
                _buildServiceCategory(
                  theme,
                  s.catheterCareTitle,
                  s.catheterCareItems,
                ),
                const SizedBox(height: 12),
                _buildServiceCategory(
                  theme,
                  s.psychologicalCareTitle,
                  s.psychologicalCareItems,
                ),
                const SizedBox(height: 12),
                _buildServiceCategory(
                  theme,
                  s.emergencyCareTitle,
                  s.emergencyCareItems,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCategory(
    ThemeData theme,
    String categoryTitle,
    String items,
  ) {
    final itemList = items
        .split('\n')
        .where((item) => item.trim().isNotEmpty)
        .toList();

    return SizedBox(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryTitle,
              style: theme.textTheme.labelMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            ...itemList.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == itemList.length - 1;

              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 6),
                child: Text(
                  item.trim(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
