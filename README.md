# CURE — Home‑Care Nursing (Flutter)

An enterprise‑style module for booking and orchestrating home‑care nursing
services. A patient selects a clinical service, resolves a schedule slot, adds
clinical remarks, and moves the booking through a **deterministic state
machine**; a data‑driven dashboard shows aggregates, active requests and
history.

---

## Architecture

Each feature is a vertical slice with three layers:

```
Presentation (Cubit + freezed state, pages, widgets)
      │  depends on ▼
Domain (entities, repository interfaces, use cases, Result<T>)
      ▲  implemented by ▼
Data (models @JsonSerializable, data sources, repository impls)
```

```
lib/
├── core/
│   ├── network/            # dio ApiClient + interceptors (auth, logging, retry) + error mapper
│   └── notifications/      # FCM + local notifications service
├── features/
│   ├── auth/               # Firebase auth + Firestore profiles (existing)
│   ├── booking/            # service select → schedule → remarks → confirm  (state machine)
│   ├── dashboard/          # patient aggregates + active/history
│   └── profile/            # settings, theme, language
└── shared/
    ├── di/                 # manual singleton DI container (`di`)
    ├── theme_and_locals/   # ThemeCubit, LanguageCubit, theme, gradients
    └── utils/              # Result<T>, Failure hierarchy
```

- **State management:** `flutter_bloc`. New cubits use **freezed** states with
  explicit `Initial/Loading/Loaded/Error` (dashboard) or a single immutable
  wizard state with a `step` field (booking).
- **Error handling:** repositories return `Result<T>` (`Success`/`Failure`);
  dio errors are centrally mapped to the `Failure` hierarchy
  (`network_exception_mapper.dart`).
- **DI:** `lib/shared/di/injection.dart` — a manual singleton (`di`) with
  `initialize()`, getters, and `createXCubit()` factories.

### Deterministic booking state machine
`lib/features/booking/domain/entities/booking_status.dart` defines the legal
transitions and the single `transition()` enforcement point:

```
requested → confirmed → inProgress → completed
     └──────────┴────────────┴──────→ cancelled        (completed/cancelled = terminal)
```

Illegal moves throw `InvalidTransitionException`; the use case validates the
transition **before** any network write. Covered by
`test/features/booking/domain/booking_status_test.dart`.

### Network layer (dio → Supabase REST)
`lib/core/network/` exposes a backend‑agnostic `ApiClient` (data sources never
touch Dio directly). `DioApiClient` wires three interceptors:

- **AuthInterceptor** — injects the `apikey` header + `Authorization: Bearer`
  token (from a swappable `AuthTokenProvider`) + `Prefer: return=representation`.
- **RetryInterceptor** — exponential backoff on timeouts/connection/5xx, **only
  for idempotent methods**, so a booking `POST` is never duplicated.
- **LoggingInterceptor** — debug‑only, secrets redacted.

---

## Backend (Supabase)

Booking/services/availability live in Supabase and are reached over its
auto‑generated REST API (PostgREST). Firebase remains the source of truth for
auth + user profiles.

1. Create a Supabase project.
2. Run `docs/supabase_schema.sql` in the SQL editor (tables, RLS, seed services).
3. Copy your project URL + **anon/publishable** key into config (below).

### Auth bridge (documented trade‑off)
Supabase RLS expects a Supabase‑issued JWT (`auth.uid()`); **Firebase ID tokens
are not accepted by Supabase by default**. Two options:

- **Option A (shipped):** authenticate REST with the anon key; store the
  Firebase uid in `bookings.patient_id`; the repository always filters by uid.
  Isolation is enforced app‑side (documented limitation). The network layer is
  structured so this is a **one‑class swap** (`AuthTokenProvider`).
- **Option B (future):** also sign into Supabase on Firebase login and return
  the Supabase access token from `AuthTokenProvider`, enabling `auth.uid()`‑based
  RLS (policies are included, commented, in the SQL).

---

## Security

The previous build hardcoded a Supabase **`service_role`** key in the client
(it bypasses RLS). This is fixed:

- The key is now read from `--dart-define=SUPABASE_ANON_KEY=…` (never hardcoded).
- Use the **anon/publishable** key, not `service_role`.
- **Rotate the leaked `service_role` key** in the Supabase dashboard (it remains
  in git history).
- After the swap, add a Storage RLS policy for the avatar buckets so signup
  image upload keeps working (template in `docs/supabase_schema.sql`).

---

Tests cover the state machine, JSON mapping, the repository (mocked data
source), the booking cubit (`bloc_test`), the dashboard aggregation, the retry
interceptor, the error mapper, and a service‑selection widget test.

## Push notifications (FCM)

`lib/core/notifications/notification_service.dart` handles permission, the FCM
token (stored on the user's Firestore profile), foreground messages, and local
notifications. Booking‑status changes are surfaced two ways:

1. **Implemented:** poll‑based — the dashboard raises a local notification when a
   booking's status changes between refreshes.
2. **Production path (documented):** a Supabase DB webhook / Edge Function (or
   Firebase Cloud Function) on `bookings` UPDATE that pushes via FCM to the
   stored token.

## CI/CD

`.github/workflows/ci.yaml` runs on push/PR: `pub get` → codegen
(`intl_utils` + `build_runner`) → `flutter analyze` → `flutter test` →
`flutter build apk`. Set `SUPABASE_URL` / `SUPABASE_ANON_KEY` as repository
secrets.

## Running

```bash
flutter pub get
dart run intl_utils:generate          # localization (S class)
dart run build_runner build           # freezed + json_serializable

define api_config.dart   # then fill in your keys
`api_config.dart` is gitignored.
```

## Testing

```bash
flutter analyze
flutter test
```

## Tech stack

Flutter 3.x → Building cross-platform user interfaces<br>
Dart → Implementing application logic and handling user interactions<br>
flutter_bloc → State management<br>
freezed → Immutable models and union/sealed classes generation<br>
json_serializable → JSON serialization/deserialization code generation<br>
firebase_auth → User authentication<br>
cloud_firestore → Cloud database<br>
firebase_messaging → Push notifications<br>
supabase_flutter → Profile image storage<br>
intl → Internationalization and localization (English/Arabic)
