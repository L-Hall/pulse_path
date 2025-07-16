import 'dart:math';
import '../../../../shared/models/hrv_reading.dart';
import 'hrv_baseline_service.dart';

class HrvScoringService {
  HrvScoringService._();
  
  static final HrvScoringService _instance = HrvScoringService._();
  factory HrvScoringService() => _instance;

  /// Calculate stress score from RMSSD (Welltory-style)
  /// For compatibility with performance tests
  Future<int> calculateStressScore({
    required double rmssd,
    required int age,
    String? gender,
    HrvBaseline? baseline,
  }) async {
    // Create minimal metrics object for stress calculation
    final metrics = HrvMetrics(
      rmssd: rmssd,
      meanRr: 800.0, // Default value
      sdnn: 50.0, // Default value
      lowFrequency: 100.0, // Default value
      highFrequency: 100.0, // Default value
      lfHfRatio: 1.0, // Default value
      baevsky: 100.0, // Default value
      coefficientOfVariance: 5.0, // Default value
      mxdmn: 200.0, // Default value
      moda: 800.0, // Default value
      amo50: 30.0, // Default value
      pnn50: 20.0, // Default value
      pnn20: 40.0, // Default value
      totalPower: 1000.0, // Default value
      dfaAlpha1: 1.0, // Default value
    );
    return _calculateStressScoreWithBaseline(metrics, age, gender, baseline);
  }

  /// Calculate recovery score from RMSSD
  /// For compatibility with performance tests
  Future<int> calculateRecoveryScore({
    required double rmssd,
    required int age,
    String? gender,
  }) async {
    // Create minimal metrics object for recovery calculation
    final metrics = HrvMetrics(
      rmssd: rmssd,
      meanRr: 800.0, // Default value
      sdnn: 50.0, // Default value
      lowFrequency: 100.0, // Default value
      highFrequency: 100.0, // Default value
      lfHfRatio: 1.0, // Default value
      baevsky: 100.0, // Default value
      coefficientOfVariance: 5.0, // Default value
      mxdmn: 200.0, // Default value
      moda: 800.0, // Default value
      amo50: 30.0, // Default value
      pnn50: 20.0, // Default value
      pnn20: 40.0, // Default value
      totalPower: 1000.0, // Default value
      dfaAlpha1: 1.0, // Default value
    );
    return _calculateRecoveryScore(metrics, age, gender);
  }

  /// Calculate energy score from RMSSD and mean RR
  /// For compatibility with performance tests
  Future<int> calculateEnergyScore({
    required double rmssd,
    required double meanRr,
    required int age,
    String? fitnessLevel,
  }) async {
    // Create minimal metrics object for energy calculation
    final metrics = HrvMetrics(
      rmssd: rmssd,
      meanRr: meanRr,
      sdnn: 50.0, // Default value
      lowFrequency: 100.0, // Default value
      highFrequency: 100.0, // Default value
      lfHfRatio: 1.0, // Default value
      baevsky: 100.0, // Default value
      coefficientOfVariance: 5.0, // Default value
      mxdmn: 200.0, // Default value
      moda: 800.0, // Default value
      amo50: 30.0, // Default value
      pnn50: 20.0, // Default value
      pnn20: 40.0, // Default value
      totalPower: 1000.0, // Default value
      dfaAlpha1: 1.0, // Default value
    );
    return _calculateEnergyScore(metrics, age, null); // Ignore fitness level for now
  }

  /// Calculate comprehensive scores from HRV metrics (Welltory-style)
  /// Age is optional for normalization (default: 30)
  /// Gender: 'male', 'female', or null for general population
  /// Baseline: Personal baseline for accurate assessment
  Future<HrvScores> calculateScores(
    HrvMetrics metrics, {
    int? age,
    String? gender,
    HrvBaseline? baseline,
    double? sleepScore,
    double? ambientHeartRate,
  }) async {
    final normalizedAge = age ?? 30;
    
    // Get baseline if not provided
    final personalBaseline = baseline ?? await HrvBaselineService().getSevenDayBaseline(
      age: normalizedAge,
      gender: gender,
    );
    
    // Calculate individual scores with baseline awareness
    final stress = _calculateStressScoreWithBaseline(metrics, normalizedAge, gender, personalBaseline);
    final recovery = _calculateRecoveryScoreWithBaseline(metrics, normalizedAge, gender, personalBaseline);
    final energy = await _calculateEnergyBatteryScore(
      metrics,
      personalBaseline,
      sleepScore: sleepScore ?? 70.0,
      ambientHeartRate: ambientHeartRate,
      age: normalizedAge,
      gender: gender,
    );
    final health = _calculateHealthScore(metrics, normalizedAge, gender);
    final focus = _calculateFocusScore(metrics, stress, personalBaseline);
    final confidence = _calculateConfidenceScore(metrics);
    
    return HrvScores(
      stress: stress.clamp(0, 100),
      recovery: recovery.clamp(0, 100),
      energy: energy.clamp(0, 100),
      confidence: confidence.clamp(0.0, 1.0),
      health: health.clamp(0, 100),
      focus: focus.clamp(0, 100),
    );
  }

  /// Calculate stress score with baseline comparison (Welltory-style)
  int _calculateStressScoreWithBaseline(
    HrvMetrics metrics,
    int age,
    String? gender,
    HrvBaseline? baseline,
  ) {
    // If no baseline, fall back to age-adjusted calculation
    if (baseline == null || !baseline.hasEnoughData) {
      return _calculateStressScore(metrics, age, gender);
    }
    
    // Welltory-style stress calculation
    final stressRaw = (1 - (metrics.rmssd / baseline.rmssdMedian)).clamp(0.0, 1.0);
    final stressScore = (stressRaw * 100).round();
    
    // Adjust with other factors
    final lfHfComponent = _calculateLfHfStressComponent(metrics.lfHfRatio);
    final baevskComponent = _calculateBaevskStressComponent(metrics.baevsky);
    
    // Weighted combination
    final combinedScore = (stressScore * 0.5 + 
                          lfHfComponent * 0.3 + 
                          baevskComponent * 0.2).round();
    
    return combinedScore.clamp(0, 100);
  }
  
  /// Helper method for LF/HF stress component
  double _calculateLfHfStressComponent(double lfHfRatio) {
    if (lfHfRatio <= 1.0) return 20;
    if (lfHfRatio <= 2.0) return 20 + (lfHfRatio - 1.0) * 20;
    if (lfHfRatio <= 4.0) return 40 + (lfHfRatio - 2.0) * 25;
    return 90;
  }
  
  /// Helper method for Baevsky stress component  
  double _calculateBaevskStressComponent(double baevsky) {
    if (baevsky <= 50) return 10;
    if (baevsky <= 150) return 10 + (baevsky - 50) * 0.3;
    if (baevsky <= 300) return 40 + (baevsky - 150) * 0.33;
    return 90;
  }

  /// Calculate stress score (0-100, higher = more stressed)
  /// Based on sympathetic nervous system indicators
  int _calculateStressScore(HrvMetrics metrics, int age, String? gender) {
    // Primary indicators of stress
    final lfHfRatio = metrics.lfHfRatio;
    final baevsky = metrics.baevsky;
    final rmssd = metrics.rmssd;
    final meanRr = metrics.meanRr;
    
    // Age-adjusted normalization values
    final ageNormalizedRmssd = _getAgeNormalizedRmssd(age, gender);
    final ageNormalizedMeanRr = _getAgeNormalizedMeanRr(age, gender);
    
    // Score components (0-100)
    double stressScore = 0.0;
    
    // LF/HF ratio component (40% weight)
    // Normal range: 0.5-2.0, stress increases above 2.5
    double lfHfComponent = 0.0;
    if (lfHfRatio <= 1.0) {
      lfHfComponent = 20; // Low stress
    } else if (lfHfRatio <= 2.0) {
      lfHfComponent = 20 + (lfHfRatio - 1.0) * 20; // Moderate
    } else if (lfHfRatio <= 4.0) {
      lfHfComponent = 40 + (lfHfRatio - 2.0) * 25; // High stress
    } else {
      lfHfComponent = 90; // Very high stress
    }
    stressScore += lfHfComponent * 0.4;
    
    // Baevsky Stress Index component (25% weight)
    // Normal range: 50-150, stress increases above 200
    double baevskComponent = 0.0;
    if (baevsky <= 50) {
      baevskComponent = 10;
    } else if (baevsky <= 150) {
      baevskComponent = 10 + (baevsky - 50) * 0.3;
    } else if (baevsky <= 300) {
      baevskComponent = 40 + (baevsky - 150) * 0.33;
    } else {
      baevskComponent = 90;
    }
    stressScore += baevskComponent * 0.25;
    
    // RMSSD component (20% weight) - inverse relationship
    // Lower RMSSD indicates higher stress
    final rmssdRatio = rmssd / ageNormalizedRmssd;
    double rmssdComponent = 0.0;
    if (rmssdRatio >= 1.0) {
      rmssdComponent = 10; // Low stress
    } else if (rmssdRatio >= 0.7) {
      rmssdComponent = 10 + (1.0 - rmssdRatio) * 100;
    } else {
      rmssdComponent = 80; // High stress
    }
    stressScore += rmssdComponent * 0.2;
    
    // Mean RR component (15% weight)
    // Lower heart rate variability indicates stress
    final meanRrRatio = meanRr / ageNormalizedMeanRr;
    double meanRrComponent = 0.0;
    if (meanRrRatio >= 1.0) {
      meanRrComponent = 20;
    } else {
      meanRrComponent = 20 + (1.0 - meanRrRatio) * 60;
    }
    stressScore += meanRrComponent * 0.15;
    
    return stressScore.round();
  }

  /// Calculate recovery score with baseline comparison
  int _calculateRecoveryScoreWithBaseline(
    HrvMetrics metrics,
    int age,
    String? gender,
    HrvBaseline? baseline,
  ) {
    // If no baseline, fall back to age-adjusted calculation
    if (baseline == null || !baseline.hasEnoughData) {
      return _calculateRecoveryScore(metrics, age, gender);
    }
    
    // Compare to personal baseline
    final rmssdRatio = metrics.rmssd / baseline.rmssdMedian;
    final hfRatio = metrics.highFrequency / baseline.highFrequencyMedian;
    final pnn50Ratio = metrics.pnn50 / baseline.pnn50Median;
    
    // Calculate recovery components
    double recoveryScore = 0.0;
    
    // RMSSD component (50% weight)
    if (rmssdRatio >= 1.2) {
      recoveryScore += 45; // Excellent recovery
    } else if (rmssdRatio >= 1.0) {
      recoveryScore += 35 + (rmssdRatio - 1.0) * 50;
    } else if (rmssdRatio >= 0.8) {
      recoveryScore += 25 + (rmssdRatio - 0.8) * 50;
    } else {
      recoveryScore += max(5, rmssdRatio * 31.25);
    }
    
    // HF component (30% weight)
    if (hfRatio >= 1.1) {
      recoveryScore += 27;
    } else if (hfRatio >= 0.9) {
      recoveryScore += 18 + (hfRatio - 0.9) * 45;
    } else {
      recoveryScore += max(3, hfRatio * 20);
    }
    
    // pNN50 component (20% weight)
    if (pnn50Ratio >= 1.0) {
      recoveryScore += 16 + min(4, (pnn50Ratio - 1.0) * 8);
    } else {
      recoveryScore += max(2, pnn50Ratio * 16);
    }
    
    return recoveryScore.round().clamp(0, 100);
  }

  /// Calculate recovery score (0-100, higher = better recovery)
  /// Based on parasympathetic nervous system indicators
  int _calculateRecoveryScore(HrvMetrics metrics, int age, String? gender) {
    final rmssd = metrics.rmssd;
    final hf = metrics.highFrequency;
    final pnn50 = metrics.pnn50;
    final sdnn = metrics.sdnn;
    
    // Age-adjusted normalization
    final ageNormalizedRmssd = _getAgeNormalizedRmssd(age, gender);
    final ageNormalizedSdnn = _getAgeNormalizedSdnn(age, gender);
    
    double recoveryScore = 0.0;
    
    // RMSSD component (40% weight) - primary recovery indicator
    final rmssdRatio = rmssd / ageNormalizedRmssd;
    double rmssdComponent = 0.0;
    if (rmssdRatio >= 1.2) {
      rmssdComponent = 90; // Excellent recovery
    } else if (rmssdRatio >= 1.0) {
      rmssdComponent = 70 + (rmssdRatio - 1.0) * 100;
    } else if (rmssdRatio >= 0.8) {
      rmssdComponent = 50 + (rmssdRatio - 0.8) * 100;
    } else {
      rmssdComponent = max(10, rmssdRatio * 62.5);
    }
    recoveryScore += rmssdComponent * 0.4;
    
    // High Frequency component (25% weight)
    // Higher HF indicates better parasympathetic activity
    double hfComponent = 0.0;
    if (hf >= 500) {
      hfComponent = 90;
    } else if (hf >= 200) {
      hfComponent = 60 + (hf - 200) * 0.1;
    } else if (hf >= 50) {
      hfComponent = 30 + (hf - 50) * 0.2;
    } else {
      hfComponent = max(10, hf * 0.6);
    }
    recoveryScore += hfComponent * 0.25;
    
    // pNN50 component (20% weight)
    double pnn50Component = 0.0;
    if (pnn50 >= 20) {
      pnn50Component = 80 + min(20, (pnn50 - 20) * 0.5);
    } else if (pnn50 >= 10) {
      pnn50Component = 50 + (pnn50 - 10) * 3;
    } else {
      pnn50Component = max(10, pnn50 * 5);
    }
    recoveryScore += pnn50Component * 0.2;
    
    // SDNN component (15% weight)
    final sdnnRatio = sdnn / ageNormalizedSdnn;
    double sdnnComponent = 0.0;
    if (sdnnRatio >= 1.0) {
      sdnnComponent = 70 + min(30, (sdnnRatio - 1.0) * 60);
    } else {
      sdnnComponent = max(20, sdnnRatio * 70);
    }
    recoveryScore += sdnnComponent * 0.15;
    
    return recoveryScore.round();
  }

  /// Calculate energy score (0-100, higher = more energy)
  /// Based on overall autonomic balance and variability
  int _calculateEnergyScore(HrvMetrics metrics, int age, String? gender) {
    final totalPower = metrics.totalPower;
    final sdnn = metrics.sdnn;
    final meanRr = metrics.meanRr;
    final lfHfRatio = metrics.lfHfRatio;
    
    // Age adjustments
    final ageNormalizedSdnn = _getAgeNormalizedSdnn(age, gender);
    final ageNormalizedMeanRr = _getAgeNormalizedMeanRr(age, gender);
    
    double energyScore = 0.0;
    
    // Total Power component (35% weight) - overall autonomic activity
    double totalPowerComponent = 0.0;
    if (totalPower >= 2000) {
      totalPowerComponent = 90;
    } else if (totalPower >= 1000) {
      totalPowerComponent = 60 + (totalPower - 1000) * 0.03;
    } else if (totalPower >= 300) {
      totalPowerComponent = 30 + (totalPower - 300) * 0.043;
    } else {
      totalPowerComponent = max(10, totalPower * 0.1);
    }
    energyScore += totalPowerComponent * 0.35;
    
    // SDNN component (25% weight) - overall variability
    final sdnnRatio = sdnn / ageNormalizedSdnn;
    double sdnnComponent = 0.0;
    if (sdnnRatio >= 1.0) {
      sdnnComponent = 70 + min(30, (sdnnRatio - 1.0) * 60);
    } else {
      sdnnComponent = max(20, sdnnRatio * 70);
    }
    energyScore += sdnnComponent * 0.25;
    
    // Mean RR component (20% weight) - cardiovascular efficiency
    final meanRrRatio = meanRr / ageNormalizedMeanRr;
    double meanRrComponent = 0.0;
    if (meanRrRatio >= 1.0) {
      meanRrComponent = 70 + min(30, (meanRrRatio - 1.0) * 50);
    } else {
      meanRrComponent = max(30, meanRrRatio * 70);
    }
    energyScore += meanRrComponent * 0.2;
    
    // LF/HF Balance component (20% weight) - autonomic balance
    double balanceComponent = 0.0;
    if (lfHfRatio >= 0.5 && lfHfRatio <= 2.0) {
      // Optimal balance range
      balanceComponent = 80 + (1.0 - (lfHfRatio - 1.25).abs() / 0.75) * 20;
    } else if (lfHfRatio < 0.5) {
      // Too parasympathetic dominant
      balanceComponent = 40 + lfHfRatio * 80;
    } else {
      // Too sympathetic dominant
      balanceComponent = max(20, 80 - (lfHfRatio - 2.0) * 15);
    }
    energyScore += balanceComponent * 0.2;
    
    return energyScore.round();
  }

  /// Calculate confidence score based on data quality indicators
  double _calculateConfidenceScore(HrvMetrics metrics) {
    double confidence = 1.0;
    
    // Check for physiologically impossible values
    if (metrics.rmssd < 5 || metrics.rmssd > 200) {
      confidence *= 0.7;
    }
    
    if (metrics.meanRr < 400 || metrics.meanRr > 1500) {
      confidence *= 0.8;
    }
    
    if (metrics.sdnn < 10 || metrics.sdnn > 300) {
      confidence *= 0.8;
    }
    
    // Check for extreme frequency domain values
    if (metrics.lfHfRatio > 10 || metrics.lfHfRatio < 0.1) {
      confidence *= 0.7;
    }
    
    if (metrics.totalPower < 100 || metrics.totalPower > 50000) {
      confidence *= 0.8;
    }
    
    // Check for geometric measure consistency
    if (metrics.baevsky < 10 || metrics.baevsky > 1000) {
      confidence *= 0.9;
    }
    
    // DFA alpha1 should be between 0.5 and 2.0 for healthy individuals
    if (metrics.dfaAlpha1 < 0.3 || metrics.dfaAlpha1 > 2.5) {
      confidence *= 0.8;
    }
    
    return confidence;
  }

  /// Get age-normalized RMSSD values (ms)
  /// Based on published normative data
  double _getAgeNormalizedRmssd(int age, String? gender) {
    // Base values for 30-year-old
    double baseRmssd = gender == 'female' ? 32.0 : 28.0;
    
    // Age adjustment: RMSSD decreases ~0.7ms per year after 25
    if (age > 25) {
      baseRmssd -= (age - 25) * 0.7;
    }
    
    return max(15.0, baseRmssd);
  }

  /// Get age-normalized SDNN values (ms)
  double _getAgeNormalizedSdnn(int age, String? gender) {
    double baseSdnn = gender == 'female' ? 45.0 : 42.0;
    
    // Age adjustment: SDNN decreases ~1.0ms per year after 25
    if (age > 25) {
      baseSdnn -= (age - 25) * 1.0;
    }
    
    return max(25.0, baseSdnn);
  }

  /// Get age-normalized Mean RR values (ms)
  double _getAgeNormalizedMeanRr(int age, String? gender) {
    // Resting heart rate increases slightly with age
    double baseRr = gender == 'female' ? 900.0 : 950.0; // ~67-63 bpm
    
    // Slight decrease in RR (increase in HR) with age
    if (age > 25) {
      baseRr -= (age - 25) * 2.0;
    }
    
    return max(600.0, baseRr);
  }
  
  /// Calculate Energy/Battery score (Welltory-style)
  /// Combines sleep, HRV, and ambient heart rate
  Future<int> _calculateEnergyBatteryScore(
    HrvMetrics metrics,
    HrvBaseline baseline,
    {
      required double sleepScore,
      double? ambientHeartRate,
      int? age,
      String? gender,
    }
  ) async {
    // Sleep factor (0-1)
    final sleepFactor = sleepScore / 100.0;
    
    // HRV factor based on baseline comparison
    double hrvFactor = 1.0;
    if (baseline.hasEnoughData) {
      hrvFactor = metrics.rmssd / baseline.rmssdMedian;
    } else {
      // Fall back to age-normalized comparison
      final normalizedRmssd = _getAgeNormalizedRmssd(age ?? 30, gender);
      hrvFactor = metrics.rmssd / normalizedRmssd;
    }
    
    // Ambient HR factor (if available)
    double hrFactor = 0.0;
    if (ambientHeartRate != null) {
      final hrBaseline = baseline.hasEnoughData 
          ? (60000 / baseline.meanRrMedian) // Convert RR to HR
          : _getAgeNormalizedHeartRate(age ?? 30, gender);
      hrFactor = (hrBaseline - ambientHeartRate) / hrBaseline;
    }
    
    // Welltory-style energy calculation
    final rawEnergy = 0.5 * sleepFactor + 
                      0.3 * hrvFactor + 
                      0.2 * hrFactor.clamp(0, 1);
    
    // Apply sigmoid transformation for smoother distribution
    final battery = _sigmoid(rawEnergy) * 100;
    
    return battery.round().clamp(0, 100);
  }
  
  /// Calculate Health/Resilience score
  /// Maps RMSSD to 0-100 using logistic function
  int _calculateHealthScore(HrvMetrics metrics, int age, String? gender) {
    // Use natural log of RMSSD for better distribution
    final lnRmssd = log(metrics.rmssd);
    
    // Normal range: 20-120ms (ln: 3.0-4.8)
    const lnLower = 3.0; // ln(20)
    const lnUpper = 4.8; // ln(120)
    
    // Logistic mapping
    final normalized = (lnRmssd - lnLower) / (lnUpper - lnLower);
    final health = _logistic(normalized) * 100;
    
    return health.round().clamp(0, 100);
  }
  
  /// Calculate Focus score
  /// Combines parasympathetic activity and stress levels
  int _calculateFocusScore(
    HrvMetrics metrics,
    int stressScore,
    HrvBaseline baseline,
  ) {
    // Parasympathetic activity indicator
    double parasympActivity = 0.0;
    if (baseline.hasEnoughData) {
      parasympActivity = (metrics.highFrequency / baseline.highFrequencyMedian).clamp(0, 2);
    } else {
      // Normalize HF power
      parasympActivity = (metrics.highFrequency / 200.0).clamp(0, 2);
    }
    
    // Convert stress to 0-1 scale (inverted)
    final stressRaw = 1 - (stressScore / 100.0);
    
    // Focus calculation
    final focus = (0.6 * parasympActivity + 0.4 * stressRaw).clamp(0, 1) * 100;
    
    return focus.round().clamp(0, 100);
  }
  
  /// Sigmoid function for smooth transitions
  double _sigmoid(double x) {
    return 1 / (1 + exp(-12 * (x - 0.5)));
  }
  
  /// Logistic function for mapping values
  double _logistic(double x) {
    if (x <= 0) return 0;
    if (x >= 1) return 1;
    return 1 / (1 + exp(-6 * (x - 0.5)));
  }
  
  /// Get age-normalized heart rate
  double _getAgeNormalizedHeartRate(int age, String? gender) {
    // Resting HR increases slightly with age
    double baseHr = gender == 'female' ? 67.0 : 63.0;
    
    if (age > 25) {
      baseHr += (age - 25) * 0.15;
    }
    
    return baseHr;
  }
}