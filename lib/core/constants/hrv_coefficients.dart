/// HRV Scoring Coefficients Configuration
/// 
/// This file contains all coefficients used in HRV score calculations.
/// Based on Welltory's approach with scientific rationale documented.
/// 
/// These values can be fine-tuned without recompilation by adjusting
/// the constants below.
class HrvCoefficients {
  HrvCoefficients._();

  // ===== Stress Score Coefficients =====
  
  /// Weight for RMSSD comparison in stress calculation (Welltory-style)
  static const double stressRmssdWeight = 0.5;
  
  /// Weight for LF/HF ratio in stress calculation
  static const double stressLfHfWeight = 0.3;
  
  /// Weight for Baevsky index in stress calculation
  static const double stressBaevskyWeight = 0.2;
  
  /// LF/HF ratio thresholds for stress
  static const double lfHfLowStress = 1.0;
  static const double lfHfModerateStress = 2.0;
  static const double lfHfHighStress = 4.0;
  
  /// Baevsky index thresholds for stress
  static const double baevskyLowStress = 50;
  static const double baevskyModerateStress = 150;
  static const double baevskyHighStress = 300;

  // ===== Recovery Score Coefficients =====
  
  /// Weight for RMSSD in recovery calculation
  static const double recoveryRmssdWeight = 0.5;
  
  /// Weight for HF power in recovery calculation
  static const double recoveryHfWeight = 0.3;
  
  /// Weight for pNN50 in recovery calculation
  static const double recoveryPnn50Weight = 0.2;
  
  /// RMSSD ratio thresholds for recovery
  static const double rmssdExcellentRecovery = 1.2;
  static const double rmssdGoodRecovery = 1.0;
  static const double rmssdFairRecovery = 0.8;
  
  /// HF power ratio thresholds for recovery
  static const double hfGoodRecovery = 1.1;
  static const double hfFairRecovery = 0.9;

  // ===== Energy/Battery Score Coefficients =====
  
  /// Weight for sleep factor in energy calculation
  static const double energySleepWeight = 0.5;
  
  /// Weight for HRV factor in energy calculation
  static const double energyHrvWeight = 0.3;
  
  /// Weight for ambient heart rate in energy calculation
  static const double energyHeartRateWeight = 0.2;
  
  /// Sigmoid steepness for energy score smoothing
  static const double energySigmoidSteepness = 12.0;
  
  /// Sigmoid midpoint for energy score
  static const double energySigmoidMidpoint = 0.5;

  // ===== Health/Resilience Score Coefficients =====
  
  /// Natural log RMSSD bounds for health score (ln of 20ms and 120ms)
  static const double healthLnRmssdLower = 3.0; // ln(20)
  static const double healthLnRmssdUpper = 4.8; // ln(120)
  
  /// Logistic function steepness for health score
  static const double healthLogisticSteepness = 6.0;

  // ===== Focus Score Coefficients =====
  
  /// Weight for parasympathetic activity in focus calculation
  static const double focusParasympWeight = 0.6;
  
  /// Weight for (inverted) stress in focus calculation
  static const double focusStressWeight = 0.4;
  
  /// HF power normalization value for focus
  static const double focusHfNormalization = 200.0;

  // ===== Age Adjustment Coefficients =====
  
  /// RMSSD decline per year after age 25 (ms)
  static const double rmssdAgeDecline = 0.7;
  
  /// SDNN decline per year after age 25 (ms)
  static const double sdnnAgeDecline = 1.0;
  
  /// Mean RR decline per year after age 25 (ms)
  static const double meanRrAgeDecline = 2.0;
  
  /// Heart rate increase per year after age 25 (bpm)
  static const double heartRateAgeIncrease = 0.15;
  
  /// Age from which decline calculations start
  static const int ageDeclineStart = 25;
  
  /// Base age for normalization
  static const int baseAge = 30;

  // ===== Gender-Specific Base Values (at age 30) =====
  
  /// Base RMSSD for females at age 30 (ms)
  static const double femaleBaseRmssd = 32.0;
  
  /// Base RMSSD for males at age 30 (ms)
  static const double maleBaseRmssd = 28.0;
  
  /// Base SDNN for females at age 30 (ms)
  static const double femaleBaseSdnn = 45.0;
  
  /// Base SDNN for males at age 30 (ms)
  static const double maleBaseSdnn = 42.0;
  
  /// Base mean RR for females at age 30 (ms)
  static const double femaleBaseMeanRr = 900.0;
  
  /// Base mean RR for males at age 30 (ms)
  static const double maleBaseMeanRr = 950.0;
  
  /// Base heart rate for females (bpm)
  static const double femaleBaseHeartRate = 67.0;
  
  /// Base heart rate for males (bpm)
  static const double maleBaseHeartRate = 63.0;

  // ===== Baseline Calculation Parameters =====
  
  /// Default number of days for baseline calculation
  static const int defaultBaselineDays = 14;
  
  /// Minimum readings required for valid baseline
  static const int minimumBaselineReadings = 3;
  
  /// Percentage thresholds for baseline comparison
  static const double baselineSignificantlyBetter = 115.0; // 115% of baseline
  static const double baselineBetter = 105.0; // 105% of baseline
  static const double baselineStable = 95.0; // 95-105% of baseline
  static const double baselineWorse = 85.0; // 85-95% of baseline

  // ===== Normal Range Multipliers =====
  
  /// Lower bound multiplier for normal range calculation
  static const double normalRangeLowerMultiplier = 0.6;
  
  /// Upper bound multiplier for normal range calculation
  static const double normalRangeUpperMultiplier = 1.5;
  
  /// Mean RR normal range multipliers
  static const double meanRrLowerMultiplier = 0.8;
  static const double meanRrUpperMultiplier = 1.2;

  // ===== Confidence Score Thresholds =====
  
  /// Physiological limits for RMSSD (ms)
  static const double rmssdMinPhysiological = 5.0;
  static const double rmssdMaxPhysiological = 200.0;
  
  /// Physiological limits for mean RR (ms)
  static const double meanRrMinPhysiological = 400.0;
  static const double meanRrMaxPhysiological = 1500.0;
  
  /// Physiological limits for SDNN (ms)
  static const double sdnnMinPhysiological = 10.0;
  static const double sdnnMaxPhysiological = 300.0;
  
  /// LF/HF ratio extreme thresholds
  static const double lfHfRatioMin = 0.1;
  static const double lfHfRatioMax = 10.0;
  
  /// Total power extreme thresholds
  static const double totalPowerMin = 100.0;
  static const double totalPowerMax = 50000.0;
  
  /// Baevsky index extreme thresholds
  static const double baevskyMin = 10.0;
  static const double baevskyMax = 1000.0;
  
  /// DFA alpha1 healthy range
  static const double dfaAlpha1Min = 0.3;
  static const double dfaAlpha1Max = 2.5;

  // ===== Confidence Penalty Multipliers =====
  
  /// Penalty for values outside physiological range
  static const double confidencePenaltyMajor = 0.7;
  static const double confidencePenaltyModerate = 0.8;
  static const double confidencePenaltyMinor = 0.9;
}