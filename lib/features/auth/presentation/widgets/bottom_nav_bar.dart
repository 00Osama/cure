import 'package:cure/features/auth/domain/entities/nurse.dart';
import 'package:cure/features/booking/presentation/pages/nurse_incoming_page.dart';
import 'package:cure/features/booking/presentation/pages/service_selection_page.dart';
import 'package:cure/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:cure/features/profile/presentation/pages/profile.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/shared/di/injection.dart';
import 'package:cure/shared/models/app_colors.dart';
import 'package:cure/shared/widgets/gradient_scaffold.dart';
import 'package:cure/shared/widgets/loading_widget.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

/// App shell. Patients get [Book] + [Dashboard] tabs; nurses get a light
/// read-only incoming-requests view. Screens are built once and kept alive in
/// an [IndexedStack] so cubit state survives tab switches.
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
      // Light, read-only nurse experience (patient-centric scope).
      return [
        NurseIncomingPage(useCase: di.bookingUseCase),
        NurseIncomingPage(useCase: di.bookingUseCase),
        const ProfilePage(),
      ];
    }
    return [
      BlocProvider(
        create: (_) => di.createBookingCubit()..loadServices(),
        child: const ServiceSelectionPage(),
      ),
      BlocProvider(
        create: (_) => di.createDashboardCubit()..load(),
        child: const DashboardPage(),
      ),
      const ProfilePage(),
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

    final homeLabel = _isNurse ? s.incomingRequests : s.home;

    return GradientScaffold(
      body: _roleLoaded
          ? IndexedStack(index: _selectedIndex, children: _screens)
          : const Center(child: LoadingWidget()),
      bottomNavigationBar: GNav(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        backgroundColor: colors.navBackground,
        color: colors.navIcon,
        activeColor: colors.navActive,
        tabActiveBorder: Border.all(color: colors.navBorder),
        tabBorderRadius: tabBorderRadius,
        padding: EdgeInsets.all(navPadding),
        tabs: [
          GButton(
            icon: Icons.home_rounded,
            iconSize: iconSize,
            text: ' $homeLabel',
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
    );
  }
}
