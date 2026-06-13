import 'package:freezed_annotation/freezed_annotation.dart';

import 'booking_status.dart';

part 'booking.freezed.dart';

/// A home-care booking made by a patient for a specific service and slot.
@freezed
abstract class Booking with _$Booking {
  const factory Booking({
    required String id,
    required String patientId,
    String? nurseId,
    required String serviceId,
    String? serviceKey,
    required DateTime scheduledAt,
    required BookingStatus status,
    String? remarks,
    required String address,
    required double price,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Booking;
}
