import 'package:freezed_annotation/freezed_annotation.dart';

part 'service.freezed.dart';

/// A bookable clinical service. The [key] matches the localized copy keys in
/// `lib/l10n/*.arb` (e.g. `basicCare` → `basicCareTitle`/`basicCareItems`),
/// so the title/description are resolved via `S.of(context)` at render time.
@freezed
abstract class Service with _$Service {
  const factory Service({
    required String id,
    required String key,
    required double basePrice,
    @Default(true) bool active,
    @Default(0) int sortOrder,
  }) = _Service;
}
