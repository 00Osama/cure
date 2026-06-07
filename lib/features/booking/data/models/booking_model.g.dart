// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BookingModel',
      json,
      ($checkedConvert) {
        final val = BookingModel(
          id: $checkedConvert('id', (v) => v as String),
          patientId: $checkedConvert('patient_id', (v) => v as String),
          nurseId: $checkedConvert('nurse_id', (v) => v as String?),
          serviceId: $checkedConvert('service_id', (v) => v as String),
          serviceKey: $checkedConvert(
            'services',
            (v) => _serviceKeyFromEmbed(v),
          ),
          scheduledAt: $checkedConvert(
            'scheduled_at',
            (v) => DateTime.parse(v as String),
          ),
          status: $checkedConvert('status', (v) => v as String),
          remarks: $checkedConvert('remarks', (v) => v as String?),
          address: $checkedConvert('address', (v) => v as String),
          price: $checkedConvert('price', (v) => _asDouble(v)),
          createdAt: $checkedConvert(
            'created_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          updatedAt: $checkedConvert(
            'updated_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'patientId': 'patient_id',
        'nurseId': 'nurse_id',
        'serviceId': 'service_id',
        'serviceKey': 'services',
        'scheduledAt': 'scheduled_at',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at',
      },
    );
