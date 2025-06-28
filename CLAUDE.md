# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

PulsePath is a cross-platform Flutter app (iOS & Android) for HRV-based wellbeing tracking. The app provides real-time **Stress, Recovery, and Energy scores (0-100)** using **3-minute heart rate variability readings** via camera PPG or BLE wearables, combined with lifestyle data (steps, workouts, menstrual cycle). 

**Key Features:**
- **Adaptive Pacing Mode** (default-on) for chronic illness recovery with PEM-risk detection
- **Encrypted cloud sync** with opt-out local-only mode
- **Transparent HRV scoring** with open formulas and citations
- **Freemium pricing**: £5.99/mo, £39.99/yr, £99 lifetime
- **Privacy-first design** (GDPR compliant, no third-party ad SDKs)

## Common Development Commands

### Flutter Development
- **Run app**: `flutter run`
- **Hot reload**: Press `r` in terminal while app is running
- **Hot restart**: Press `R` in terminal while app is running
- **Build for release (Android)**: `flutter build apk --release`
- **Build for release (iOS)**: `flutter build ios --release`
- **Clean build**: `flutter clean && flutter pub get`

### Testing & Quality
- **Run tests**: `flutter test`
- **Run widget tests**: `flutter test test/widget_test.dart`
- **Analyze code**: `flutter analyze`
- **Check dependencies**: `flutter pub deps`
- **Upgrade dependencies**: `flutter pub upgrade`
- **Run coverage**: `flutter test --coverage && genhtml coverage/lcov.info -o coverage/html`
- **Update golden tests**: `flutter test --update-goldens`

### Code Generation & Build
- **Generate code**: `flutter packages pub run build_runner build`
- **Watch for changes**: `flutter packages pub run build_runner watch`
- **Clean generated files**: `flutter packages pub run build_runner clean`
- **Force rebuild**: `flutter packages pub run build_runner build --delete-conflicting-outputs`

### Advanced Quality Analysis
- **Run dart_code_metrics**: `dart run dart_code_metrics:metrics analyze lib`
- **Check anti-patterns**: `dart run dart_code_metrics:metrics check-anti-patterns lib`
- **Full quality report**: `flutter analyze && dart run dart_code_metrics:metrics analyze lib`

### Setup Commands
- **Get dependencies**: `flutter pub get`
- **Check Flutter setup**: `flutter doctor -v`
- **Enable platforms**: `flutter config --enable-watch-os --enable-web`
- **Update Flutter**: `flutter channel stable && flutter upgrade`

## Complete Technology Stack

### Core Platform
- **Flutter 4.x + Dart 3.4**: Cross-platform with watchOS/Wear OS support
- **Swift/SwiftUI**: Native watch extensions when Flutter widgets too heavy

### State Management & DI
- **riverpod ^3.0.0**: Async selectors & DevTools timeline support
- **freezed**: Immutable data classes with code generation
- **get_it**: Dependency injection for repositories and services

### Device I/O & Sensors
- **camera ^0.10.5+5**: Rear camera PPG capture with adaptive flash control
- **flutter_blue_plus ^1.10.0**: BLE heart-rate belts (100Hz stream, Heart Rate Service 0x180D)
- **watch_connectivity ^1.2.0** (iOS) / **wear kits** (Android): Bidirectional watch sync
- **health ^11.3.0**: HealthKit + Health Connect (HRV, steps, workouts, menstrual cycle)
- **activity_recognition_flutter + pedometer**: Fallback step counting

### Storage & Encryption
- **drift + drift_sqflite + sqlcipher_flutter_libs**: Encrypted local relational database
- **hive_flutter**: Lightweight cache with AES box encryption
- **flutter_secure_storage**: Encryption key management

### Cloud Services
- **Firebase 2.0 stack**: firebase_auth, cloud_firestore, firebase_storage, firebase_crashlytics, firebase_messaging
- **pointycastle**: Client-side AES-GCM encryption before Firestore operations
- **Optional Supabase**: Alternative with Postgres + row-level security

### UI & Charts
- **fl_chart + syncfusion_flutter_charts**: HRV trends with 60fps animations
- **material_you + cupertino + flutter_adaptive_scaffold**: Material 3 + Apple HIG compliance

### Monetization & Analytics
- **in_app_purchase**: StoreKit 2 + Play Billing v6 for subscriptions
- **Self-hosted Plausible SDK**: Privacy-respecting analytics with hashed userID only

### Background & Notifications
- **flutter_local_notifications + firebase_messaging + workmanager**: Daily summaries, HRV reminders, upload retries

## Core Feature Requirements

### Must-Have (Alpha/Beta-1)
1. **3-minute PPG HRV capture** - ≥95% success rate, within ±10ms RMSSD vs Polar H10
2. **Complete metrics engine** - All HRV metrics: RMSSD, Mean R-R, SDNN, LF, HF, LF/HF, Baevsky index, Coefficient of Variance, MxDMn, Moda, AMo50, pNN50/20, Total Power, DFA-α1
3. **BLE wearable integration** - Pair/unpair flow with ≥100Hz stream for Polar, Garmin HRM-Pro, Apple Watch
4. **Home dashboard** - Three score cards + trend graph + metric drill-downs (loads <400ms)
5. **Encrypted cloud sync** - Multi-device continuity with opt-out switch and full offline parity
6. **Local data encryption** - AES-256 for all biometric data, no plaintext exposure

### Should-Have (Beta-1)
7. **Subscription paywall** - StoreKit & Play Billing integration with purchase restoration
8. **Adaptive Pacing Mode** - Default-on with toggle, PEM-risk badge on dashboard
9. **Health data import** - Daily ingestion of steps, workouts, menstrual cycle from HealthKit/Google Fit

## Performance & Quality Targets

### Performance Requirements
- **Cold-start**: <2 seconds
- **Widget build**: ≤16ms per frame
- **PPG success rate**: ≥95% on supported devices
- **Dashboard load**: <400ms on mid-range devices

### Security Standards
- **Encryption**: End-to-end TLS 1.3, client-side AES for cloud payloads
- **Compliance**: OWASP MASVS L1, GDPR compliant
- **Zero-knowledge**: Independent security audit pre-launch

### Quality Gates
- **Code coverage**: ≥80%
- **Crash-free sessions**: ≥99.5%
- **Static analysis**: Zero `flutter analyze` issues
- **Complexity**: Cyclomatic complexity ≤15 (fail CI if exceeded)
- **Linting**: flutter_lints + dart_code_metrics compliance

## Platform Support Matrix

### Minimum OS Versions
- **Android**: 8.1 (API 27) - Build with SDK 35 (Android 15)  
- **iOS**: 13.0 - Build with Xcode 16 / iOS 18 SDK
- **watchOS**: 9.0 - Build with Xcode 16 / watchOS 11 SDK
- **Wear OS**: Android 10 (API 29) - Build with Wear OS 4 SDK

## Development Guidelines

### Architecture Patterns
- **Offline-first**: Full feature parity offline with queued sync
- **Repository pattern**: Use get_it for DI, Riverpod for state management
- **Feature-based structure**: Group by domain (hrv, dashboard, sync, etc.)

### Data Security Requirements
- **Biometric data**: AES-256 local encryption, keys in flutter_secure_storage
- **Cloud payloads**: Client-side AES-GCM encryption before Firestore.set()
- **Health permissions**: Granular consent with option to skip menstrual cycle tracking
- **Zero plaintext**: No biometric data stored in plaintext anywhere

### Testing Requirements
- **Unit tests**: All business logic, especially HRV calculations vs reference vectors
- **Widget tests**: UI components with golden test snapshots
- **Integration tests**: Camera PPG, BLE connectivity, health data import
- **CI verification**: iPhone 14 sim, Pixel 8 emulator, Apple Watch Series 9 sim

### Current State (Updated December 2024)
**Phase 1 Foundation Complete** - The project has moved beyond initial setup:

✅ **Architecture Established**: Feature-based structure with core/, features/, and shared/ directories
✅ **Dependencies Configured**: All required packages installed and working (Riverpod, Drift, Firebase stack)
✅ **Database Ready**: Encrypted SQLCipher database with HRV data models and schema
✅ **State Management**: Riverpod providers and dependency injection (get_it) configured
✅ **Code Generation**: Freezed models and Drift database code generated successfully
✅ **Quality Gates**: Strict linting rules, analysis options, and basic tests passing
✅ **Version Control**: GitHub repository created at https://github.com/L-Hall/pulse_path

**Ready for Phase 2**: HRV metrics engine and camera PPG capture implementation

### Key Implementation Details
- **Database**: `/lib/shared/repositories/database/app_database.dart` - Encrypted local storage ready
- **Models**: `/lib/shared/models/hrv_reading.dart` - Complete HRV data structures with Freezed
- **DI Container**: `/lib/core/di/injection_container.dart` - Service registration setup
- **Utils**: `/lib/core/utils/app_utils.dart` - Basic HRV calculation helper functions already present
- **Constants**: `/lib/core/constants/app_constants.dart` - All app-wide constants defined
- **Main App**: Updated with Riverpod, Material 3 theming, and welcome screen

## Development Milestones

- **Alpha (T+8w)**: 3-min PPG capture, metrics engine, local encrypted storage
- **Beta-1 (T+14w)**: Cloud sync, wearable support, Adaptive Pacing UI, paywall
- **Public Beta (T+20w)**: Store internal testing, analytics dashboards  
- **Launch v1.0 (T+24w)**: Global release with marketing site