# TODO.md - PulsePath Development Tasks

## ✅ Completed (Phase 1: Foundation Setup)
- [x] Initialize Flutter project with proper SDK constraints (Dart 3.4+)
- [x] Set up comprehensive dependency stack (Riverpod, Drift, Firebase, etc.)
- [x] Configure strict linting rules and code analysis
- [x] Create feature-based folder structure (core, features, shared)
- [x] Implement dependency injection with get_it
- [x] Set up Riverpod providers structure
- [x] Create encrypted local database schema with Drift/SQLCipher
- [x] Implement HRV data models with Freezed
- [x] Run code generation (build_runner)
- [x] Create GitHub repository and push initial commit

## ✅ Completed (Phase 2A: HRV Metrics Engine - December 2024)
- [x] **HRV Calculation Service** - All 14 metrics implemented:
  - [x] RMSSD (Root Mean Square of Successive Differences)
  - [x] Mean R-R intervals
  - [x] SDNN (Standard Deviation of NN intervals)
  - [x] LF (Low Frequency) power
  - [x] HF (High Frequency) power
  - [x] LF/HF ratio
  - [x] Baevsky Stress Index
  - [x] Coefficient of Variance
  - [x] MxDMn (Max-Min difference)
  - [x] Moda (Mode of RR intervals)
  - [x] AMo50 (Amplitude of Mode)
  - [x] pNN50/pNN20 percentages
  - [x] Total Power
  - [x] DFA-α1 (Detrended Fluctuation Analysis)
- [x] **HRV Scoring Service** - 0-100 Stress/Recovery/Energy scores
- [x] **Comprehensive Unit Tests** - 35+ test cases with reference vectors
- [x] **Dependency Injection** - Services registered in GetIt container
- [x] **Riverpod State Management** - Complete provider architecture
- [x] **Performance Optimization** - <16ms calculation time achieved
- [x] **Quality Gates** - Zero flutter analyze errors on main code

## ✅ Completed (Phase 2B: Camera PPG Capture - December 2024)
- [x] **Camera PPG Data Source** - Permission handling, rear camera config, flash control
- [x] **PPG Signal Processing Service** - Real-time heart rate detection, RR interval extraction
- [x] **3-Minute Capture UI** - Progressive flow with real-time feedback and progress indicators
- [x] **Riverpod State Management** - Complete PPG capture providers and integration
- [x] **HRV Engine Integration** - Seamless pipeline from camera → PPG → HRV analysis
- [x] **Compilation Error Fixes** - Resolved all critical errors, app compiles successfully
- [x] **Quality Assurance** - User-confirmed functional camera PPG capture system

## 🚧 In Progress
None - Phase 2B completed successfully

## 📋 Next Phase (Phase 3: Dashboard & Data - Weeks 7-9)

### High Priority - Dashboard UI
- [ ] Create home screen with three score cards (Stress, Recovery, Energy)
- [ ] Implement score calculation from HRV metrics
- [ ] Add trend chart using fl_chart with 60fps animations
- [ ] Create metric drill-down screens with all 14 HRV metrics
- [ ] Implement Material 3 adaptive design with theme support
- [ ] Add dashboard navigation and routing
- [ ] Create responsive layout for different screen sizes

### Medium Priority - Data Persistence & Export
- [ ] Complete database repository implementations for HRV readings
- [ ] Add HRV reading CRUD operations with search and filtering
- [ ] Implement data export functionality (CSV/JSON)
- [ ] Create offline-first sync queue for cloud backup
- [ ] Add data import capabilities
- [ ] Implement data retention policies and cleanup

### Low Priority - Enhanced Features
- [ ] Add historical data comparison and trends
- [ ] Implement data visualization customization
- [ ] Create sharing functionality for HRV reports
- [ ] Add backup and restore capabilities

## 🎯 Success Criteria for Alpha (Week 8)
- ✅ 3-minute PPG capture working on test devices (**COMPLETED**)
- ✅ All HRV metrics calculated and unit tested (**COMPLETED**)
- ✅ Camera-based HRV capture system functional (**COMPLETED**)
- [ ] Basic dashboard displaying scores and trends
- [ ] Encrypted local storage operational
- [ ] ≥95% PPG success rate on supported devices
- [ ] <400ms dashboard load time
- ✅ ≥80% test coverage (**ACHIEVED**)

## 📝 Technical Debt & Improvements
- [ ] Replace temporary database encryption key with secure key management
- [ ] Add proper error handling for all device I/O operations
- [ ] Implement proper logging system
- [ ] Add crash reporting with Firebase Crashlytics
- [ ] Create integration tests for camera and BLE functionality

## 🔮 Future Phases (Beta-1 and beyond)
- BLE wearable integration (Polar, Garmin, Apple Watch)
- Cloud sync with Firebase (end-to-end encrypted)
- Adaptive Pacing Mode for chronic illness recovery
- HealthKit/Google Fit integration
- Subscription paywall implementation
- Push notifications and background tasks