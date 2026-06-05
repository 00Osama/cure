import 'package:cure/generated/l10n.dart';
import 'package:cure/shared/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> screens = [
    const ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Center(child: Text('Home Screen')),
    ),
    const ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Center(child: Text('Dashboard Screen')),
    ),
    const ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Center(child: Text('Profile Screen')),
    ),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Colors fixed for both mobile and tablet
    Color backgroundColor = isDark
        ? Colors.grey.shade900
        : Colors.grey.shade400;
    Color iconColor = isDark ? Colors.grey[400]! : Colors.grey[500]!;
    Color activeColor = isDark ? Colors.grey[100]! : Colors.grey[800]!;
    Color tabBorderColor = isDark ? Colors.grey : Colors.white;

    // Responsive sizes
    double navPadding = screenWidth < 600 ? 15 : 30; // bigger on tablet
    double tabBorderRadius = screenWidth < 600 ? 20 : 35; // bigger on tablet
    double textFontSize = screenWidth < 600 ? 14 : 37; // bigger on tablet
    double iconSize = screenWidth < 600 ? 24 : 33; // bigger on tablet

    return GradientScaffold(
      backgroundColor: Color(0xFF1d1940),
      body: screens[_selectedIndex],
      bottomNavigationBar: GNav(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        backgroundColor: Color(0xFF1d1940),
        color: iconColor,
        activeColor: activeColor,
        tabActiveBorder: Border.all(color: tabBorderColor),
        tabBorderRadius: tabBorderRadius,
        padding: EdgeInsets.all(navPadding),
        tabs: [
          GButton(
            icon: Icons.home_rounded,
            iconSize: iconSize,
            text: ' ${S.of(context).home}',
            textStyle: TextStyle(fontSize: textFontSize),
            margin: EdgeInsets.symmetric(vertical: navPadding / 2),
          ),
          GButton(
            icon: Icons.dashboard_rounded,
            iconSize: iconSize,
            text: ' ${S.of(context).dashboard}',
            textStyle: TextStyle(fontSize: textFontSize),
            margin: EdgeInsets.symmetric(vertical: navPadding / 2),
          ),
          GButton(
            icon: Icons.person_rounded,
            iconSize: iconSize,
            text: ' ${S.of(context).profile}',
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
