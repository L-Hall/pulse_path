# Next Claude Code Session Handoff Prompt

Copy and paste this entire prompt to the next Claude Code session for seamless continuity:

---

**Context**: I'm continuing development on PulsePath, an HRV-based wellbeing tracking Flutter app. The previous session completed Phase 1 (Foundation Setup) and I need to begin Phase 2 (MVP Core Features).

**Project Location**: `/Users/laurascullionhall/my_app/pulse_path/`
**GitHub Repository**: https://github.com/L-Hall/pulse_path

## What's Already Complete ✅

The previous Claude Code session successfully completed the entire foundation setup:

- **Architecture**: Feature-based folder structure with core/, features/, shared/ directories
- **Dependencies**: All required packages installed (Riverpod 2.x, Drift, Firebase, health tracking, etc.)
- **Database**: Encrypted SQLCipher database schema with HRV data models (Freezed generated)
- **State Management**: Riverpod providers and get_it dependency injection configured
- **Code Generation**: All *.g.dart and *.freezed.dart files generated successfully
- **Quality**: Strict linting rules, app compiles, tests pass, GitHub repo created
- **Documentation**: Comprehensive CLAUDE.md, TODO.md, PRD, and tech stack docs

## Current State Assessment Needed

Before starting new work, please:

1. **Read these key files** to understand the current architecture:
   - `/CLAUDE.md` - Complete project overview and development guidelines
   - `/TODO.md` - Current task list and priorities
   - `/docs/prd.md` - Product requirements and feature specifications
   - `/lib/core/constants/app_constants.dart` - All HRV metrics and performance targets
   - `/lib/shared/models/hrv_reading.dart` - Core data structures

2. **Verify the build state**:
   - Run `flutter pub get` to ensure dependencies are resolved
   - Run `flutter analyze` to check for any issues
   - Run `flutter test` to verify tests still pass

## Primary Objective for This Session

**Implement the HRV Metrics Engine** - the most critical component for Alpha release.

### Specific Tasks (in priority order):

1. **Create HRV Calculation Service**:
   - File: `/lib/features/hrv/domain/services/hrv_calculation_service.dart`
   - Implement all 14 HRV metrics from PRD: RMSSD, SDNN, LF, HF, LF/HF, Baevsky, CV, MxDMn, Moda, AMo50, pNN50, pNN20, Total Power, DFA-α1
   - Use the helper functions already present in `/lib/core/utils/app_utils.dart` as starting points
   - Ensure accuracy within ±10ms vs Polar H10 reference (as specified in PRD)

2. **Add Comprehensive Unit Tests**:
   - File: `/test/features/hrv/hrv_calculation_service_test.dart`
   - Create test cases with reference vectors for each HRV metric
   - Target ≥80% code coverage (project requirement)
   - Validate edge cases (empty data, invalid heart rates, etc.)

3. **Implement Score Calculation**:
   - Convert HRV metrics to 0-100 Stress, Recovery, and Energy scores
   - Create scoring algorithms that provide meaningful health insights
   - Add confidence scoring based on data quality

### Success Criteria for This Session:
- All HRV metrics calculate correctly with unit test validation
- Service integrates properly with existing Riverpod/DI architecture
- Code passes all quality gates (flutter analyze with zero errors)
- Clear path established for next session's camera PPG implementation

### Important Notes:
- **Security**: Continue the zero-plaintext approach for health data
- **Performance**: Keep calculations under 16ms for UI responsiveness
- **Architecture**: Follow the established repository pattern and use dependency injection
- **Testing**: Write tests first or alongside implementation (TDD encouraged)

## If You Encounter Issues:
- Check `/Handoff_Summary.md` for detailed context on previous decisions
- The database encryption key is currently hardcoded (marked as technical debt)
- Some package versions were downgraded for compatibility (see pubspec.yaml)

## Expected Outcome:
By the end of this session, we should have a working HRV metrics engine that can take RR interval data and produce accurate HRV measurements and scores, setting up the foundation for camera PPG capture in the following session.

Ready to implement the heart of PulsePath's HRV analysis capabilities!