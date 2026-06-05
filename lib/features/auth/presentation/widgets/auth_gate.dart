import 'package:cure/features/auth/presentation/pages/splash_page.dart';
import 'package:cure/features/auth/presentation/widgets/bottom_nav_bar.dart';
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
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle error state
          return const Center(child: Text('Something went wrong.'));
        } else if (snapshot.hasData) {
          // If the user is authenticated, show the main app controller
          return const BottomNavBar();
        } else {
          // If the user is not authenticated, show the login or register screen
          return const SplashPage();
        }
      },
    );
  }
}
