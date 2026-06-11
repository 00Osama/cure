import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/features/auth/presentation/pages/onbording_page.dart';
import 'package:cure/features/auth/presentation/widgets/bottom_nav_bar.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the authentication state
          return Scaffold(
            backgroundColor: AppColors.of(context).gradientEnd,
            body: Center(child: LoadingWidget()),
          );
        } else if (snapshot.hasError) {
          // Handle error state
          return Scaffold(
            backgroundColor: AppColors.of(context).gradientEnd,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/assets/images/error.png', height: 140),
                  SizedBox(height: 20),
                  Text(
                    S.of(context).somethingWentWrong,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.of(context).onSurface,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasData) {
          // If the user is authenticated, show the main app controller
          return const BottomNavBar();
        } else {
          // If the user is not authenticated, show the login or register screen
          return const OnBordingPage();
        }
      },
    );
  }
}
