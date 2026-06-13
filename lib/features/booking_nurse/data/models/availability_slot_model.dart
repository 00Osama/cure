import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/availability_slot.dart';

part 'availability_slot_model.g.dart';

/// Data model for a `nurse_availability` row.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class AvailabilitySlotModel {
  const AvailabilitySlotModel({
    required this.id,
    required this.nurseId,
    required this.region,
    required this.startsAt,
    required this.endsAt,
    this.isBooked = false,
  });

  final String id;
  final String nurseId;
  final String region;
  final DateTime startsAt;
  final DateTime endsAt;
  final bool isBooked;

  factory AvailabilitySlotModel.fromJson(Map<String, dynamic> json) =>
      _$AvailabilitySlotModelFromJson(json);

  AvailabilitySlot toEntity() => AvailabilitySlot(
    id: id,
    nurseId: nurseId,
    region: region,
    startsAt: startsAt.toLocal(),
    endsAt: endsAt.toLocal(),
    isBooked: isBooked,
  );
}
