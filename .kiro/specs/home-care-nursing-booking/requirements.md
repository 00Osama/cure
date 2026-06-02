# Requirements Document

## Introduction

This feature adds a home care nursing booking experience to the existing Flutter "cure" app. Users register and sign in with Supabase Auth, book a clinical nursing service through a deterministic booking flow, and track their requests on a data-driven dashboard. Bookings and dashboard data are cached locally for offline use, booking-related push notifications are delivered via Firebase Cloud Messaging, and a GitHub Actions workflow runs analysis and tests on every push and pull request.

The app uses Clean Architecture (Presentation / Domain / Data), BLoC for state management with explicit Initial/Loading/Success/Error states, the Supabase SDK called directly in data sources, and Hive for local caching. The scope is intentionally minimal.

## Glossary

- **App**: The Flutter "cure" mobile application.
- **Auth_Service**: The component that handles registration, login, and session persistence using Supabase Auth.
- **Booking_Service**: The component that manages booking creation and booking state transitions.
- **Dashboard**: The screen that displays summary counts, active requests, and booking history.
- **Cache_Store**: The local Hive store that holds bookings and dashboard data.
- **Notification_Service**: The component that registers for and handles Firebase Cloud Messaging notifications.
- **Booking**: A request for a clinical nursing service with a state of Pending, Confirmed, Completed, or Cancelled.
- **Session**: The authenticated user session persisted by the App.

## Requirements

### Requirement 1: Identity & Session Management

**User Story:** As a user, I want to register and sign in securely, so that my bookings stay tied to my account.

#### Acceptance Criteria

1. WHEN a user submits registration with a valid email and password, THE Auth_Service SHALL create the account via Supabase Auth and start a Session.
2. WHEN a user submits login with valid credentials, THE Auth_Service SHALL authenticate via Supabase Auth and start a Session.
3. IF submitted credentials are invalid or incomplete, THEN THE Auth_Service SHALL reject the attempt and display an error message.
4. WHEN the App restarts with a stored Session, THE Auth_Service SHALL restore the Session and route the user past the login screen.
5. WHEN a user signs out, THE Auth_Service SHALL clear the stored Session and route the user to the login screen.

### Requirement 2: Deterministic Booking System

**User Story:** As a user, I want to book a nursing service through clear steps, so that my request follows a predictable lifecycle.

#### Acceptance Criteria

1. WHEN a user opens the booking flow, THE Booking_Service SHALL present the list of available clinical services.
2. WHEN a user selects a service and date, THE Booking_Service SHALL display the schedule availability for that selection.
3. WHEN a user enters patient clinical remarks and confirms, THE Booking_Service SHALL create a Booking in the Pending state.
4. WHEN a Pending Booking is accepted, THE Booking_Service SHALL transition the Booking to Confirmed.
5. WHEN a Confirmed Booking is fulfilled, THE Booking_Service SHALL transition the Booking to Completed.
6. WHERE a Booking is in the Pending or Confirmed state, THE Booking_Service SHALL allow the user to cancel the Booking and transition it to Cancelled.
7. IF a user attempts to cancel a Booking in the Completed or Cancelled state, THEN THE Booking_Service SHALL reject the action and keep the current state.

### Requirement 3: Data-Driven User Dashboard

**User Story:** As a user, I want a dashboard of my bookings, so that I can see my activity at a glance and act on it.

#### Acceptance Criteria

1. WHEN the Dashboard loads, THE Dashboard SHALL display summary counts of active, completed, and cancelled bookings.
2. WHEN the Dashboard loads, THE Dashboard SHALL display the list of active requests and the booking history.
3. WHERE a listed Booking is in the Pending state, THE Dashboard SHALL provide a quick action to cancel that Booking.
4. WHEN a user pulls to refresh, THE Dashboard SHALL sync bookings from Supabase and update the displayed data.

### Requirement 4: Offline-First Data Access

**User Story:** As a user, I want to view my bookings without a connection, so that the app stays useful offline.

#### Acceptance Criteria

1. WHEN bookings or dashboard data are fetched from Supabase, THE Cache_Store SHALL store the data in Hive.
2. WHILE the device is offline, THE App SHALL display the most recent data from the Cache_Store.
3. WHEN connectivity is restored, THE App SHALL sync with Supabase and update the Cache_Store.

### Requirement 5: Push Notifications

**User Story:** As a user, I want booking notifications, so that I know when my request status changes.

#### Acceptance Criteria

1. WHEN the App starts, THE Notification_Service SHALL initialize Firebase Cloud Messaging and request notification permission.
2. WHEN a booking-related notification is received, THE Notification_Service SHALL display the notification to the user.
3. IF notification permission is denied, THEN THE Notification_Service SHALL continue running the App without notifications.

### Requirement 6: CI/CD Pipeline

**User Story:** As a developer, I want automated checks, so that broken code is caught before merge.

#### Acceptance Criteria

1. WHEN a commit is pushed or a pull request is opened, THE GitHub Actions workflow SHALL run `flutter analyze`.
2. WHEN a commit is pushed or a pull request is opened, THE GitHub Actions workflow SHALL run `flutter test`.
3. IF `flutter analyze` or `flutter test` fails, THEN THE GitHub Actions workflow SHALL report a failed status.
