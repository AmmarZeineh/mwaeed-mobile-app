# Mwaeed — Service Booking App (Flutter)

A service-booking mobile application connecting **clients** with **service providers**. The app supports browsing providers, booking appointments, payments, favorites, notifications, and ratings — with Arabic/RTL and Clean Architecture.

---

## ✨ Key Features
- Onboarding flow
- Authentication:
  - Sign up / login
  - Verification flow (code entry)
  - Forgot / reset password
- Home:
  - Categories & providers browsing
- Search (with filters / search types)
- Booking:
  - Book appointment
  - Provider details & reviews section
- Payments:
  - Stripe payment integration
  - Appointments list
- Favorites
- Ratings:
  - Add / edit / delete rating (Cubit-based)
- Push Notifications (Firebase Messaging)
- Profile management
- Arabic + RTL support

---

## 🧱 Architecture & Patterns
- **Clean Architecture per feature:**
  - `data/` (models, data sources, repo impl)
  - `domain/` (entities, repos, use-cases)
  - `presentation/` (views, cubits, widgets)
- **State management:** BLoC / Cubit (`flutter_bloc`)
- **Dependency Injection:** `get_it`
- **Networking:** Dio-based API layer with interceptors
- **Localization:** `easy_localization`
- **Push notifications:** Firebase + local notification service
- **Responsive UI:** `flutter_screenutil`

---

## 🛠️ Tech Stack
- Flutter / Dart
- flutter_bloc (BLoC/Cubit)
- Dio
- get_it
- Firebase Core + Firebase Messaging
- Stripe (`flutter_stripe`)
- easy_localization (i18n)
- shared_preferences
- dartz, equatable

---
## ▶️ Getting Started
```bash
flutter pub get
flutter run
```

---


## 📂 Project Structure (High level)
- `lib/core/` → shared utilities, API service, DI, themes, helpers
- `lib/features/` → modular features (auth, booking, home, payment, ...)

