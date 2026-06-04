import 'package:flutter/material.dart';

/// Gradient definitions for light and dark modes
class AppGradients {
  /// Dark mode gradient: #1d1940 to #181a2d from top-right to bottom-left
  static const Gradient darkGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFF1d1940), Color(0xFF181a2d)],
  );

  /// Light mode gradient: matched colors from top-right to bottom-left
  /// Using lighter versions: #E8E6F0 to #E0DBF0
  static const Gradient lightGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFFE8E6F0), Color(0xFFE0DBF0)],
  );

  /// Get the appropriate gradient based on brightness
  static Gradient getGradient(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? darkGradient : lightGradient;
  }

  /// Get the appropriate gradient based on brightness (without context)
  static Gradient getGradientByBrightness(Brightness brightness) {
    return brightness == Brightness.dark ? darkGradient : lightGradient;
  }
}

/// Extension on BuildContext to easily get current gradient
extension GradientExtension on BuildContext {
  Gradient get appGradient => AppGradients.getGradient(this);
}
