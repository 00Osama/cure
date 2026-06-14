# CURE — Home‑Care Nursing (Flutter)

CURE is a healthcare app that connects patients with qualified home nurses. Patients can browse nurse profiles, choose needed nursing services, enter address and clinical notes and request an appointment.
The app also supports nurse and patient accounts, localized Arabic and English UI, profile management, dashboards for booking status, and a structured booking flow for home medical care services.

---

## Architecture

Each feature is a vertical slice with three layers:

```
Data (models @JsonSerializable, data sources, repository impls)
Domain (entities, repository interfaces, use cases, Result<T>)
Presentation (Cubit, pages, widgets)
   
```

```
lib/
├── assets/                 # assets that app need incluading animations and images 
│   ├── animations/            
│   └── images/      
├── core/                   # shared files that app need
│   ├── network/           
│   └── notifications/      
│   ├── di/                
│   ├── theme_and_locals/
│   └── utils/             
├── features/               # app features with clean architecture
│   ├── auth/              
│   ├── booking_nurse/           
│   ├── nurse_dashboard/         
│   └── patient_dashboard/          
│   └── profile/           
└── l10n/                   # arabic and english localization files
    ├── intl_ar.arb/          
    └── intl_en.arb/
```

---

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

---

## Push notifications (FCM)

`lib/core/notifications/notification_service.dart` handles permission, the FCM
token (stored on the user's Firestore profile), foreground messages, and local
notifications. Booking‑status changes are surfaced two ways:

1. **Implemented:** poll‑based — the dashboard raises a local notification when a
   booking's status changes between refreshes.
2. **Production path (documented):** a Supabase DB webhook / Edge Function (or
   Firebase Cloud Function) on `bookings` UPDATE that pushes via FCM to the
   stored token.

---

## Backend 

Firebase remains the source of truth for auth + user profiles managment, Supabase for user images storage. 

1. Create a Supabase project.
2. Copy your project URL + **anon/publishable** key into config (below).

---

## Security

- Supabase keys is read from `--dart-define=SUPABASE_ANON_KEY=…` (never hardcoded).
- Use Firebase Auth for secure login/signup.
- Store nurses and patients in separate Firestore collections.
- Add Firestore security rules so users can only edit their own profile.
- Allow patients to read nurse public info only, not private data.
- Never store passwords manually.
- Validate all user input before saving.
- Keep API keys restricted in Firebase/Supabase settings.
- Log out users and clear local session data safely.

---

## Running

```bash
flutter pub get
dart run intl_utils:generate          # localization (S class)
dart run build_runner build           # freezed + json_serializable

define api_config.dart   # then fill in your keys
`api_config.dart` is gitignored.
```

---

## Testing

```bash
flutter analyze
flutter test
```
