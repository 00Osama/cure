import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:cure/features/dashboard/domain/entities/dashboard_summary.dart';

part 'dashboard_state.freezed.dart';

/// Explicit, exhaustive dashboard states (Initial / Loading / Loaded / Error).
@freezed
sealed class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = DashboardInitial;
  const factory DashboardState.loading() = DashboardLoading;
  const factory DashboardState.loaded(DashboardSummary summary) =
      DashboardLoaded;
  const factory DashboardState.error(String message) = DashboardError;
}
