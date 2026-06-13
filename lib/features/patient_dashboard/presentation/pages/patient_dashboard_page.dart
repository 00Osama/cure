import 'package:flutter/material.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/theme_and_locals/app_colors.dart';

class PatientDashboardPage extends StatelessWidget {
  const PatientDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final colors = AppColors.of(context);
    return Scaffold(
      backgroundColor: colors.gradientEnd,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(s.dashboard),
      ),
      body: SizedBox(),
    );
  }
}
