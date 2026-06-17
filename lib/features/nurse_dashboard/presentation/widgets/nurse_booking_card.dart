import 'package:cure/core/widgets/booking_info_row.dart';
import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/features/nurse_dashboard/domain/entities/nurse_dashboard_booking.dart';
import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NurseBookingCard extends StatelessWidget {
  const NurseBookingCard({super.key, required this.booking});

  final NurseDashboardBooking booking;

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
              S().patientData,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            BookingInfoRow(icon: Icons.person, text: booking.patientName),
            GestureDetector(
              onTap: () async {
                final Uri phoneUri = Uri(
                  scheme: 'tel',
                  path: booking.patientName,
                );

                if (await canLaunchUrl(phoneUri)) {
                  await launchUrl(phoneUri);
                }
              },
              child: BookingInfoRow(
                icon: Icons.phone,
                text: booking.patientPhone,
              ),
            ),
            BookingInfoRow(
              icon: Icons.location_on,
              text: booking.bookingAddress,
            ),
          ],
        ),
      ),
    );
  }
}
