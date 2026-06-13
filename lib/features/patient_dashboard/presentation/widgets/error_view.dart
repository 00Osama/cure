import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/features/patient_dashboard/presentation/cubits/dashboard_cubit.dart';
import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final colors = AppColors.of(context);
    return RefreshIndicator(
      onRefresh: () => context.read<DashboardCubit>().load(),
      child: ListView(
        children: [
          const SizedBox(height: 120),
          Center(
            child: Column(
              children: [
                Text(message, style: TextStyle(color: colors.onSurfaceMuted)),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => context.read<DashboardCubit>().load(),
                  child: Text(s.retry),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
