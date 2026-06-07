import 'package:flutter/material.dart';

import 'package:cure/features/booking/domain/entities/booking_status.dart';
import 'package:cure/generated/l10n.dart';

/// Resolves a `services.key` to its localized title. The copy lives in the ARB
/// files; the database only stores the key + price, so no text is duplicated.
String serviceTitle(BuildContext context, String key) {
  final s = S.of(context);
  switch (key) {
    case 'basicCare':
      return s.basicCareTitle;
    case 'woundCare':
      return s.woundCareTitle;
    case 'elderlyCare':
      return s.elderlyCareTitle;
    case 'chronicCare':
      return s.chronicCareTitle;
    case 'postOpCare':
      return s.postOpCareTitle;
    case 'respiratoryCare':
      return s.respiratoryCareTitle;
    case 'catheterCare':
      return s.catheterCareTitle;
    case 'psychologicalCare':
      return s.psychologicalCareTitle;
    case 'emergencyCare':
      return s.emergencyCareTitle;
    default:
      return key;
  }
}

/// Resolves a `services.key` to its localized multi-line item list.
String serviceItems(BuildContext context, String key) {
  final s = S.of(context);
  switch (key) {
    case 'basicCare':
      return s.basicCareItems;
    case 'woundCare':
      return s.woundCareItems;
    case 'elderlyCare':
      return s.elderlyCareItems;
    case 'chronicCare':
      return s.chronicCareItems;
    case 'postOpCare':
      return s.postOpCareItems;
    case 'respiratoryCare':
      return s.respiratoryCareItems;
    case 'catheterCare':
      return s.catheterCareItems;
    case 'psychologicalCare':
      return s.psychologicalCareItems;
    case 'emergencyCare':
      return s.emergencyCareItems;
    default:
      return '';
  }
}

/// Localized label for a booking status.
String statusLabel(BuildContext context, BookingStatus status) {
  final s = S.of(context);
  switch (status) {
    case BookingStatus.requested:
      return s.statusRequested;
    case BookingStatus.confirmed:
      return s.statusConfirmed;
    case BookingStatus.inProgress:
      return s.statusInProgress;
    case BookingStatus.completed:
      return s.statusCompleted;
    case BookingStatus.cancelled:
      return s.statusCancelled;
  }
}

/// Accent color for a booking status (used by chips).
Color statusColor(BookingStatus status) {
  switch (status) {
    case BookingStatus.requested:
      return const Color(0xFFFFB020);
    case BookingStatus.confirmed:
      return const Color(0xFF2D9CDB);
    case BookingStatus.inProgress:
      return const Color(0xFF29E2F6);
    case BookingStatus.completed:
      return const Color(0xFF27AE60);
    case BookingStatus.cancelled:
      return const Color(0xFFFF4D4D);
  }
}
