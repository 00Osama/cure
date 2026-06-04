import 'package:cure/features/auth/presentation/widgets/account_type_selection_page.dart';
import 'package:cure/features/auth/presentation/widgets/slide_1_welcome.dart';
import 'package:cure/features/auth/presentation/widgets/slide_2_intro.dart';
import 'package:cure/features/auth/presentation/widgets/slide_3_problems.dart';
import 'package:cure/features/auth/presentation/widgets/slide_4_solution.dart';
import 'package:cure/features/auth/presentation/widgets/slide_5_services.dart';
import 'package:cure/features/auth/presentation/widgets/slide_6_how_it_works.dart';
import 'package:cure/features/auth/presentation/widgets/splash_navigation_bar.dart';
import 'package:cure/shared/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class OnBordingPage extends StatefulWidget {
  const OnBordingPage({super.key});

  @override
  State<OnBordingPage> createState() => _OnBordingPageState();
}

class _OnBordingPageState extends State<OnBordingPage>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _pulseController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..repeat(reverse: true);

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 5) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToAccountSelection();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToAccountSelection() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const AccountTypeSelectionPage()));
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Stack(
        children: [
          // Slides
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Slide1Welcome(pulseController: _pulseController),
              const Slide2Intro(),
              const Slide3Problems(),
              const Slide4Solution(),
              const Slide5Services(),
              const Slide6HowItWorks(),
            ],
          ),
          // Navigation bar
          SplashNavigationBar(
            currentPage: _currentPage,
            totalPages: 6,
            onPreviousPressed: _previousPage,
            onNextPressed: _nextPage,
            previousEnabled: _currentPage > 0,
          ),
        ],
      ),
    );
  }
}
