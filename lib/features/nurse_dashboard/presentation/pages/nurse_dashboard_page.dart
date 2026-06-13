import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';

class NurseDashboardPage extends StatelessWidget {
  const NurseDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Scaffold(
      backgroundColor: colors.gradientEnd,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).dashboard,
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
