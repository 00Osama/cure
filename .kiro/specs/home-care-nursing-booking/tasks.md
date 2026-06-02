# Implementation Plan: Home Care Nursing Booking

## Overview

Build the feature in Dart/Flutter on the existing "cure" app using Clean Architecture
(Presentation / Domain / Data), BLoC + freezed, the Supabase SDK in data sources, and
Hive for offline caching. Work bottom-up: dependencies and core wiring first, then the
auth, booking, dashboard, offline, and FCM slices, and finally app wiring and CI. Each
slice ships its tests so correctness Properties 1-8 are validated close to the code.

## Tasks

- [ ] 1. Project setup and dependencies
  - [ ] 1.1 Add packages and create the feature folder structure
    - Add to `pubspec.yaml`: `supabase_flutter`, `flutter_bloc`, `freezed_annotation`, `json_annotation`, `hive`, `hive_flutter`, `connectivity_plus`, `flutter_secure_storage`; dev: `build_runner`, `freezed`, `json_serializable`, `hive_generator`
    - Create `lib/core/` and `lib/features/{auth,booking,dashboard}/{data,domain,presentation}/` directories
    - _Requirements: 4.1, 5.1_

- [ ] 2. Core infrastructure
  - [ ] 2.1 Implement DI and failures
    - Create `core/di.dart` (service locator / provider wiring) and `core/error/failures.dart`
    - _Requirements: 1.1, 2.1, 3.1_
  - [ ] 2.2 Implement connectivity wrapper
    - Create `core/connectivity.dart` around `connectivity_plus` exposing `isOnline` and an online/offline stream
    - _Requirements: 4.2, 4.3_

- [ ] 3. Authentication feature
  - [ ] 3.1 Implement auth domain and data
    - Create `user.dart`, `auth_repository.dart`, `auth_remote_datasource.dart`, `auth_repository_impl.dart`
    - Register/login via Supabase Auth; persist and restore the session token with `flutter_secure_storage`; reject invalid/incomplete credentials before any session starts
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5_
  - [ ] 3.2 Implement AuthBloc and screens
    - Create `auth_bloc.dart` (freezed initial/loading/success/error states; register/login/restore/signOut events) and `login_screen.dart`, `register_screen.dart`
    - _Requirements: 1.1, 1.2, 1.3, 1.5_
  - [ ]* 3.3 Write property test for credential rejection
    - **Property 1: Invalid credentials are rejected without a session**
    - **Validates: Requirements 1.3**
  - [ ]* 3.4 Write unit tests for session lifecycle
    - Cover session restore on restart and sign-out clearing the session
    - _Requirements: 1.4, 1.5_

- [ ] 4. Booking feature and state machine
  - [ ] 4.1 Implement Booking entity and state machine
    - Create `booking.dart` with `BookingStatus` (pending/confirmed/completed/cancelled), `canCancel`, and the accept/fulfill/cancel transition rules
    - _Requirements: 2.3, 2.4, 2.5, 2.6, 2.7_
  - [ ]* 4.2 Write property test for booking creation
    - **Property 2: New bookings start in Pending**
    - **Validates: Requirements 2.3**
  - [ ]* 4.3 Write property test for lifecycle transitions
    - **Property 3: Valid lifecycle transitions (Pending→Confirmed, Confirmed→Completed)**
    - **Validates: Requirements 2.4, 2.5**
  - [ ]* 4.4 Write property test for cancel validity
    - **Property 4: Cancel allowed from Pending/Confirmed, rejected from Completed/Cancelled**
    - **Validates: Requirements 2.6, 2.7**
  - [ ] 4.5 Implement booking data, repository, BLoC, and flow screen
    - Create `booking_remote_datasource.dart`, `booking_repository.dart`, `booking_repository_impl.dart` (online path), `booking_bloc.dart`, `booking_flow_screen.dart`
    - Flow: list services, select service + date and show availability, enter remarks, create Pending booking; support cancel
    - _Requirements: 2.1, 2.2, 2.3, 2.6_
  - [ ]* 4.6 Write unit test for availability display
    - Verify schedule availability is shown for a selected service and date
    - _Requirements: 2.2_

- [ ] 5. Checkpoint
  - Ensure all tests pass, ask the user if questions arise.

- [ ] 6. Dashboard feature
  - [ ] 6.1 Implement dashboard domain and repository
    - Create `dashboard_summary.dart`, `dashboard_repository.dart`, `dashboard_repository_impl.dart` (reuse booking sources); compute active/completed/cancelled counts and the active-vs-history partition
    - _Requirements: 3.1, 3.2_
  - [ ] 6.2 Implement DashboardBloc and screen
    - Create `dashboard_bloc.dart` and `dashboard_screen.dart` with summary counts, active/history lists, a cancel quick action for Pending bookings, and pull-to-refresh syncing from Supabase
    - _Requirements: 3.1, 3.2, 3.3, 3.4_
  - [ ]* 6.3 Write property test for summary counts
    - **Property 5: Summary counts are consistent and sum to the total**
    - **Validates: Requirements 3.1**
  - [ ]* 6.4 Write property test for active/history partition
    - **Property 6: Active/history partition is complete and disjoint**
    - **Validates: Requirements 3.2**

- [ ] 7. Offline Hive caching
  - [ ] 7.1 Implement cache datasource and offline-first orchestration
    - Create `booking_cache_datasource.dart` (`bookings_box`, `dashboard_box`) and update `booking_repository_impl.dart`: online reads write through to cache, offline reads return cache, and reconnect re-fetches and refreshes the boxes
    - _Requirements: 4.1, 4.2, 4.3_
  - [ ]* 7.2 Write property test for cache round-trip
    - **Property 7: Cache round-trip returns an equivalent list**
    - **Validates: Requirements 4.1**
  - [ ]* 7.3 Write property test for offline reads
    - **Property 8: Offline reads return cached data unchanged**
    - **Validates: Requirements 4.2**

- [ ] 8. FCM push notifications
  - [ ] 8.1 Implement NotificationService
    - Create `core/notifications.dart`: initialize FCM, request permission, handle foreground/background messages; treat denied permission as non-fatal
    - _Requirements: 5.1, 5.2, 5.3_
  - [ ]* 8.2 Write unit test for permission-denied handling
    - Verify the app keeps running with notifications disabled when permission is denied
    - _Requirements: 5.3_

- [ ] 9. Integration and app wiring
  - [ ] 9.1 Wire everything in main.dart
    - Initialize Supabase, Hive, DI, and NotificationService at startup; provide the three BLoCs; route past login when a stored session is restored
    - _Requirements: 1.4, 4.1, 5.1_
  - [ ]* 9.2 Write integration and smoke tests
    - With mocked Supabase/FCM, cover auth calls (1.1, 1.2), service fetch (2.1), pull-to-refresh sync (3.4), reconnect sync (4.3), notification display (5.2), and FCM init at startup (5.1)
    - _Requirements: 1.1, 1.2, 2.1, 3.4, 4.3, 5.1, 5.2_

- [ ] 10. CI/CD pipeline
  - [ ] 10.1 Add GitHub Actions workflow
    - Create `.github/workflows/ci.yml` running on push and pull_request: `flutter pub get`, `dart run build_runner build --delete-conflicting-outputs`, `flutter analyze`, `flutter test`; a failure in analyze or test fails the job
    - _Requirements: 6.1, 6.2, 6.3_

- [ ] 11. Final checkpoint
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Tasks marked with `*` are optional test tasks and can be skipped for a faster MVP.
- Each task references specific requirements for traceability.
- Property tests (Properties 1-8) validate universal correctness; unit and integration tests cover specific examples and edge cases.
- The booking repository starts online-only in task 4, then gains offline-first behavior in task 7.

## Task Dependency Graph

```json
{
  "waves": [
    { "id": 0, "tasks": ["1.1"] },
    { "id": 1, "tasks": ["2.1", "2.2", "4.1", "8.1"] },
    { "id": 2, "tasks": ["3.1", "4.5", "4.2", "4.3", "4.4", "8.2"] },
    { "id": 3, "tasks": ["3.2", "3.3", "3.4", "4.6", "6.1"] },
    { "id": 4, "tasks": ["6.2", "6.3", "6.4", "7.1"] },
    { "id": 5, "tasks": ["7.2", "7.3", "9.1"] },
    { "id": 6, "tasks": ["9.2", "10.1"] }
  ]
}
```
