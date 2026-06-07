import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_status.dart';

part 'booking_model.g.dart';

double _asDouble(dynamic v) =>
    v is num ? v.toDouble() : double.tryParse('$v') ?? 0;

/// Extracts `key` from a PostgREST embedded `services(key)` object, e.g.
/// `{"services": {"key": "basicCare"}}`.
String? _serviceKeyFromEmbed(dynamic v) =>
    v is Map ? v['key'] as String? : null;

/// Data model for a `bookings` row. `status` is kept as raw text here and
/// mapped to the [BookingStatus] enum in [toEntity].
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class BookingModel {
  const BookingModel({
    required this.id,
    required this.patientId,
    this.nurseId,
    required this.serviceId,
    this.serviceKey,
    required this.scheduledAt,
    required this.status,
    this.remarks,
    required this.address,
    required this.price,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String patientId;
  final String? nurseId;
  final String serviceId;

  /// Populated when the query embeds `services(key)`; null otherwise.
  @JsonKey(name: 'services', fromJson: _serviceKeyFromEmbed)
  final String? serviceKey;

  final DateTime scheduledAt;
  final String status;
  final String? remarks;
  final String address;
  @JsonKey(fromJson: _asDouble)
  final double price;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Booking toEntity() => Booking(
    id: id,
    patientId: patientId,
    nurseId: nurseId,
    serviceId: serviceId,
    serviceKey: serviceKey,
    scheduledAt: scheduledAt.toLocal(),
    status: statusFromApi(status),
    remarks: remarks,
    address: address,
    price: price,
    createdAt: createdAt?.toLocal(),
    updatedAt: updatedAt?.toLocal(),
  );

  /// Request body for a POST insert — omits server-managed columns
  /// (`id`, `created_at`, `updated_at`) so DB defaults apply.
  static Map<String, dynamic> toInsertJson({
    required String patientId,
    String? nurseId,
    required String serviceId,
    required DateTime scheduledAt,
    required String address,
    String? remarks,
    required double price,
    BookingStatus status = BookingStatus.requested,
  }) {
    final trimmedRemarks = remarks?.trim();
    return {
      'patient_id': patientId,
      'nurse_id': ?nurseId,
      'service_id': serviceId,
      'scheduled_at': scheduledAt.toUtc().toIso8601String(),
      'status': statusToApi(status),
      if (trimmedRemarks != null && trimmedRemarks.isNotEmpty)
        'remarks': trimmedRemarks,
      'address': address,
      'price': price,
    };
  }
}
