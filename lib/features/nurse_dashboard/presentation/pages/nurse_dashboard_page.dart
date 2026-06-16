import 'package:cure/core/widgets/booking_list.dart';
import 'package:cure/core/widgets/dashboard_tab_item.dart';
import 'package:cure/core/widgets/message_view.dart';
import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/core/widgets/loading_widget.dart';
import 'package:cure/features/nurse_dashboard/presentation/cubits/nurse_dashboard_cubit.dart';
import 'package:cure/features/nurse_dashboard/presentation/cubits/nurse_dashboard_state.dart';
import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NurseDashboardPage extends StatelessWidget {
  const NurseDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: isDark
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0A2B38), Color(0xFF073340)],
                    )
                  : const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0D8EA0), Color(0xFF0B3442)],
                    ),
            ),
            indicatorPadding: const EdgeInsets.symmetric(
              horizontal: 2,
              vertical: 6,
            ),
            splashBorderRadius: BorderRadius.circular(10),
            labelPadding: EdgeInsets.symmetric(horizontal: isTablet ? 8 : 4),
            labelColor: Colors.white,
            unselectedLabelColor: isDark
                ? Colors.white.withValues(alpha: 0.78)
                : colors.onSurface,
            labelStyle: TextStyle(
              fontSize: isTablet ? 16 : 13,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: isTablet ? 15 : 12,
              fontWeight: FontWeight.w600,
            ),
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return const Color(0xFF0D8EA0).withValues(alpha: 0.15);
              }
              return null;
            }),
            dividerColor: Colors.transparent,
            dividerHeight: 0,
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 8 : 6),
            tabs: [
              DashboardTabItem(title: S().active),
              DashboardTabItem(title: S().completed),
            ],
          ),
        ),
        body: BlocBuilder<NurseDashboardCubit, NurseDashboardState>(
          builder: (context, state) {
            if (state.status == NurseDashboardStatus.loading) {
              return const Center(child: LoadingWidget());
            }

            if (state.status == NurseDashboardStatus.error) {
              return MessageView(
                message: state.errorMessage ?? S().couldNotLoadBookings,
                actionText: S().tryAgain,
                onPressed: () => context.read<NurseDashboardCubit>().load(),
              );
            }

            return TabBarView(
              children: [
                BookingList(
                  role: 'nurse',
                  patientbookings: [],
                  nursebookings: state.activeBookings,
                  emptyMessage: S().noActiveBookings,
                ),
                BookingList(
                  role: 'nurse',
                  patientbookings: [],
                  nursebookings: state.completedBookings,
                  emptyMessage: S().noActiveBookings,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
