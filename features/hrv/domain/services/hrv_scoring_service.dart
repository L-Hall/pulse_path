import 'dart:math';
import '../../../../shared/models/hrv_reading.dart';

class HrvScoringService {
  HrvScoringService._();
  
  static final HrvScoringService _instance = HrvScoringService._();
  factory HrvScoringService() => _instance;

  /// Calculate comprehensive scores from HRV metrics
  /// Age is optional for normalization (default: 30)
  /// Gender: 'male', 'female', or null for general population
  HrvScores calculateScores(
    HrvMetrics metrics, {
    int? age,
    String? gender,
  }) {
    final normalizedAge = age ?? 30;
    
    // Calculate individual scores
    final stress = _calculateStressScore(metrics, normalizedAge, gender);
    final recovery = _calculateRecoveryScore(metrics, normalizedAge, gender);
    final energy = _calculateEnergyScore(metrics, normalizedAge, gender);
    final confidence = _calculateConfidenceScore(metrics);
    
    return HrvScores(
      stress: stress.clamp(0, 100),
      recovery: recovery.clamp(0, 100),
      energy: energy.clamp(0, 100),
      confidence: confidence.clamp(0.0, 1.0),
    );
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
}