import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/core/widgets/loading_widget.dart';
import 'package:cure/features/patient_dashboard/presentation/cubits/patient_dashboard_cubit.dart';
import 'package:cure/features/patient_dashboard/presentation/cubits/patient_dashboard_state.dart';
import 'package:cure/core/widgets/booking_list.dart';
import 'package:cure/core/widgets/dashboard_tab_item.dart';
import 'package:cure/core/widgets/message_view.dart';
import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientDashboardPage extends StatelessWidget {
  const PatientDashboardPage({super.key});

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
                      colors: [
                        Color.fromARGB(255, 17, 67, 87),
                        Color.fromARGB(255, 12, 72, 90),
                      ],
                    )
                  : const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(200, 18, 160, 179),
                        Color.fromARGB(200, 41, 109, 131),
                      ],
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
                return const Color(0xFF6E66F6).withValues(alpha: 0.15);
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
        body: BlocBuilder<PatientDashboardCubit, PatientDashboardState>(
          builder: (context, state) {
            if (state.status == PatientDashboardStatus.loading) {
              return const Center(child: LoadingWidget());
            }

            if (state.status == PatientDashboardStatus.error) {
              return MessageView(
                message: state.errorMessage ?? S().couldNotLoadBookings,
                actionText: S().tryAgain,
                onPressed: () => context.read<PatientDashboardCubit>().load(),
              );
            }

            return TabBarView(
              children: [
                BookingList(
                  role: 'patient',
                  patientbookings: state.activeBookings,
                  nursebookings: [],
                  emptyMessage: S().noActiveBookings,
                  closingBookingId: state.closingBookingId,
                  onClose: (booking) => context
                      .read<PatientDashboardCubit>()
                      .closeBooking(booking.id),
                ),
                BookingList(
                  role: 'patient',
                  patientbookings: state.completedBookings,
                  nursebookings: [],
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
