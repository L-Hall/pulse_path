# Adaptive Pacing Implementation - Next Session Guide

## 🎯 Current Status (Completed ✅)

### Core Backend Infrastructure
- ✅ **Health Data Models**: Comprehensive models for steps, workouts, sleep, menstrual cycle (`/lib/shared/models/`)
  - `daily_health_metrics.dart` - Daily aggregated health data
  - `adaptive_pacing_data.dart` - Pacing assessments and recommendations
- ✅ **Database Schema v2**: Extended with health data tables (`/lib/shared/repositories/database/app_database.dart`)
  - `DailyHealthMetricsTable` - Health data storage
  - `AdaptivePacingAssessmentsTable` - Pacing analysis results
  - `WorkoutSessionsTable` - Individual workout tracking
- ✅ **Health Data Service**: HealthKit/Google Fit integration (`/lib/shared/services/health_data_service.dart`)
- ✅ **Adaptive Pacing Service**: Core algorithm (`/lib/features/adaptive_pacing/domain/services/adaptive_pacing_service.dart`)
  - Multi-factor PEM risk assessment
  - Energy envelope management
  - Personalized chronic condition profiles
  - Activity impact scoring

### Algorithm Features
- HRV baseline establishment and trend analysis
- Activity load assessment with cumulative intensity scoring
- Sleep debt calculation and impact modeling
- Menstrual cycle energy impact (when applicable)
- Chronic condition sensitivity (ME/CFS, POTS, Long COVID, etc.)
- 6-level pacing state determination (excellent → recovery mode)

## 🚧 Next Steps - UI Integration Phase

### Priority 1: Dashboard Integration (Start Here)

#### Files to Modify:
- `/lib/features/dashboard/presentation/pages/dashboard_page.dart` - Main dashboard
- `/lib/features/dashboard/presentation/providers/dashboard_providers.dart` - State management
- `/lib/features/dashboard/presentation/widgets/score_card.dart` - Existing score cards

#### Implementation Tasks:
1. **Health Context Cards**
   - Add step count card alongside existing HRV score cards
   - Display activity level indicator
   - Show sleep quality when available
   - Include daily workout summary

2. **PEM Risk Indicator**
   - Visual warning badge when PEM risk is elevated
   - Color-coded pacing state indicator
   - Trend warning messages

3. **Current Pacing State Display**
   - Prominent display of current state (excellent/good/caution/rest required/recovery mode)
   - Energy envelope percentage
   - Consecutive high-risk day counter

#### Integration Points:
- Import `AdaptivePacingService` and `HealthDataService`
- Create new Riverpod providers for health data and pacing assessments
- Wire services to existing dashboard data flow

### Priority 2: Pacing Recommendations Widget

#### New Files to Create:
- `/lib/features/adaptive_pacing/presentation/widgets/pacing_recommendations_widget.dart`
- `/lib/features/adaptive_pacing/presentation/widgets/activity_guidance_card.dart`
- `/lib/features/adaptive_pacing/presentation/providers/adaptive_pacing_providers.dart`

#### Features to Implement:
1. **Daily Guidance Display**
   - Main recommendation (full rest → can push slightly)
   - Specific action items from assessment
   - Reasoning explanation

2. **Activity Limits**
   - Maximum recommended steps
   - Perceived exertion limits
   - Recommended vs avoided activities

3. **Interactive Elements**
   - "I followed this guidance" button
   - Feedback mechanism for recommendation accuracy
   - Manual symptom reporting

### Priority 3: Background Services

#### Files to Create:
- `/lib/shared/services/background_health_sync_service.dart`
- `/lib/features/adaptive_pacing/data/repositories/adaptive_pacing_repository.dart`

#### Implementation:
1. **Daily Health Data Sync**
   - Background task to import health data
   - Data validation and quality checks
   - Conflict resolution for duplicate data

2. **Automatic Assessment Generation**
   - Daily pacing assessment creation
   - Historical data analysis
   - Trend detection and warnings

## 🏗️ Technical Architecture Overview

### Service Layer Dependencies
```
AdaptivePacingService
├── HealthDataService (health data import)
├── HrvRepositoryInterface (existing HRV data)
└── UserPreferences (chronic condition settings)
```

### Data Flow
```
HealthKit/Google Fit → HealthDataService → DailyHealthMetrics
HRV Readings → AdaptivePacingService → AdaptivePacingAssessment
Assessment → Dashboard UI → User Recommendations
```

### Key Models Location Map
- **Health Data**: `/lib/shared/models/daily_health_metrics.dart`
- **Pacing Data**: `/lib/shared/models/adaptive_pacing_data.dart`
- **User Settings**: `/lib/features/settings/domain/models/user_preferences.dart`
- **HRV Data**: `/lib/shared/models/hrv_reading.dart` (existing)

## 🎨 UI Design Guidelines

### Color Coding for Pacing States
- **Excellent Energy**: Green (#4CAF50)
- **Good Energy**: Light Green (#8BC34A)
- **Moderate Energy**: Yellow (#FFC107)
- **Use Caution**: Orange (#FF9800)
- **Rest Required**: Red (#F44336)
- **Recovery Mode**: Dark Red (#B71C1C)

### Component Integration
- Follow existing Material 3 theme in `/lib/core/theme/liquid_glass_theme.dart`
- Use existing `ScoreCard` widget pattern for health metrics
- Maintain consistency with current dashboard layout

## 🔧 Development Commands

### Build & Test
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter analyze --no-fatal-infos
flutter build web --debug
flutter test
```

### Database Regeneration (if schema changes needed)
```bash
flutter packages pub run build_runner clean
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## 📋 Implementation Checklist

### Dashboard Integration
- [ ] Create health context cards (steps, activity, sleep)
- [ ] Add PEM risk indicator with color coding
- [ ] Display current pacing state prominently
- [ ] Show energy envelope percentage
- [ ] Integrate with existing dashboard providers
- [ ] Test with sample data

### Pacing Recommendations
- [ ] Create recommendations widget
- [ ] Implement activity guidance display
- [ ] Add interactive feedback elements
- [ ] Create Riverpod providers for state management
- [ ] Test recommendation logic flow

### Background Services  
- [ ] Implement background health data sync
- [ ] Create automatic assessment generation
- [ ] Add data validation and quality checks
- [ ] Test sync reliability and error handling

### Testing & Polish
- [ ] Unit tests for UI components
- [ ] Integration tests for data flow
- [ ] User acceptance testing
- [ ] Performance optimization
- [ ] Error handling and edge cases

## 🚀 Success Criteria

When complete, the adaptive pacing system should:
1. **Automatically import** daily health data from device
2. **Generate daily assessments** combining HRV + lifestyle data
3. **Display clear recommendations** on dashboard
4. **Provide actionable guidance** for chronic illness management
5. **Warn users** before PEM risk becomes critical
6. **Track adherence** to pacing recommendations
7. **Improve over time** through user feedback and pattern recognition

## 💡 Next Session Start Commands

```bash
cd /Users/laurascullionhall/my_app/pulse_path/worktrees/adaptive_pacing
git status  # Check current state
flutter pub get  # Ensure dependencies
flutter analyze --no-fatal-infos  # Check for issues
```

Start with Priority 1 (Dashboard Integration) and work through the checklist systematically.