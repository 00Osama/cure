import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/service.dart';

part 'service_model.g.dart';

double _asDouble(dynamic v) =>
    v is num ? v.toDouble() : double.tryParse('$v') ?? 0;

/// Data model for a `services` row. `fieldRename: snake` maps Supabase columns
/// (`base_price`, `sort_order`) onto Dart camelCase automatically.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ServiceModel {
  const ServiceModel({
    required this.id,
    required this.key,
    required this.basePrice,
    this.active = true,
    this.sortOrder = 0,
  });

  final String id;
  final String key;
  @JsonKey(fromJson: _asDouble)
  final double basePrice;
  final bool active;
  final int sortOrder;

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Service toEntity() => Service(
    id: id,
    key: key,
    basePrice: basePrice,
    active: active,
    sortOrder: sortOrder,
  );
}
