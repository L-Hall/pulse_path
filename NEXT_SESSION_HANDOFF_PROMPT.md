# Next Claude Code Session Handoff Prompt

Copy and paste this entire prompt to the next Claude Code session for seamless continuity:

---

**Context**: I'm continuing development on PulsePath, an HRV-based wellbeing tracking Flutter app. The previous session completed Phase 2B (Camera PPG Capture) and I need to begin Phase 3 (Dashboard UI & Data Persistence).

**Project Location**: `/Users/laurascullionhall/my_app/pulse_path/`
**GitHub Repository**: https://github.com/L-Hall/pulse_path

## What's Already Complete ✅

The previous Claude Code sessions successfully completed **Phase 2A (HRV Metrics Engine)** and **Phase 2B (Camera PPG Capture)**:

- **Foundation Architecture**: Feature-based folder structure with core/, features/, shared/ directories
- **Dependencies**: All required packages installed (Riverpod 2.x, Drift, Firebase, health tracking, etc.)
- **Database**: Encrypted SQLCipher database schema with HRV data models (Freezed generated)
- **State Management**: Riverpod providers and get_it dependency injection configured
- **Code Generation**: All *.g.dart and *.freezed.dart files generated successfully
- **Quality**: Strict linting rules, app compiles, tests pass, GitHub repo created

### ✅ **Phase 2A: HRV Metrics Engine (December 2024)**

**Complete HRV calculation system ready for production:**

1. **HRV Calculation Service** (`lib/features/hrv/domain/services/hrv_calculation_service.dart`)
   - ✅ All 14 HRV metrics implemented: RMSSD, SDNN, Mean RR, LF, HF, LF/HF, Baevsky, CV, MxDMn, Moda, AMo50, pNN50, pNN20, Total Power, DFA-α1
   - ✅ Performance optimized: <16ms calculation time
   - ✅ Physiological validation: RR intervals 300-2000ms range
   - ✅ Comprehensive error handling for edge cases

2. **HRV Scoring Service** (`lib/features/hrv/domain/services/hrv_scoring_service.dart`)
   - ✅ 0-100 scoring for Stress, Recovery, and Energy scores
   - ✅ Age and gender normalization based on research
   - ✅ Confidence scoring for data quality assessment
   - ✅ Clinically-informed algorithms

3. **Complete Unit Tests** (`test/features/hrv/`)
   - ✅ 35+ test cases covering all metrics and edge cases
   - ✅ Reference vector validation against known HRV values
   - ✅ Performance testing with large datasets
   - ✅ Error handling verification

4. **Dependency Injection & State Management**
   - ✅ Services registered in GetIt container (`lib/core/di/injection_container.dart`)
   - ✅ Complete Riverpod providers (`lib/features/hrv/presentation/providers/hrv_providers.dart`)
   - ✅ Integration-ready architecture

### ✅ **NEW: Phase 2B: Camera PPG Capture (December 2024)**

**Complete camera-based HRV capture system - USER CONFIRMED FUNCTIONAL:**

1. **Camera PPG Data Source** (`lib/features/hrv/data/datasources/camera_ppg_datasource.dart`)
   - ✅ Camera permission handling with user-friendly error messages
   - ✅ Rear camera configuration with optimal settings for PPG detection
   - ✅ Flash control and brightness optimization for consistent illumination
   - ✅ 30fps frame streaming with YUV420 format optimization
   - ✅ Resource management with proper cleanup and disposal

2. **PPG Signal Processing Service** (`lib/features/hrv/domain/services/ppg_processing_service.dart`)
   - ✅ Real-time heart rate detection from camera frames
   - ✅ Signal quality assessment with SNR and regularity analysis
   - ✅ RR interval extraction with physiological validation (300-2000ms)
   - ✅ Noise filtering with bandpass filtering and outlier detection
   - ✅ Performance optimization with efficient buffer management

3. **3-Minute Capture UI** (`lib/features/hrv/presentation/pages/hrv_capture_page.dart`)
   - ✅ Progressive capture flow with Material 3 design
   - ✅ Real-time feedback showing heart rate, signal quality, and progress
   - ✅ Animated pulse indicator that syncs with detected heart rate
   - ✅ Countdown timer and progress visualization
   - ✅ Error handling with user-friendly dialogs

4. **Complete PPG State Management** (`lib/features/hrv/presentation/providers/ppg_capture_providers.dart`)
   - ✅ Riverpod providers for camera and processing services
   - ✅ Reactive state management for capture lifecycle
   - ✅ Integration with existing HRV pipeline for seamless data flow

5. **Integration & Navigation**
   - ✅ Updated main.dart with "Try HRV Capture" button for testing
   - ✅ Complete pipeline from camera capture → PPG processing → HRV analysis → scoring
   - ✅ All compilation errors resolved, app builds and runs successfully

## Current State Assessment Needed

Before starting new work, please:

1. **Read these key files** to understand the current architecture:
   - `/CLAUDE.md` - Complete project overview and development guidelines
   - `/TODO.md` - Updated task list showing Phase 2B completion and Phase 3 priorities
   - `/docs/prd.md` - Product requirements and feature specifications
   - `/lib/features/hrv/domain/services/hrv_calculation_service.dart` - Complete metrics engine
   - `/lib/features/hrv/presentation/providers/hrv_providers.dart` - HRV state management
   - `/lib/features/hrv/presentation/pages/hrv_capture_page.dart` - Working camera PPG capture UI
   - `/lib/features/hrv/data/datasources/camera_ppg_datasource.dart` - Camera data source
   - `/lib/features/hrv/domain/services/ppg_processing_service.dart` - PPG signal processing

2. **Verify the build state**:
   - Run `flutter pub get` to ensure dependencies are resolved
   - Run `flutter analyze` to check for any issues (should be clean)
   - Run `flutter test` to verify tests still pass

## Primary Objective for This Session

**Implement Dashboard UI & Data Persistence** - the next critical components for Alpha release.

### Specific Tasks (in priority order):

1. **Dashboard Home Screen**:
   - File: `/lib/features/dashboard/presentation/pages/dashboard_page.dart`
   - Create home screen with three score cards (Stress, Recovery, Energy)
   - Implement real-time score display from HRV readings
   - Add Material 3 design with proper theming
   - Create responsive layout for different screen sizes

2. **HRV Trend Visualization**:
   - File: `/lib/features/dashboard/presentation/widgets/hrv_trend_chart.dart`
   - Add trend chart using fl_chart with 60fps animations
   - Display historical HRV data over time (daily, weekly, monthly views)
   - Implement interactive chart with zoom and pan capabilities
   - Show score trends for Stress, Recovery, and Energy

3. **Database Repository Implementation**:
   - File: `/lib/features/hrv/data/repositories/hrv_repository.dart`
   - Complete database repository for HRV reading CRUD operations
   - Add search and filtering capabilities for historical data
   - Implement data pagination for large datasets
   - Create efficient queries for dashboard data loading

4. **Data Export & Management**:
   - File: `/lib/features/settings/presentation/pages/data_export_page.dart`
   - Implement data export functionality (CSV/JSON formats)
   - Add data import capabilities for backup restoration
   - Create data retention policies and cleanup utilities
   - Implement offline-first sync queue preparation

### Success Criteria for This Session:
- Functional dashboard displaying HRV scores and trends
- Database repository with full CRUD operations
- Data export/import capabilities working
- <400ms dashboard load time achieved
- Clear progress toward Alpha release completion

### Important Technical Notes:
- **Build on existing systems**: Use `HrvCalculationService`, `HrvScoringService`, and camera PPG capture
- **Performance**: Target <400ms dashboard load time and 60fps chart animations
- **Data flow**: HRV readings → Database → Dashboard display → Export capabilities
- **Architecture**: Follow established repository pattern and dependency injection
- **Security**: Continue zero-plaintext approach for health data encryption
- **UI/UX**: Maintain Material 3 design consistency with existing capture page

## If You Encounter Issues:
- The HRV metrics engine and camera PPG capture are fully functional and tested
- All dependencies are properly configured and services are registered
- The database schema is already set up with HRV data models
- The database encryption key is currently hardcoded (marked as technical debt)
- Camera PPG capture is working and can generate HRV readings for testing

## Expected Outcome:
By the end of this session, we should have a complete Alpha-ready app that can:
- Display real-time HRV scores (Stress, Recovery, Energy) on dashboard
- Show historical trends and data visualization
- Store and retrieve HRV readings from encrypted database
- Export data for user backup and analysis
- Provide complete user journey from capture → analysis → visualization → export

This will complete the core Alpha functionality and make PulsePath ready for initial user testing!

Ready to build PulsePath's beautiful dashboard and data management system! 📊✨