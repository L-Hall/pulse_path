import 'dart:math';
import '../../../../shared/models/adaptive_pacing_data.dart';
import '../../../../shared/models/daily_health_metrics.dart';
import '../../../../shared/models/hrv_reading.dart';
import '../../../settings/domain/models/user_preferences.dart';

/// Core service for adaptive pacing analysis and PEM risk assessment
class AdaptivePacingService {
  /// Generate adaptive pacing assessment for a specific date
  Future<AdaptivePacingAssessment> generateAssessment({
    required DateTime date,
    required UserPreferences userPreferences,
    HrvReading? todayHrv,
    DailyHealthMetrics? todayHealth,
    required List<HrvReading> recentHrvReadings,
    required List<DailyHealthMetrics> recentHealthMetrics,
    AdaptivePacingAssessment? yesterdayAssessment,
  }) async {
    // Calculate baseline and current HRV metrics
    final hrvContribution = _calculateHrvContribution(
      todayHrv,
      recentHrvReadings,
      userPreferences,
    );
    
    // Analyze activity load and patterns
    final activityContribution = _calculateActivityContribution(
      todayHealth,
      recentHealthMetrics,
      userPreferences,
    );
    
    // Assess sleep impact
    final sleepContribution = _calculateSleepContribution(
      todayHealth?.sleepData,
      recentHealthMetrics,
      userPreferences,
    );
    
    // Evaluate menstrual cycle impact (if applicable)
    final menstrualContribution = _calculateMenstrualContribution(
      todayHealth?.menstrualData,
      userPreferences,
    );
    
    // Create chronic condition profile
    final conditionProfile = _createConditionProfile(userPreferences);
    
    // Calculate overall PEM risk and energy envelope
    final pemRisk = _calculatePemRisk(
      hrvContribution,
      activityContribution,
      sleepContribution,
      menstrualContribution,
      conditionProfile,
      userPreferences,
    );
    
    final energyEnvelope = _calculateEnergyEnvelope(
      hrvContribution,
      activityContribution,
      sleepContribution,
      menstrualContribution,
      conditionProfile,
    );
    
    // Determine current pacing state
    final pacingState = _determinePacingState(
      pemRisk,
      energyEnvelope,
      hrvContribution,
      conditionProfile,
    );
    
    // Generate recommendations
    final recommendations = _generateRecommendations(
      pacingState,
      pemRisk,
      hrvContribution,
      activityContribution,
      sleepContribution,
      userPreferences,
    );
    
    // Create activity guidance
    final activityGuidance = _generateActivityGuidance(
      pacingState,
      pemRisk,
      energyEnvelope,
      activityContribution,
      conditionProfile,
    );
    
    // Analyze trends and warnings
    final trendWarnings = _analyzeTrends(
      recentHrvReadings,
      recentHealthMetrics,
      yesterdayAssessment,
    );
    
    final consecutiveHighRiskDays = _calculateConsecutiveHighRiskDays(
      yesterdayAssessment,
      pemRisk,
    );
    
    final sevenDayTrend = _calculateSevenDayEnergyTrend(recentHrvReadings);
    
    return AdaptivePacingAssessment(
      id: 'assessment_${date.millisecondsSinceEpoch}',
      date: date,
      currentState: pacingState,
      pemRisk: pemRisk,
      energyEnvelopePercentage: energyEnvelope,
      hrvContribution: hrvContribution,
      activityContribution: activityContribution,
      sleepContribution: sleepContribution,
      menstrualContribution: menstrualContribution,
      recommendations: recommendations,
      activityGuidance: activityGuidance,
      trendWarnings: trendWarnings,
      consecutiveHighRiskDays: consecutiveHighRiskDays,
      sevenDayEnergyTrend: sevenDayTrend,
      conditionProfile: conditionProfile,
      personalSensitivity: _calculatePersonalSensitivity(
        userPreferences,
        recentHrvReadings,
      ),
      createdAt: DateTime.now(),
    );
  }
  
  /// Calculate HRV contribution to pacing assessment
  HrvContribution _calculateHrvContribution(
    HrvReading? todayHrv,
    List<HrvReading> recentHrvReadings,
    UserPreferences userPreferences,
  ) {
    if (recentHrvReadings.isEmpty) {
      // No HRV data available - use neutral values
      return const HrvContribution(
        currentHrvScore: 50.0,
        sevenDayAverage: 50.0,
        personalBaseline: 50.0,
        percentageOfBaseline: 100.0,
        trend: TrendDirection.stable,
      );
    }
    
    // Calculate baseline from last 30 days (or available data)
    final thirtyDayReadings = recentHrvReadings.take(30).toList();
    final personalBaseline = thirtyDayReadings
        .map((r) => r.scores.recoveryScore)
        .reduce((a, b) => a + b) / thirtyDayReadings.length;
    
    // Calculate 7-day average
    final sevenDayReadings = recentHrvReadings.take(7).toList();
    final sevenDayAverage = sevenDayReadings.isNotEmpty
        ? sevenDayReadings
            .map((r) => r.scores.recoveryScore)
            .reduce((a, b) => a + b) / sevenDayReadings.length
        : personalBaseline;
    
    // Current HRV score
    final currentScore = todayHrv?.scores.recoveryScore ?? sevenDayAverage;
    
    // Calculate percentage of baseline
    final percentageOfBaseline = (currentScore / personalBaseline) * 100;
    
    // Determine trend
    final trend = _calculateHrvTrend(sevenDayReadings);
    
    return HrvContribution(
      currentHrvScore: currentScore,
      sevenDayAverage: sevenDayAverage,
      personalBaseline: personalBaseline,
      percentageOfBaseline: percentageOfBaseline,
      trend: trend,
    );
  }
  
  /// Calculate activity contribution to pacing assessment
  ActivityContribution _calculateActivityContribution(
    DailyHealthMetrics? todayHealth,
    List<DailyHealthMetrics> recentHealthMetrics,
    UserPreferences userPreferences,
  ) {
    final yesterdaySteps = recentHealthMetrics.isNotEmpty 
        ? recentHealthMetrics.first.stepCount 
        : 0;
    
    // Calculate 7-day average steps
    final sevenDayMetrics = recentHealthMetrics.take(7).toList();
    final sevenDayAverageSteps = sevenDayMetrics.isNotEmpty
        ? sevenDayMetrics
            .map((m) => m.stepCount)
            .reduce((a, b) => a + b) ~/ sevenDayMetrics.length
        : 0;
    
    // Get recent workouts from last 3 days
    final recentWorkouts = <WorkoutSession>[];
    for (final metrics in recentHealthMetrics.take(3)) {
      recentWorkouts.addAll(metrics.workouts);
    }
    
    // Calculate cumulative intensity score
    final intensityScore = _calculateCumulativeIntensityScore(
      recentWorkouts,
      userPreferences,
    );
    
    // Determine activity load level
    final loadLevel = _determineActivityLoadLevel(
      yesterdaySteps,
      sevenDayAverageSteps,
      intensityScore,
      userPreferences,
    );
    
    return ActivityContribution(
      yesterdaySteps: yesterdaySteps,
      sevenDayAverageSteps: sevenDayAverageSteps,
      recentWorkouts: recentWorkouts,
      cumulativeIntensityScore: intensityScore,
      loadLevel: loadLevel,
    );
  }
  
  /// Calculate sleep contribution to pacing assessment
  SleepContribution _calculateSleepContribution(
    SleepData? lastNightSleep,
    List<DailyHealthMetrics> recentHealthMetrics,
    UserPreferences userPreferences,
  ) {
    // Calculate 7-day average sleep
    final sevenDayMetrics = recentHealthMetrics.take(7).toList();
    final sleepDurations = sevenDayMetrics
        .where((m) => m.sleepData != null)
        .map((m) => m.sleepData!.totalSleepTime)
        .toList();
    
    final sevenDayAverageSleep = sleepDurations.isNotEmpty
        ? Duration(
            minutes: sleepDurations
                .map((d) => d.inMinutes)
                .reduce((a, b) => a + b) ~/ sleepDurations.length,
          )
        : const Duration(hours: 8);
    
    // Calculate sleep debt
    const targetSleep = Duration(hours: 8); // Could be personalized
    final sleepDebt = _calculateSleepDebt(
      lastNightSleep?.totalSleepTime,
      sevenDayAverageSleep,
      targetSleep,
    );
    
    return SleepContribution(
      lastNightSleep: lastNightSleep?.totalSleepTime,
      sleepQuality: lastNightSleep?.sleepQuality,
      sevenDayAverageSleep: sevenDayAverageSleep,
      sleepDebt: sleepDebt,
    );
  }
  
  /// Calculate menstrual contribution to pacing assessment
  MenstrualContribution? _calculateMenstrualContribution(
    MenstrualCycleData? menstrualData,
    UserPreferences userPreferences,
  ) {
    if (menstrualData == null || userPreferences.gender != UserGender.female) {
      return null;
    }
    
    final energyImpact = menstrualData.phase.typicalEnergyLevel;
    final totalSymptomImpact = menstrualData.symptoms
        .map((s) => s.activityImpact)
        .fold(0, (sum, impact) => sum + impact);
    
    return MenstrualContribution(
      currentPhase: menstrualData.phase,
      energyImpact: energyImpact,
      activeSymptoms: menstrualData.symptoms,
      totalSymptomImpact: totalSymptomImpact,
    );
  }
  
  /// Create chronic condition profile
  ChronicConditionProfile _createConditionProfile(UserPreferences userPreferences) {
    if (!userPreferences.hasChronicConditions) {
      return const ChronicConditionProfile();
    }
    
    // For now, create a default profile based on user settings
    // In a real implementation, this would be more sophisticated
    final pemSensitivity = _mapPemRiskLevelToSensitivity(
      userPreferences.pemRiskThreshold,
    );
    
    return ChronicConditionProfile(
      conditions: [ChronicCondition.other], // Would be configured by user
      pemSensitivity: pemSensitivity,
      recoveryTimeMultiplier: pemSensitivity,
      baselineEnergyLevel: userPreferences.restDayThresholdScore,
    );
  }
  
  /// Calculate overall PEM risk level
  PemRiskLevel _calculatePemRisk(
    HrvContribution hrvContribution,
    ActivityContribution activityContribution,
    SleepContribution sleepContribution,
    MenstrualContribution? menstrualContribution,
    ChronicConditionProfile conditionProfile,
    UserPreferences userPreferences,
  ) {
    double riskScore = 0.0;
    
    // HRV contribution (40% weight)
    final hrvRisk = _calculateHrvRiskScore(hrvContribution);
    riskScore += hrvRisk * 0.4;
    
    // Activity contribution (30% weight)
    final activityRisk = _calculateActivityRiskScore(activityContribution);
    riskScore += activityRisk * 0.3;
    
    // Sleep contribution (20% weight)
    final sleepRisk = _calculateSleepRiskScore(sleepContribution);
    riskScore += sleepRisk * 0.2;
    
    // Menstrual contribution (10% weight, if applicable)
    if (menstrualContribution != null) {
      final menstrualRisk = _calculateMenstrualRiskScore(menstrualContribution);
      riskScore += menstrualRisk * 0.1;
    }
    
    // Apply chronic condition sensitivity
    riskScore *= conditionProfile.pemSensitivity;
    
    // Map to PEM risk level
    if (riskScore >= 0.8) return PemRiskLevel.critical;
    if (riskScore >= 0.6) return PemRiskLevel.high;
    if (riskScore >= 0.4) return PemRiskLevel.moderate;
    return PemRiskLevel.low;
  }
  
  /// Calculate energy envelope percentage (0-100%)
  int _calculateEnergyEnvelope(
    HrvContribution hrvContribution,
    ActivityContribution activityContribution,
    SleepContribution sleepContribution,
    MenstrualContribution? menstrualContribution,
    ChronicConditionProfile conditionProfile,
  ) {
    double energyScore = 0.0;
    
    // HRV contribution
    energyScore += (hrvContribution.percentageOfBaseline / 100) * 0.4;
    
    // Activity contribution (inverse - higher activity = lower available energy)
    final activityFactor = _calculateActivityEnergyFactor(activityContribution);
    energyScore += activityFactor * 0.3;
    
    // Sleep contribution
    final sleepFactor = _calculateSleepEnergyFactor(sleepContribution);
    energyScore += sleepFactor * 0.2;
    
    // Menstrual contribution
    if (menstrualContribution != null) {
      final menstrualFactor = menstrualContribution.energyImpact / 10.0;
      energyScore += menstrualFactor * 0.1;
    }
    
    // Apply baseline energy level from condition profile
    energyScore *= (conditionProfile.baselineEnergyLevel / 100.0);
    
    return (energyScore * 100).round().clamp(0, 100);
  }
  
  /// Determine current pacing state
  PacingState _determinePacingState(
    PemRiskLevel pemRisk,
    int energyEnvelope,
    HrvContribution hrvContribution,
    ChronicConditionProfile conditionProfile,
  ) {
    PacingStateType stateType;
    String description;
    String reasoning;
    
    if (pemRisk == PemRiskLevel.critical || energyEnvelope < 20) {
      stateType = PacingStateType.recoveryMode;
      description = 'Recovery mode - complete rest needed';
      reasoning = 'Critical PEM risk detected. Focus entirely on rest and recovery.';
    } else if (pemRisk == PemRiskLevel.high || energyEnvelope < 40) {
      stateType = PacingStateType.restRequired;
      description = 'Rest day required';
      reasoning = 'High PEM risk. Avoid all non-essential activities.';
    } else if (pemRisk == PemRiskLevel.moderate || energyEnvelope < 60) {
      stateType = PacingStateType.caution;
      description = 'Proceed with caution';
      reasoning = 'Moderate PEM risk. Light activities only with frequent breaks.';
    } else if (energyEnvelope < 80) {
      stateType = PacingStateType.moderate;
      description = 'Moderate energy available';
      reasoning = 'Good energy levels. Normal activities with mindful pacing.';
    } else if (energyEnvelope >= 90 && hrvContribution.trend == TrendDirection.improving) {
      stateType = PacingStateType.excellent;
      description = 'Excellent energy levels';
      reasoning = 'Peak energy and improving trends. You can push slightly beyond usual limits.';
    } else {
      stateType = PacingStateType.good;
      description = 'Good energy levels';
      reasoning = 'Solid energy levels. Engage in normal activities with confidence.';
    }
    
    final overallScore = _calculateOverallScore(energyEnvelope, pemRisk);
    
    return PacingState(
      type: stateType,
      overallScore: overallScore,
      description: description,
      reasoning: reasoning,
    );
  }
  
  /// Generate pacing recommendations
  List<PacingRecommendation> _generateRecommendations(
    PacingState pacingState,
    PemRiskLevel pemRisk,
    HrvContribution hrvContribution,
    ActivityContribution activityContribution,
    SleepContribution sleepContribution,
    UserPreferences userPreferences,
  ) {
    final recommendations = <PacingRecommendation>[];
    
    // Primary pacing recommendation
    switch (pacingState.type) {
      case PacingStateType.recoveryMode:
      case PacingStateType.restRequired:
        recommendations.add(const PacingRecommendation(
          type: RecommendationType.rest,
          title: 'Complete Rest Day',
          description: 'Focus entirely on rest and recovery. Avoid all strenuous activities.',
          priority: PriorityLevel.critical,
          specificActions: [
            'Cancel non-essential activities',
            'Stay in bed or rest comfortably',
            'Practice gentle breathing exercises',
            'Ensure adequate hydration',
          ],
          reasoning: 'High PEM risk requires immediate rest to prevent symptom flare',
        ));
        break;
        
      case PacingStateType.caution:
        recommendations.add(const PacingRecommendation(
          type: RecommendationType.gentleActivity,
          title: 'Gentle Movement Only',
          description: 'Light activities with frequent breaks. Listen to your body carefully.',
          priority: PriorityLevel.high,
          specificActions: [
            'Limit activities to 20-30 minutes',
            'Take breaks every 10 minutes',
            'Avoid stairs when possible',
            'Consider postponing social activities',
          ],
          reasoning: 'Moderate PEM risk requires careful activity management',
        ));
        break;
        
      case PacingStateType.moderate:
        recommendations.add(const PacingRecommendation(
          type: RecommendationType.moderateActivity,
          title: 'Mindful Pacing',
          description: 'Normal activities with attention to pacing and energy conservation.',
          priority: PriorityLevel.medium,
          specificActions: [
            'Use the 50% rule - do half of what you think you can',
            'Plan rest periods between activities',
            'Monitor for early fatigue signs',
            'Prioritize essential tasks',
          ],
          reasoning: 'Good energy levels allow normal activities with mindful pacing',
        ));
        break;
        
      case PacingStateType.good:
      case PacingStateType.excellent:
        recommendations.add(const PacingRecommendation(
          type: RecommendationType.moderateActivity,
          title: 'Normal Activity',
          description: 'You can engage in your usual activities with confidence.',
          priority: PriorityLevel.low,
          specificActions: [
            'Maintain your regular routine',
            'Consider catching up on postponed tasks',
            'Still pace yourself to maintain energy',
            'Enjoy your improved capacity',
          ],
          reasoning: 'Excellent energy levels support normal activity engagement',
        ));
        break;
    }
    
    // Sleep recommendations
    if (sleepContribution.sleepDebt != SleepDebtLevel.wellRested) {
      recommendations.add(const PacingRecommendation(
        type: RecommendationType.sleepOptimization,
        title: 'Prioritize Sleep Recovery',
        description: 'Improve sleep quality to support better energy levels.',
        priority: PriorityLevel.high,
        specificActions: [
          'Aim for 8-9 hours of sleep tonight',
          'Create a calming bedtime routine',
          'Avoid screens 1 hour before bed',
          'Consider an afternoon rest if needed',
        ],
        reasoning: 'Sleep debt is impacting recovery capacity',
      ));
    }
    
    // Activity-specific recommendations
    if (activityContribution.loadLevel == ActivityLoadLevel.overload ||
        activityContribution.loadLevel == ActivityLoadLevel.veryHigh) {
      recommendations.add(const PacingRecommendation(
        type: RecommendationType.energyConservation,
        title: 'Reduce Activity Load',
        description: 'Your recent activity levels are high. Consider scaling back.',
        priority: PriorityLevel.high,
        specificActions: [
          'Postpone non-essential activities',
          'Delegate tasks where possible',
          'Choose easier alternatives to planned activities',
          'Focus on recovery activities',
        ],
        reasoning: 'High activity load increases PEM risk',
      ));
    }
    
    return recommendations;
  }
  
  /// Generate activity guidance
  ActivityGuidance _generateActivityGuidance(
    PacingState pacingState,
    PemRiskLevel pemRisk,
    int energyEnvelope,
    ActivityContribution activityContribution,
    ChronicConditionProfile conditionProfile,
  ) {
    ActivityRecommendation mainRecommendation;
    int? maxSteps;
    int? maxPerceivedExertion;
    List<WorkoutType> recommendedActivities = [];
    List<WorkoutType> activitiesToAvoid = [];
    
    switch (pacingState.type) {
      case PacingStateType.recoveryMode:
      case PacingStateType.restRequired:
        mainRecommendation = ActivityRecommendation.fullRest;
        maxSteps = 2000;
        maxPerceivedExertion = 3;
        recommendedActivities = [
          WorkoutType.breathingExercises,
          WorkoutType.meditation,
        ];
        activitiesToAvoid = [
          WorkoutType.running,
          WorkoutType.cycling,
          WorkoutType.strengthTraining,
          WorkoutType.swimming,
        ];
        break;
        
      case PacingStateType.caution:
        mainRecommendation = ActivityRecommendation.gentleMovement;
        maxSteps = 5000;
        maxPerceivedExertion = 4;
        recommendedActivities = [
          WorkoutType.stretching,
          WorkoutType.taiChi,
          WorkoutType.walking,
        ];
        activitiesToAvoid = [
          WorkoutType.running,
          WorkoutType.strengthTraining,
        ];
        break;
        
      case PacingStateType.moderate:
        mainRecommendation = ActivityRecommendation.lightActivity;
        maxSteps = 8000;
        maxPerceivedExertion = 6;
        recommendedActivities = [
          WorkoutType.walking,
          WorkoutType.yoga,
          WorkoutType.stretching,
          WorkoutType.householdActivities,
        ];
        activitiesToAvoid = [
          WorkoutType.running,
        ];
        break;
        
      case PacingStateType.good:
        mainRecommendation = ActivityRecommendation.moderateActivity;
        maxSteps = 12000;
        maxPerceivedExertion = 7;
        recommendedActivities = [
          WorkoutType.walking,
          WorkoutType.yoga,
          WorkoutType.cycling,
          WorkoutType.swimming,
          WorkoutType.strengthTraining,
        ];
        break;
        
      case PacingStateType.excellent:
        mainRecommendation = ActivityRecommendation.canPushSlightly;
        maxSteps = 15000;
        maxPerceivedExertion = 8;
        recommendedActivities = [
          WorkoutType.walking,
          WorkoutType.running,
          WorkoutType.cycling,
          WorkoutType.swimming,
          WorkoutType.strengthTraining,
          WorkoutType.yoga,
        ];
        break;
    }
    
    return ActivityGuidance(
      mainRecommendation: mainRecommendation,
      maxRecommendedSteps: maxSteps,
      maxRecommendedActivity: maxSteps != null 
          ? Duration(minutes: (maxSteps / 100).round()) 
          : null,
      recommendedActivities: recommendedActivities,
      activitiesToAvoid: activitiesToAvoid,
      maxPerceivedExertion: maxPerceivedExertion,
      specificGuidance: _generateSpecificGuidance(pacingState, energyEnvelope),
    );
  }
  
  // Helper methods for calculations
  
  TrendDirection _calculateHrvTrend(List<HrvReading> readings) {
    if (readings.length < 3) return TrendDirection.stable;
    
    final recent = readings.take(3).map((r) => r.scores.recoveryScore).toList();
    final older = readings.skip(3).take(3).map((r) => r.scores.recoveryScore).toList();
    
    if (older.isEmpty) return TrendDirection.stable;
    
    final recentAvg = recent.reduce((a, b) => a + b) / recent.length;
    final olderAvg = older.reduce((a, b) => a + b) / older.length;
    
    final change = recentAvg - olderAvg;
    
    if (change > 10) return TrendDirection.improving;
    if (change < -10) return TrendDirection.declining;
    if (change < -20) return TrendDirection.concerning;
    return TrendDirection.stable;
  }
  
  int _calculateCumulativeIntensityScore(
    List<WorkoutSession> workouts,
    UserPreferences userPreferences,
  ) {
    return workouts.fold<int>(0, (sum, workout) {
      final typeIntensity = workout.type.chronicIllnessIntensity;
      final duration = workout.duration.inMinutes;
      final perceivedExertion = workout.perceivedExertion ?? typeIntensity;
      
      // Simple intensity score: type * duration * exertion
      return sum + (typeIntensity * duration * perceivedExertion ~/ 100);
    });
  }
  
  ActivityLoadLevel _determineActivityLoadLevel(
    int yesterdaySteps,
    int sevenDayAverageSteps,
    int intensityScore,
    UserPreferences userPreferences,
  ) {
    final stepRatio = sevenDayAverageSteps > 0 
        ? yesterdaySteps / sevenDayAverageSteps 
        : 1.0;
    
    // Combine step ratio and intensity score
    if (stepRatio > 2.0 || intensityScore > 500) return ActivityLoadLevel.overload;
    if (stepRatio > 1.5 || intensityScore > 300) return ActivityLoadLevel.veryHigh;
    if (stepRatio > 1.2 || intensityScore > 200) return ActivityLoadLevel.high;
    if (stepRatio > 0.8 || intensityScore > 100) return ActivityLoadLevel.moderate;
    if (stepRatio > 0.5 || intensityScore > 50) return ActivityLoadLevel.low;
    return ActivityLoadLevel.veryLow;
  }
  
  SleepDebtLevel _calculateSleepDebt(
    Duration? lastNightSleep,
    Duration sevenDayAverage,
    Duration targetSleep,
  ) {
    final recentSleep = lastNightSleep ?? sevenDayAverage;
    final deficit = targetSleep.inMinutes - recentSleep.inMinutes;
    
    if (deficit <= 0) return SleepDebtLevel.wellRested;
    if (deficit <= 60) return SleepDebtLevel.slightDeficit;
    if (deficit <= 120) return SleepDebtLevel.moderateDeficit;
    if (deficit <= 180) return SleepDebtLevel.significantDeficit;
    return SleepDebtLevel.severeDeficit;
  }
  
  double _mapPemRiskLevelToSensitivity(PemRiskLevel level) {
    switch (level) {
      case PemRiskLevel.low:
        return 1.0;
      case PemRiskLevel.moderate:
        return 1.3;
      case PemRiskLevel.high:
        return 1.6;
      case PemRiskLevel.critical:
        return 2.0;
    }
  }
  
  double _calculateHrvRiskScore(HrvContribution contribution) {
    final percentageScore = contribution.percentageOfBaseline;
    
    if (percentageScore < 70) return 1.0; // High risk
    if (percentageScore < 80) return 0.7; // Moderate-high risk
    if (percentageScore < 90) return 0.4; // Moderate risk
    return 0.1; // Low risk
  }
  
  double _calculateActivityRiskScore(ActivityContribution contribution) {
    switch (contribution.loadLevel) {
      case ActivityLoadLevel.overload:
        return 1.0;
      case ActivityLoadLevel.veryHigh:
        return 0.8;
      case ActivityLoadLevel.high:
        return 0.6;
      case ActivityLoadLevel.moderate:
        return 0.3;
      case ActivityLoadLevel.low:
      case ActivityLoadLevel.veryLow:
        return 0.1;
    }
  }
  
  double _calculateSleepRiskScore(SleepContribution contribution) {
    switch (contribution.sleepDebt) {
      case SleepDebtLevel.severeDeficit:
        return 1.0;
      case SleepDebtLevel.significantDeficit:
        return 0.7;
      case SleepDebtLevel.moderateDeficit:
        return 0.4;
      case SleepDebtLevel.slightDeficit:
        return 0.2;
      case SleepDebtLevel.wellRested:
        return 0.0;
    }
  }
  
  double _calculateMenstrualRiskScore(MenstrualContribution contribution) {
    final symptomImpact = contribution.totalSymptomImpact / 20.0; // Normalize
    final energyImpact = (10 - contribution.energyImpact) / 10.0; // Lower energy = higher risk
    
    return ((symptomImpact + energyImpact) / 2).clamp(0.0, 1.0);
  }
  
  double _calculateActivityEnergyFactor(ActivityContribution contribution) {
    switch (contribution.loadLevel) {
      case ActivityLoadLevel.veryLow:
        return 1.0;
      case ActivityLoadLevel.low:
        return 0.9;
      case ActivityLoadLevel.moderate:
        return 0.7;
      case ActivityLoadLevel.high:
        return 0.5;
      case ActivityLoadLevel.veryHigh:
        return 0.3;
      case ActivityLoadLevel.overload:
        return 0.1;
    }
  }
  
  double _calculateSleepEnergyFactor(SleepContribution contribution) {
    switch (contribution.sleepDebt) {
      case SleepDebtLevel.wellRested:
        return 1.0;
      case SleepDebtLevel.slightDeficit:
        return 0.9;
      case SleepDebtLevel.moderateDeficit:
        return 0.7;
      case SleepDebtLevel.significantDeficit:
        return 0.5;
      case SleepDebtLevel.severeDeficit:
        return 0.3;
    }
  }
  
  int _calculateOverallScore(int energyEnvelope, PemRiskLevel pemRisk) {
    final baseScore = energyEnvelope;
    final riskPenalty = switch (pemRisk) {
      PemRiskLevel.critical => 40,
      PemRiskLevel.high => 25,
      PemRiskLevel.moderate => 15,
      PemRiskLevel.low => 0,
    };
    
    return (baseScore - riskPenalty).clamp(0, 100);
  }
  
  List<String> _analyzeTrends(
    List<HrvReading> recentHrvReadings,
    List<DailyHealthMetrics> recentHealthMetrics,
    AdaptivePacingAssessment? yesterdayAssessment,
  ) {
    final warnings = <String>[];
    
    // Check for declining HRV trend
    if (recentHrvReadings.length >= 7) {
      final trend = _calculateHrvTrend(recentHrvReadings);
      if (trend == TrendDirection.concerning) {
        warnings.add('HRV showing concerning downward trend');
      } else if (trend == TrendDirection.declining) {
        warnings.add('HRV trending downward - consider reducing activity');
      }
    }
    
    // Check for consecutive high activity days
    final highActivityDays = recentHealthMetrics.take(3)
        .where((m) => m.stepCount > 10000 || m.workouts.isNotEmpty)
        .length;
    
    if (highActivityDays >= 3) {
      warnings.add('Three consecutive high activity days detected');
    }
    
    // Check for poor sleep trend
    final poorSleepDays = recentHealthMetrics.take(3)
        .where((m) => m.sleepData != null && 
               m.sleepData!.totalSleepTime.inHours < 7)
        .length;
    
    if (poorSleepDays >= 2) {
      warnings.add('Poor sleep pattern detected');
    }
    
    return warnings;
  }
  
  int _calculateConsecutiveHighRiskDays(
    AdaptivePacingAssessment? yesterdayAssessment,
    PemRiskLevel todayPemRisk,
  ) {
    if (yesterdayAssessment == null) return 0;
    
    if (todayPemRisk == PemRiskLevel.high || todayPemRisk == PemRiskLevel.critical) {
      if (yesterdayAssessment.pemRisk == PemRiskLevel.high || 
          yesterdayAssessment.pemRisk == PemRiskLevel.critical) {
        return yesterdayAssessment.consecutiveHighRiskDays + 1;
      } else {
        return 1;
      }
    }
    
    return 0;
  }
  
  double _calculateSevenDayEnergyTrend(List<HrvReading> readings) {
    if (readings.length < 7) return 0.0;
    
    final recent3 = readings.take(3).map((r) => r.scores.recoveryScore).toList();
    final older3 = readings.skip(4).take(3).map((r) => r.scores.recoveryScore).toList();
    
    if (older3.isEmpty) return 0.0;
    
    final recentAvg = recent3.reduce((a, b) => a + b) / recent3.length;
    final olderAvg = older3.reduce((a, b) => a + b) / older3.length;
    
    // Return normalized trend (-1.0 to 1.0)
    return ((recentAvg - olderAvg) / 50.0).clamp(-1.0, 1.0);
  }
  
  double _calculatePersonalSensitivity(
    UserPreferences userPreferences,
    List<HrvReading> recentReadings,
  ) {
    // Start with user-defined sensitivity
    double sensitivity = _mapPemRiskLevelToSensitivity(
      userPreferences.pemRiskThreshold,
    );
    
    // Adjust based on HRV variability
    if (recentReadings.length >= 7) {
      final scores = recentReadings.take(7)
          .map((r) => r.scores.recoveryScore)
          .toList();
      
      final mean = scores.reduce((a, b) => a + b) / scores.length;
      final variance = scores
          .map((score) => pow(score - mean, 2))
          .reduce((a, b) => a + b) / scores.length;
      
      // High variability suggests higher sensitivity
      if (variance > 400) { // High variability
        sensitivity *= 1.2;
      } else if (variance < 100) { // Low variability
        sensitivity *= 0.9;
      }
    }
    
    return sensitivity.clamp(0.5, 2.0);
  }
  
  List<String> _generateSpecificGuidance(PacingState pacingState, int energyEnvelope) {
    final guidance = <String>[];
    
    switch (pacingState.type) {
      case PacingStateType.recoveryMode:
        guidance.addAll([
          'Complete bed rest is recommended',
          'Postpone all non-essential activities',
          'Focus on gentle breathing and relaxation',
          'Consider medical consultation if symptoms worsen',
        ]);
        break;
        
      case PacingStateType.restRequired:
        guidance.addAll([
          'Limit activities to essential tasks only',
          'Take frequent breaks between activities',
          'Avoid stairs and carrying heavy items',
          'Consider grocery delivery or meal prep help',
        ]);
        break;
        
      case PacingStateType.caution:
        guidance.addAll([
          'Use the 50% rule - do half of what you think you can',
          'Break activities into smaller chunks',
          'Sit down while doing tasks when possible',
          'Monitor for early fatigue signs',
        ]);
        break;
        
      case PacingStateType.moderate:
        guidance.addAll([
          'Pace activities throughout the day',
          'Take a 15-minute break every hour',
          'Prioritize important tasks',
          'Listen to your body and adjust as needed',
        ]);
        break;
        
      case PacingStateType.good:
        guidance.addAll([
          'You can engage in normal activities',
          'Consider catching up on postponed tasks',
          'Still practice good pacing habits',
          'Enjoy your improved energy levels',
        ]);
        break;
        
      case PacingStateType.excellent:
        guidance.addAll([
          'Excellent energy levels detected',
          'You can push slightly beyond usual limits',
          'Consider tackling challenging projects',
          'Maintain awareness to avoid overdoing it',
        ]);
        break;
    }
    
    return guidance;
  }
}