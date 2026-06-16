import 'package:cure/features/nurse_dashboard/presentation/widgets/nurse_booking_card.dart';
import 'package:cure/features/nurse_dashboard/domain/entities/nurse_dashboard_booking.dart';
import 'package:cure/features/nurse_dashboard/presentation/cubits/nurse_dashboard_cubit.dart';
import 'package:cure/features/patient_dashboard/domain/entities/patient_dashboard_booking.dart';
import 'package:cure/features/patient_dashboard/presentation/cubits/patient_dashboard_cubit.dart';
import 'package:cure/core/widgets/message_view.dart';
import 'package:cure/features/patient_dashboard/presentation/widgets/patient_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingList extends StatelessWidget {
  const BookingList({
    super.key,
    required this.patientbookings,
    required this.nursebookings,
    required this.emptyMessage,
    this.closingBookingId,
    required this.role,
    this.onClose,
  });

  final List<PatientDashboardBooking> patientbookings;
  final List<NurseDashboardBooking> nursebookings;
  final String emptyMessage;
  final String role;
  final String? closingBookingId;
  final ValueChanged<PatientDashboardBooking>? onClose;

  @override
  Widget build(BuildContext context) {
    final isNurse = role == 'nurse';
    final itemCount = isNurse ? nursebookings.length : patientbookings.length;

    if (itemCount == 0) {
      return MessageView(message: emptyMessage);
    }

    return RefreshIndicator(
      onRefresh: () => isNurse
          ? context.read<NurseDashboardCubit>().load()
          : context.read<PatientDashboardCubit>().load(),
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          if (isNurse) {
            return NurseBookingCard(booking: nursebookings[index]);
          }

          final booking = patientbookings[index];
          return PatientBookingCard(
            role: role,
            booking: booking,
            isClosing: closingBookingId == booking.id,
            onClose: onClose == null ? null : () => onClose!(booking),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemCount: itemCount,
      ),
    );
  }
}
