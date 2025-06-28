| Layer | Technology / Package | Why we need it | Key notes |
| --- | --- | --- | --- |
| **Core** | **Flutter 4.x** + **Dart 3.4** | Single UI code-base; now ships official adaptive widgets for Wear OS & **watchOS targets**  ([linkedin.com](https://www.linkedin.com/pulse/flutter-2025-pioneering-future-cross-platform-development-3tg4f)) | Install via `flutter upgrade`; enable watchOS with `flutter config --enable-watch-os` (beta flag). |
|  | **Swift / SwiftUI** (watch extension) | Native watch face & sensor stream when Flutter widgets are too heavy | Create a “Watch App for Existing iOS App” target in Xcode; communicate via WatchConnectivity. ([cheesecakelabs.com](https://cheesecakelabs.com/blog/flutter-apps-apple-watch-integration/?utm_source=chatgpt.com)) |
| **State mgmt & DI** | `riverpod ^3.0.0`, `freezed`, `get_it` | Testable, compile-safe state graph; DI for repositories | Riverpod 3 adds async selectors & DevTools timeline. |
| **Device I/O** | `camera ^0.10.5+5` | Access rear camera frames for PPG HRV capture ([docs.flutter.dev](https://docs.flutter.dev/cookbook/plugins/picture-using-camera?utm_source=chatgpt.com)) | Requires runtime permission + flash control. |
|  | `flutter_blue_plus ^1.10.0` | BLE heart-rate belts (Polar, Garmin) ([dhiwise.com](https://www.dhiwise.com/post/leveraging-flutter-blue-plus-for-cross-platform-development?utm_source=chatgpt.com)) | 100 Hz stream; use `guid` filter for Heart Rate Service (0x180D). |
|  | `watch_connectivity ^1.2.0` (iOS) / `wear kits` (Android) | Bidirectional sync with watchOS / Wear OS ([pub.dev](https://pub.dev/packages/watch_connectivity?utm_source=chatgpt.com)) | Streams workout & HR data to the phone even when it’s in the background. |
|  | `health ^11.3.0` | Apple HealthKit + Android Health Connect: HRV, steps, workouts, **menstrual cycle** ([pub.dev](https://pub.dev/packages/health?utm_source=chatgpt.com)) | Google Fit is sunset; Health Connect is the default on Android 14+. |
|  | `activity_recognition_flutter` & `pedometer` | Fallback step counting on devices without HealthKit/Connect | Only used if permission to Health data is denied. |
| **Crypto & Storage** | `drift` + `drift_sqflite` + `sqlcipher_flutter_libs` | Encrypted local relational store | Encryption key kept in `flutter_secure_storage`. |
|  | `hive_flutter` | Lightweight cache for UI & settings | AES box encryption built-in. |
| **Cloud sync** | **Firebase 2.0** stack: `firebase_auth`, `cloud_firestore`, `firebase_storage`, `firebase_crashlytics`, `firebase_messaging` | Real-time, offline-capable JSON docs; push; crash logs; anonymous auth | End-to-end encrypt payloads **client-side** before `Firestore.set()` (pointycastle AES-GCM). ([firebase.google.com](https://firebase.google.com/docs/firestore/query-data/listen?utm_source=chatgpt.com)) |
|  | Optional: **Supabase** client | Drop-in if team wants Postgres + row-level security | Follows same AES pre-encryption pattern. |
| **Analytics** | Self-hosted **Plausible** SDK | Privacy-respecting funnel & retention metrics | Send only hashed userID. |
| **UI & Charts** | `fl_chart`, `syncfusion_flutter_charts` (commercial) | HRV trends, menstrual-cycle overlay | Smooth animations at 60 fps. |
|  | `material_you` / `cupertino`  + `flutter_adaptive_scaffold` | Adaptive to phone, tablet, watch | Follows Google’s Material 3 and Apple HIG. |
| **Billing** | `in_app_purchase` (StoreKit 2 & Play Billing v6) | Subscriptions + lifetime licence | Test with StoreKit “sandbox” and Google “License Tester”. |
| **Notifications & BG tasks** | `flutter_local_notifications`, `firebase_messaging`, `workmanager` | Daily summary; background HRV reminders; upload retries | watchOS uses `ComplicationTimeline` for glanceable scores. |
| **Testing** | `flutter_test`, `integration_test`, `mocktail`, `golden_toolkit`, `coverage` | Unit, widget, e2e, golden, coverage ≥ 80 % | CI verifies on iPhone 14 sim, Pixel 8 emulator, Apple Watch Series 9 sim. |
| **CI/CD** | **GitHub Actions** + **Fastlane** | Lint → Test → Build → Sign → Deploy (TestFlight, Play Internal) | Mac runner for iOS/watchOS; self-hosted Linux for Android. |
| **Dev tooling** | VS Code or Android Studio Giraffe; Xcode 16 | Hot-reload, DevTools, Flutter Inspector | Watch simulator requires Xcode 16+. |
| **Quality gates** | `flutter_lints`, `dart_code_metrics`, `slidy` | Static analysis, cyclomatic complexity budgets | Fail CI if score > 15. |

## Minimum OS & SDK matrix

| Target | Min OS | Build SDK |
| --- | --- | --- |
| Android | 8.1 (API 27) | SDK 35 (Android 15) |
| iOS | 13.0 | Xcode 16 / iOS 18 SDK |
| watchOS | 9.0 | Xcode 16 / watchOS 11 SDK |
| Wear OS | Android 10 (API 29) | Android Wear OS 4 SDK |

## Quick “flutter doctor” snippet

```jsx
flutter channel stable
flutter upgrade
flutter config --enable-watch-os --enable-web
flutter doctor -v 
```