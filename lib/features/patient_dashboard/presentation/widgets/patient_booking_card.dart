import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/core/widgets/loading_widget.dart';
import 'package:cure/core/widgets/app_primary_button.dart';
import 'package:cure/features/patient_dashboard/domain/entities/patient_dashboard_booking.dart';
import 'package:cure/core/widgets/booking_info_row.dart';
import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';

class PatientBookingCard extends StatelessWidget {
  const PatientBookingCard({
    super.key,
    required this.booking,
    required this.isClosing,
    required this.role,
    this.onClose,
  });

  final PatientDashboardBooking booking;
  final bool isClosing;
  final String role;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Card(
      color: colors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S().bookingData,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            BookingInfoRow(
              icon: Icons.medical_services_outlined,
              text: booking.serviceName,
            ),
            BookingInfoRow(
              icon: Icons.notes,
              text: booking.patientClinicalNotes,
            ),
            BookingInfoRow(
              icon: Icons.event,
              text:
                  '${booking.bookingDateTime.day}/${booking.bookingDateTime.month}/${booking.bookingDateTime.year}',
            ),

            const SizedBox(height: 10),
            Text(
              S().NurseData,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            BookingInfoRow(icon: Icons.person, text: booking.nurseName),
            BookingInfoRow(icon: Icons.phone, text: booking.nursePhoneNumber),
            BookingInfoRow(
              icon: Icons.location_on,
              text: booking.bookingAddress,
            ),
            role == 'patient' && onClose != null
                ? Column(
                    children: [
                      const SizedBox(height: 12),
                      isClosing
                          ? LoadingWidget()
                          : SizedBox(
                              width: double.infinity,
                              child: AppPrimaryButton(
                                title: S().closeBooking,
                                onPressed: onClose!,
                              ),
                            ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
