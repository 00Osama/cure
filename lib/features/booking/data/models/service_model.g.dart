// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ServiceModel',
      json,
      ($checkedConvert) {
        final val = ServiceModel(
          id: $checkedConvert('id', (v) => v as String),
          key: $checkedConvert('key', (v) => v as String),
          basePrice: $checkedConvert('base_price', (v) => _asDouble(v)),
          active: $checkedConvert('active', (v) => v as bool? ?? true),
          sortOrder: $checkedConvert(
            'sort_order',
            (v) => (v as num?)?.toInt() ?? 0,
          ),
        );
        return val;
      },
      fieldKeyMap: const {'basePrice': 'base_price', 'sortOrder': 'sort_order'},
    );
