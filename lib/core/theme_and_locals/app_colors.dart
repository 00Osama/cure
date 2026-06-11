import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.gradientStart,
    required this.gradientEnd,
    required this.surface,
    required this.surfaceHigh,
    required this.surfacePressed,
    required this.onSurface,
    required this.onSurfaceMuted,
    required this.onSurfaceSubtle,
    required this.border,
    required this.iconBackground,
    required this.navBackground,
    required this.navIcon,
    required this.navActive,
    required this.navBorder,
    required this.accent,
    required this.success,
    required this.warning,
    required this.danger,
    required this.cureLogoColor,
  });

  final Color gradientStart;
  final Color gradientEnd;
  final Color surface;
  final Color surfaceHigh;
  final Color surfacePressed;
  final Color onSurface;
  final Color onSurfaceMuted;
  final Color onSurfaceSubtle;
  final Color border;
  final Color iconBackground;
  final Color navBackground;
  final Color navIcon;
  final Color navActive;
  final Color navBorder;
  final Color accent;
  final Color success;
  final Color warning;
  final Color danger;
  final Color cureLogoColor;

  static const light = AppColors(
    cureLogoColor: Color.fromARGB(193, 11, 52, 66),
    gradientStart: Color(0xFFF8FAFC),
    gradientEnd: Color(0xFFEAF1F5),
    surface: Color(0xFFFFFFFF),
    surfaceHigh: Color(0xFFF3F7FA),
    surfacePressed: Color(0xFFE3ECF1),
    onSurface: Color(0xFF102A35),
    onSurfaceMuted: Color(0xFF4C6370),
    onSurfaceSubtle: Color(0xFF72838B),
    border: Color(0xFFD7E2E8),
    iconBackground: Color(0xFFE5EEF3),
    navBackground: Color(0xFFFFFFFF),
    navIcon: Color(0xFF81919A),
    navActive: Color(0xFF0B3442),
    navBorder: Color(0xFF0B3442),
    accent: Color(0xFF0D8EA0),
    success: Color(0xFF239B56),
    warning: Color(0xFFE39812),
    danger: Color(0xFFE54848),
  );

  static const dark = AppColors(
    cureLogoColor: Colors.white,
    gradientStart: Color(0xFF1D1940),
    gradientEnd: Color(0xFF181A2D),
    surface: Color(0xFF202136),
    surfaceHigh: Color(0xFF0A2B38),
    surfacePressed: Color(0xFF3E5560),
    onSurface: Color(0xFFF7FAFC),
    onSurfaceMuted: Color(0xFFC7D0D7),
    onSurfaceSubtle: Color(0xFF95A5AF),
    border: Color(0xFF344955),
    iconBackground: Color(0xFF244553),
    navBackground: Color(0xFF073340),
    navIcon: Color(0xFF9DAAB3),
    navActive: Color(0xFFF6FBFF),
    navBorder: Color(0xFFE7EEF2),
    accent: Color(0xFF29E2F6),
    success: Color(0xFF27AE60),
    warning: Color(0xFFFFB020),
    danger: Color(0xFFFF5A5F),
  );

  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark ? dark : light);
  }

  @override
  AppColors copyWith({
    Color? gradientStart,
    Color? gradientEnd,
    Color? surface,
    Color? surfaceHigh,
    Color? surfacePressed,
    Color? onSurface,
    Color? onSurfaceMuted,
    Color? onSurfaceSubtle,
    Color? border,
    Color? iconBackground,
    Color? navBackground,
    Color? navIcon,
    Color? navActive,
    Color? navBorder,
    Color? accent,
    Color? success,
    Color? warning,
    Color? danger,
    Color? cureLogoColor,
  }) {
    return AppColors(
      cureLogoColor: cureLogoColor ?? this.cureLogoColor,
      gradientStart: gradientStart ?? this.gradientStart,
      gradientEnd: gradientEnd ?? this.gradientEnd,
      surface: surface ?? this.surface,
      surfaceHigh: surfaceHigh ?? this.surfaceHigh,
      surfacePressed: surfacePressed ?? this.surfacePressed,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceMuted: onSurfaceMuted ?? this.onSurfaceMuted,
      onSurfaceSubtle: onSurfaceSubtle ?? this.onSurfaceSubtle,
      border: border ?? this.border,
      iconBackground: iconBackground ?? this.iconBackground,
      navBackground: navBackground ?? this.navBackground,
      navIcon: navIcon ?? this.navIcon,
      navActive: navActive ?? this.navActive,
      navBorder: navBorder ?? this.navBorder,
      accent: accent ?? this.accent,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      cureLogoColor: Color.lerp(cureLogoColor, other.cureLogoColor, t)!,
      gradientStart: Color.lerp(gradientStart, other.gradientStart, t)!,
      gradientEnd: Color.lerp(gradientEnd, other.gradientEnd, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceHigh: Color.lerp(surfaceHigh, other.surfaceHigh, t)!,
      surfacePressed: Color.lerp(surfacePressed, other.surfacePressed, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      onSurfaceMuted: Color.lerp(onSurfaceMuted, other.onSurfaceMuted, t)!,
      onSurfaceSubtle: Color.lerp(onSurfaceSubtle, other.onSurfaceSubtle, t)!,
      border: Color.lerp(border, other.border, t)!,
      iconBackground: Color.lerp(iconBackground, other.iconBackground, t)!,
      navBackground: Color.lerp(navBackground, other.navBackground, t)!,
      navIcon: Color.lerp(navIcon, other.navIcon, t)!,
      navActive: Color.lerp(navActive, other.navActive, t)!,
      navBorder: Color.lerp(navBorder, other.navBorder, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
    );
  }
}
