import 'package:cure/features/auth/domain/entities/nurse.dart';
import 'package:cure/features/booking_nurse/presentation/pages/nurses_page.dart';
import 'package:cure/features/nurse_dashboard/presentation/pages/nurse_dashboard_page.dart';
import 'package:cure/features/patient_dashboard/presentation/pages/patient_dashboard_page.dart';
import 'package:cure/features/profile/presentation/pages/profile.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/di/injection.dart';
import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/core/widgets/loading_widget.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  bool _roleLoaded = false;
  bool _isNurse = false;
  List<Widget> _screens = const [];

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final user = await di.authUseCase.getCurrentUser();
    if (!mounted) return;
    setState(() {
      _isNurse = user is Nurse;
      _screens = _buildScreens();
      _roleLoaded = true;
    });
    // Best-effort: store the device FCM token for the signed-in user.
    unawaited(di.registerFcmToken());
  }

  List<Widget> _buildScreens() {
    if (_isNurse) {
      return [
        const NursesPage(role: 'nurse'),
        const NurseDashboardPage(),
        const ProfilePage(role: 'nurse'),
      ];
    }
    return [
      const NursesPage(role: 'patient'),
      BlocProvider(
        create: (_) => di.createDashboardCubit()..load(),
        child: const PatientDashboardPage(),
      ),
      const ProfilePage(role: 'patient'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final colors = AppColors.of(context);
    final navPadding = screenWidth < 600 ? 15.0 : 30.0;
    final tabBorderRadius = screenWidth < 600 ? 20.0 : 35.0;
    final textFontSize = screenWidth < 600 ? 14.0 : 37.0;
    final iconSize = screenWidth < 600 ? 24.0 : 33.0;

    return Scaffold(
      body: _roleLoaded
          ? ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              child: _screens[_selectedIndex],
            )
          : ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              child: ColoredBox(
                color: colors.gradientEnd,
                child: const Center(child: LoadingWidget()),
              ),
            ),
      backgroundColor: colors.navBackground,
      bottomNavigationBar: Container(
        color: colors.navBackground,
        child: SafeArea(
          top: false,
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            backgroundColor: colors.navBackground,
            color: colors.navIcon,
            activeColor: colors.navActive,
            tabBackgroundColor: colors.navBorder.withValues(alpha: 0.18),
            tabActiveBorder: Border.all(color: colors.navBorder),
            tabBorderRadius: tabBorderRadius,
            padding: EdgeInsets.all(navPadding),
            tabs: [
              GButton(
                icon: Icons.medication_rounded,
                iconSize: iconSize,
                text: ' ${s.nurses}',
                textStyle: TextStyle(fontSize: textFontSize),
                margin: EdgeInsets.symmetric(vertical: navPadding / 2),
              ),
              GButton(
                icon: Icons.dashboard_rounded,
                iconSize: iconSize,
                text: ' ${s.dashboard}',
                textStyle: TextStyle(fontSize: textFontSize),
                margin: EdgeInsets.symmetric(vertical: navPadding / 2),
              ),
              GButton(
                icon: Icons.person_rounded,
                iconSize: iconSize,
                text: ' ${s.profile}',
                textStyle: TextStyle(fontSize: textFontSize),
                margin: EdgeInsets.symmetric(vertical: navPadding / 2),
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
