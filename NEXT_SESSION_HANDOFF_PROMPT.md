# Next Claude Code Session Handoff Prompt

Copy and paste this entire prompt to the next Claude Code session for seamless continuity:

---

**Context**: I'm continuing development on PulsePath, an HRV-based wellbeing tracking Flutter app. The previous session completed Phase 2A (HRV Metrics Engine) and I need to begin Phase 2B (Camera PPG Capture).

**Project Location**: `/Users/laurascullionhall/my_app/pulse_path/`
**GitHub Repository**: https://github.com/L-Hall/pulse_path

## What's Already Complete ✅

The previous Claude Code session successfully completed the **complete HRV metrics engine**:

- **Foundation Architecture**: Feature-based folder structure with core/, features/, shared/ directories
- **Dependencies**: All required packages installed (Riverpod 2.x, Drift, Firebase, health tracking, etc.)
- **Database**: Encrypted SQLCipher database schema with HRV data models (Freezed generated)
- **State Management**: Riverpod providers and get_it dependency injection configured
- **Code Generation**: All *.g.dart and *.freezed.dart files generated successfully
- **Quality**: Strict linting rules, app compiles, tests pass, GitHub repo created

### ✅ **NEW: HRV Metrics Engine (Phase 2A - December 2024)**

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

## Current State Assessment Needed

Before starting new work, please:

1. **Read these key files** to understand the current architecture:
   - `/CLAUDE.md` - Complete project overview and development guidelines
   - `/TODO.md` - Updated task list showing Phase 2A completion
   - `/docs/prd.md` - Product requirements and feature specifications
   - `/lib/features/hrv/domain/services/hrv_calculation_service.dart` - Complete metrics engine
   - `/lib/features/hrv/presentation/providers/hrv_providers.dart` - State management

2. **Verify the build state**:
   - Run `flutter pub get` to ensure dependencies are resolved
   - Run `flutter analyze` to check for any issues (should be clean)
   - Run `flutter test` to verify tests still pass

## Primary Objective for This Session

**Implement Camera PPG Capture** - the next critical component for Alpha release.

### Specific Tasks (in priority order):

1. **Camera Access & Configuration**:
   - File: `/lib/features/hrv/data/datasources/camera_ppg_datasource.dart`
   - Implement camera permission handling
   - Configure rear camera with flash control
   - Set optimal resolution and frame rate for PPG detection

2. **PPG Signal Processing Pipeline**:
   - File: `/lib/features/hrv/domain/services/ppg_processing_service.dart`
   - Implement real-time frame analysis for heart rate detection
   - Create RR interval extraction from PPG signals
   - Add signal quality validation and noise filtering

3. **3-Minute Capture Flow**:
   - File: `/lib/features/hrv/presentation/pages/hrv_capture_page.dart`
   - Build progressive UI with real-time feedback
   - Implement capture session management
   - Add progress indicators and quality metrics

4. **Integration with HRV Engine**:
   - Connect PPG processing to existing HRV calculation services
   - Create complete capture-to-analysis pipeline
   - Add validation and error handling

### Success Criteria for This Session:
- Camera PPG capture working on test devices
- Real-time heart rate detection with reasonable accuracy
- 3-minute capture flow with progress UI
- Integration with existing HRV metrics engine
- Clear path to Alpha release completion

### Important Technical Notes:
- **Build on existing HRV engine**: Use `HrvCalculationService` and `HrvScoringService`
- **Performance**: Maintain 30fps capture with real-time processing
- **Quality**: ≥95% success rate target for PPG capture
- **Architecture**: Follow established repository pattern and dependency injection
- **Security**: Continue zero-plaintext approach for health data

## If You Encounter Issues:
- The HRV metrics engine is fully functional and tested
- All dependencies are properly configured
- The database encryption key is currently hardcoded (marked as technical debt)
- Some package versions were downgraded for compatibility (see pubspec.yaml)

## Expected Outcome:
By the end of this session, we should have a working camera PPG capture system that can:
- Access device camera with appropriate permissions
- Detect heart rate from camera PPG signals
- Extract RR intervals for HRV analysis
- Provide 3-minute guided capture experience
- Feed data into the existing HRV metrics engine

This will complete the core functionality needed for Alpha release testing!

Ready to implement PulsePath's camera-based heart rate capture! 📸💓