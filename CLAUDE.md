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

## Architecture Overview

### Clean Architecture Pattern
The codebase follows **feature-based clean architecture** with clear separation of concerns:

```
lib/
├── core/                    # Cross-cutting concerns
│   ├── constants/          # App-wide constants and configuration
│   ├── di/                 # Dependency injection container  
│   ├── services/           # Core services (error handling, logging, performance)
│   ├── theme/              # Liquid Glass Material 3 theme
│   └── utils/              # Utility functions and helpers
├── features/               # Feature modules (domain-driven design)
│   ├── dashboard/          # Home dashboard with score cards and trends
│   ├── hrv/                # HRV capture and metrics calculation
│   ├── ble/                # Bluetooth Low Energy integration
│   ├── auth/               # Firebase authentication
│   └── settings/           # App configuration and preferences
└── shared/                 # Shared models and repositories
    ├── models/             # Core data structures (HrvReading, etc.)
    └── repositories/       # Data access layer with platform abstraction
```

### Repository Pattern with Platform Abstraction
- **Web Platform**: `SimpleHrvRepository` with in-memory storage
- **Mobile/Desktop**: `DatabaseHrvRepository` with SQLCipher encryption
- **Interface**: `HrvRepositoryInterface` enables seamless platform switching
- **Migration**: `DataMigrationService` handles repository transitions

### State Management
- **Riverpod 2.4.9** for reactive state management
- **Get_it 7.6.0** for dependency injection
- **Freezed** for immutable data classes with code generation

## Git Worktree Development Workflow

This project uses **Git Worktrees for 4x parallel development** across multiple feature branches. This enables simultaneous work on different features without context switching.

### Worktree Structure
```
pulse_path/                    # Main repository (main branch)
├── worktrees/
│   ├── ble_integration/       # BLE development (Port: 8051/8101)
│   ├── cloud_sync/           # Cloud sync development (Port: 8052/8102)
│   ├── subscription_paywall/ # Payment system (Port: 8053/8103)
│   ├── adaptive_pacing/      # Chronic illness features (Port: 8054/8104)
│   └── testing_qa/          # Testing environment (Port: 8055/8105)
└── dev.sh                   # Worktree management script
```

### Essential Worktree Commands
- **List worktrees**: `./dev.sh list-worktrees`
- **Setup new worktree**: `./dev.sh setup-worktree ble_integration`
- **Start development**: `./dev.sh start-worktree ble_integration`
- **Run Flutter**: `./dev.sh flutter-run ble_integration`
- **Sync shared files**: `./dev.sh sync-worktrees`
- **Clean all**: `./dev.sh clean-worktrees`

### 4x Parallel Development Setup
```bash
# Terminal 1: Main coordination
./dev.sh list-worktrees
git status

# Terminal 2: Feature development
cd worktrees/ble_integration
flutter run

# Terminal 3: Continuous testing
cd worktrees/testing_qa
flutter test --watch

# Terminal 4: Build verification
./dev.sh flutter-build cloud_sync web
```

### VSCode Multi-Root Workspace
Open `pulse_path.code-workspace` for development across all worktrees simultaneously.

## Common Development Commands

### Flutter Development
- **Run app**: `flutter run`
- **Hot reload**: Press `r` in terminal while app is running
- **Hot restart**: Press `R` in terminal while app is running
- **Build for release (Android)**: `flutter build apk --release`
- **Build for release (iOS)**: `flutter build ios --release`
- **Clean build**: `flutter clean && flutter pub get`

### Testing & Quality
- **Run all tests**: `flutter test`
- **Run specific test file**: `flutter test test/features/hrv/hrv_calculation_service_test.dart`
- **Watch mode**: `flutter test --watch`
- **Coverage report**: `flutter test --coverage && genhtml coverage/lcov.info -o coverage/html`
- **Update golden tests**: `flutter test --update-goldens`
- **Integration tests**: `flutter test integration_test/`
- **Performance tests**: `flutter test test/performance/`
- **Analyze code**: `flutter analyze --no-fatal-infos`
- **Check dependencies**: `flutter pub deps`
- **Upgrade dependencies**: `flutter pub upgrade`

### Testing Structure
```
test/
├── features/               # Feature-specific unit tests
│   ├── hrv/               # HRV calculation and scoring tests
│   ├── ble/               # BLE integration tests
│   └── dashboard/         # Dashboard widget tests
├── integration/           # End-to-end integration tests
├── performance/           # Performance benchmark tests
└── support/               # Test utilities and mock data
    ├── mock_data_service.dart  # Realistic test data generator
    └── test_utils.dart         # Common test helpers
```

### Code Generation & Build
- **Generate code**: `flutter packages pub run build_runner build`
- **Watch for changes**: `flutter packages pub run build_runner watch`
- **Clean generated files**: `flutter packages pub run build_runner clean`
- **Force rebuild**: `flutter packages pub run build_runner build --delete-conflicting-outputs`

### Advanced Quality Analysis
- **Run dart_code_metrics**: `dart run dart_code_metrics:metrics analyze lib`
- **Check anti-patterns**: `dart run dart_code_metrics:metrics check-anti-patterns lib`
- **Full quality report**: `flutter analyze && dart run dart_code_metrics:metrics analyze lib`

### Analysis Configuration (`analysis_options.yaml`)
- **Strict Analysis**: Enabled strict-casts, strict-inference, strict-raw-types
- **Flutter Lints**: Based on `package:flutter_lints/flutter.yaml`
- **Custom Rules**: 25+ additional linting rules for code quality
- **Generated File Exclusion**: Excludes `*.g.dart`, `*.freezed.dart`, `*.drift.dart`
- **Complexity Limits**: Cyclomatic complexity ≤15, max nesting ≤5

### Setup Commands
- **Get dependencies**: `flutter pub get`
- **Check Flutter setup**: `flutter doctor -v`
- **Enable platforms**: `flutter config --enable-watch-os --enable-web`
- **Update Flutter**: `flutter channel stable && flutter upgrade`

## Complete Technology Stack

### Core Platform
- **Flutter 3.4+ + Dart 3.4**: Cross-platform with watchOS/Wear OS support
- **SDK Constraint**: `^3.4.0` for modern language features
- **Swift/SwiftUI**: Native watch extensions when Flutter widgets too heavy

### State Management & DI
- **riverpod ^2.4.9**: Async selectors & DevTools timeline support
- **freezed**: Immutable data classes with code generation
- **get_it**: Dependency injection for repositories and services

### Device I/O & Sensors
- **camera ^0.10.5+5**: Rear camera PPG capture with adaptive flash control
- **flutter_blue_plus ^1.10.0**: BLE heart-rate belts (100Hz stream, Heart Rate Service 0x180D)
- **watch_connectivity ^1.2.0** (iOS) / **wear kits** (Android): Bidirectional watch sync
- **health ^10.2.0**: HealthKit + Health Connect (HRV, steps, workouts, menstrual cycle)
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
- **fl_chart**: HRV trends with 60fps animations
- **cupertino_icons**: Material 3 + Apple HIG compliance

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

### 🚨 CRITICAL DEVELOPMENT WORKFLOW 🚨
**ALWAYS follow these steps after making changes:**
1. **Build Verification**: Run `flutter build web` or `flutter build apk --debug` to check for configuration errors
2. **Test Compilation**: Run `flutter analyze --no-fatal-infos` to verify no critical errors  
3. **Run Tests**: Run `flutter test` to ensure no regressions
4. **Code Generation**: Run `flutter packages pub run build_runner build` if models/repositories changed
5. **Git Commit**: Commit changes after each feature increment with descriptive messages
6. **Git Push**: Push to remote repository to maintain backup and enable collaboration

**Remember**: Configuration errors may not appear until build time. Always verify builds before considering a feature complete!

### Worktree-Specific Workflow
When working in a worktree:
1. **Sync before starting**: `./dev.sh sync-worktrees` to get latest shared files
2. **Use dedicated ports**: Each worktree has assigned port ranges (see worktree table)
3. **Test in isolation**: Use `testing_qa` worktree for cross-feature validation
4. **Commit to feature branch**: Keep feature work in respective branches
5. **Merge when ready**: Merge feature branches to main when complete

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
**Phase 5 Database Migration Complete** - Production-ready encrypted database infrastructure:

✅ **Phase 1**: Foundation Setup - Architecture, dependencies, and project structure
✅ **Phase 2A**: HRV Metrics Engine - All 14 metrics implemented with unit tests
✅ **Phase 2B**: Camera PPG Capture - Working 3-minute HRV capture system
✅ **Phase 3**: Dashboard UI - Beautiful Material 3 dashboard with charts and export
✅ **Phase 4**: Database Infrastructure - Enterprise-grade encrypted storage
✅ **Phase 5**: Platform Migration - DatabaseHrvRepository for mobile/desktop, SimpleHrvRepository for web

**Current Architecture**:
- **Web Platform**: Uses SimpleHrvRepository with in-memory storage
- **Mobile/Desktop**: Uses DatabaseHrvRepository with SQLCipher encryption
- **Clean Interface**: HrvRepositoryInterface enables seamless platform switching
- **Data Migration**: DataMigrationService for repository transitions
- **Sample Data**: Automatic initialization for new users

**Ready for Phase 6**: BLE wearable integration or advanced features

### Key Implementation Details

#### Core Architecture Files
- **Main Entry**: `/lib/main.dart` - Firebase initialization, Riverpod setup, Material 3 theming
- **DI Container**: `/lib/core/di/injection_container.dart` - Platform-specific repository registration
- **App Constants**: `/lib/core/constants/app_constants.dart` - Configuration, colors, dimensions
- **Liquid Glass Theme**: `/lib/core/theme/liquid_glass_theme.dart` - Custom Material 3 implementation

#### Data Layer
- **HRV Models**: `/lib/shared/models/hrv_reading.dart` - Complete data structures with Freezed
- **Database Schema**: `/lib/shared/repositories/database/app_database.dart` - SQLCipher encryption
- **Repository Interface**: `/lib/shared/repositories/hrv_repository_interface.dart` - Platform abstraction
- **Database Repo**: `/lib/shared/repositories/database/database_hrv_repository.dart` - Mobile/desktop
- **Simple Repo**: `/lib/shared/repositories/simple/simple_hrv_repository.dart` - Web platform

#### Services Layer
- **Error Handling**: `/lib/core/services/error_handling_service.dart` - Centralized error management
- **Logging**: `/lib/core/services/logging_service.dart` - Structured logging with levels
- **Performance Monitoring**: `/lib/core/services/performance_monitoring_service.dart` - Benchmarking
- **Data Migration**: `/lib/core/services/data_migration_service.dart` - Repository transitions

#### Testing Infrastructure
- **Mock Data**: `/test/support/mock_data_service.dart` - Realistic test data generation
- **Test Utils**: `/test/support/test_utils.dart` - Common testing helpers and utilities
- **HRV Tests**: `/test/features/hrv/hrv_calculation_service_test.dart` - Metrics validation
- **Integration**: `/test/integration/app_integration_test.dart` - End-to-end testing

## Development Milestones

- **Alpha (T+8w)**: 3-min PPG capture, metrics engine, local encrypted storage
- **Beta-1 (T+14w)**: Cloud sync, wearable support, Adaptive Pacing UI, paywall
- **Public Beta (T+20w)**: Store internal testing, analytics dashboards  
- **Launch v1.0 (T+24w)**: Global release with marketing site