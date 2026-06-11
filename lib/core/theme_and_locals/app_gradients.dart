import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:flutter/material.dart';

/// Gradient definitions for light and dark modes
class AppGradients {
  static Gradient fromColors(AppColors colors) {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [colors.gradientStart, colors.gradientEnd],
    );
  }

  /// Dark mode gradient: kept close to the existing visual direction.
  static final Gradient darkGradient = fromColors(AppColors.dark);

  /// Light mode gradient: clean, low-contrast background with readable surfaces.
  static final Gradient lightGradient = fromColors(AppColors.light);

  static const Gradient darkGradientFallback = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFF1d1940), Color(0xFF181a2d)],
  );

  static const Gradient lightGradientFallback = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFFF8FAFC), Color(0xFFEAF1F5)],
  );

  /// Get the appropriate gradient based on brightness
  static Gradient getGradient(BuildContext context) {
    return fromColors(AppColors.of(context));
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
