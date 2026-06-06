import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    const Color scaffoldColor = Color(0xFF032531);
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: scaffoldColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: scaffoldColor,
        surfaceTintColor: scaffoldColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: scaffoldColor,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    final Color scaffoldColor = Color(0xFF051923);
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF1C1C1E),
      scaffoldBackgroundColor: scaffoldColor,
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldColor,
        surfaceTintColor: scaffoldColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: scaffoldColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
    );
  }
}
