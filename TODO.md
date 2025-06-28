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

## 🚧 In Progress
None - Phase 1 completed successfully

## 📋 Next Phase (Phase 2: MVP Core Features - Weeks 3-6)

### High Priority - HRV Metrics Engine
- [ ] Implement core HRV calculation algorithms:
  - [ ] RMSSD (Root Mean Square of Successive Differences)
  - [ ] Mean R-R intervals
  - [ ] SDNN (Standard Deviation of NN intervals)
  - [ ] LF (Low Frequency) power
  - [ ] HF (High Frequency) power
  - [ ] LF/HF ratio
  - [ ] Baevsky Stress Index
  - [ ] Coefficient of Variance
  - [ ] MxDMn (Max-Min difference)
  - [ ] Moda (Mode of RR intervals)
  - [ ] AMo50 (Amplitude of Mode)
  - [ ] pNN50/pNN20 percentages
  - [ ] Total Power
  - [ ] DFA-α1 (Detrended Fluctuation Analysis)
- [ ] Create comprehensive unit tests with reference vectors
- [ ] Build HRV calculation service with proper error handling

### High Priority - Camera PPG Capture
- [ ] Implement camera access and configuration
- [ ] Create PPG signal processing pipeline
- [ ] Build frame capture and analysis system
- [ ] Implement 3-minute capture flow with progress UI
- [ ] Add flash control and brightness optimization
- [ ] Create validation for PPG signal quality

### Medium Priority - Basic Dashboard UI
- [ ] Create home screen with three score cards (Stress, Recovery, Energy)
- [ ] Implement score calculation from HRV metrics
- [ ] Add trend chart using fl_chart
- [ ] Create metric drill-down screens
- [ ] Implement Material 3 adaptive design

### Medium Priority - Data Persistence
- [ ] Complete database repository implementations
- [ ] Add HRV reading CRUD operations
- [ ] Implement data export (CSV/JSON)
- [ ] Create offline-first sync queue

## 🎯 Success Criteria for Alpha (Week 8)
- 3-minute PPG capture working on test devices
- All HRV metrics calculated and unit tested
- Encrypted local storage operational
- Basic dashboard displaying scores and trends
- ≥95% PPG success rate on supported devices
- <400ms dashboard load time
- ≥80% test coverage

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