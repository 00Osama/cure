// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailabilitySlotModel _$AvailabilitySlotModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'AvailabilitySlotModel',
  json,
  ($checkedConvert) {
    final val = AvailabilitySlotModel(
      id: $checkedConvert('id', (v) => v as String),
      nurseId: $checkedConvert('nurse_id', (v) => v as String),
      region: $checkedConvert('region', (v) => v as String),
      startsAt: $checkedConvert(
        'starts_at',
        (v) => DateTime.parse(v as String),
      ),
      endsAt: $checkedConvert('ends_at', (v) => DateTime.parse(v as String)),
      isBooked: $checkedConvert('is_booked', (v) => v as bool? ?? false),
    );
    return val;
  },
  fieldKeyMap: const {
    'nurseId': 'nurse_id',
    'startsAt': 'starts_at',
    'endsAt': 'ends_at',
    'isBooked': 'is_booked',
  },
);
