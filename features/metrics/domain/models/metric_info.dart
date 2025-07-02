import 'package:flutter/material.dart';

/// Information about an HRV metric including explanations and ranges
class MetricInfo {
  final String name;
  final String shortName;
  final String unit;
  final String description;
  final String significance;
  final String interpretation;
  final List<String> keyPoints;
  final MetricRange normalRange;
  final MetricRange optimalRange;
  final IconData icon;
  final Color color;
  final MetricCategory category;
  final List<String> relatedMetrics;
  final String calculation;

  const MetricInfo({
    required this.name,
    required this.shortName,
    required this.unit,
    required this.description,
    required this.significance,
    required this.interpretation,
    required this.keyPoints,
    required this.normalRange,
    required this.optimalRange,
    required this.icon,
    required this.color,
    required this.category,
    required this.relatedMetrics,
    required this.calculation,
  });
}

/// Range information for a metric
class MetricRange {
  final double? min;
  final double? max;
  final String description;

  const MetricRange({
    this.min,
    this.max,
    required this.description,
  });
}

/// Categories of HRV metrics
enum MetricCategory {
  timeDomain,
  frequencyDomain,
  nonLinear,
  geometric,
  stress,
}

/// Static data for all HRV metrics
class HrvMetricData {
  static const Map<String, MetricInfo> metrics = {
    'rmssd': MetricInfo(
      name: 'Root Mean Square of Successive Differences',
      shortName: 'RMSSD',
      unit: 'ms',
      description: 'The square root of the mean of the squares of successive RR interval differences.',
      significance: 'Primary indicator of parasympathetic (rest & digest) nervous system activity. Higher values generally indicate better recovery and cardiovascular health.',
      interpretation: 'RMSSD reflects short-term variability and is considered the gold standard for HRV measurement. It shows how well your body can adapt and recover.',
      keyPoints: [
        'Primary measure of parasympathetic activity',
        'Higher values = better recovery capacity',
        'Most reliable single HRV metric',
        'Less affected by breathing patterns',
        'Strong predictor of cardiovascular health',
      ],
      normalRange: MetricRange(
        min: 15.0,
        max: 60.0,
        description: 'Typical range for healthy adults',
      ),
      optimalRange: MetricRange(
        min: 30.0,
        max: 80.0,
        description: 'Target range for optimal health',
      ),
      icon: Icons.favorite,
      color: Colors.red,
      category: MetricCategory.timeDomain,
      relatedMetrics: ['pnn50', 'highFrequency'],
      calculation: 'sqrt(mean(successive_differences²))',
    ),
    
    'meanRr': MetricInfo(
      name: 'Mean RR Interval',
      shortName: 'Mean RR',
      unit: 'ms',
      description: 'Average time between heartbeats (RR intervals) during the measurement period.',
      significance: 'Reflects average heart rate and overall autonomic balance. Longer intervals indicate slower heart rate and potentially better fitness.',
      interpretation: 'Higher values (slower heart rate) often correlate with better cardiovascular fitness and recovery state.',
      keyPoints: [
        'Average time between heartbeats',
        'Inverse relationship with heart rate',
        'Higher values often indicate better fitness',
        'Affected by training, stress, and recovery',
        'Baseline for other HRV calculations',
      ],
      normalRange: MetricRange(
        min: 600.0,
        max: 1200.0,
        description: 'Typical range (50-100 BPM)',
      ),
      optimalRange: MetricRange(
        min: 750.0,
        max: 1100.0,
        description: 'Target range for trained individuals',
      ),
      icon: Icons.timeline,
      color: Colors.blue,
      category: MetricCategory.timeDomain,
      relatedMetrics: ['sdnn'],
      calculation: 'mean(RR_intervals)',
    ),

    'sdnn': MetricInfo(
      name: 'Standard Deviation of NN Intervals',
      shortName: 'SDNN',
      unit: 'ms',
      description: 'Standard deviation of all RR intervals during the measurement period.',
      significance: 'Reflects overall HRV and total autonomic activity (both sympathetic and parasympathetic). Indicates overall heart rate variability.',
      interpretation: 'Higher SDNN values indicate greater overall variability and better autonomic function. Lower values may suggest autonomic dysfunction or overtraining.',
      keyPoints: [
        'Measure of overall heart rate variability',
        'Reflects total autonomic nervous system activity',
        'Higher values = better overall autonomic function',
        'Sensitive to measurement duration',
        'Good indicator of general cardiovascular health',
      ],
      normalRange: MetricRange(
        min: 20.0,
        max: 80.0,
        description: 'Typical range for 3-minute recordings',
      ),
      optimalRange: MetricRange(
        min: 35.0,
        max: 100.0,
        description: 'Target range for optimal health',
      ),
      icon: Icons.show_chart,
      color: Colors.green,
      category: MetricCategory.timeDomain,
      relatedMetrics: ['meanRr', 'totalPower'],
      calculation: 'std_deviation(RR_intervals)',
    ),

    'lowFrequency': MetricInfo(
      name: 'Low Frequency Power',
      shortName: 'LF',
      unit: 'ms²',
      description: 'Power in the low frequency band (0.04-0.15 Hz) of the heart rate variability spectrum.',
      significance: 'Reflects a mix of sympathetic and parasympathetic activity, with some baroreflex involvement. Often interpreted as sympathetic activity.',
      interpretation: 'Higher LF power may indicate increased sympathetic nervous system activity, but interpretation requires caution as it\'s influenced by multiple factors.',
      keyPoints: [
        'Frequency band: 0.04-0.15 Hz',
        'Mixed sympathetic and parasympathetic influence',
        'Related to baroreflex function',
        'Affected by breathing patterns',
        'Use in conjunction with other metrics',
      ],
      normalRange: MetricRange(
        min: 50.0,
        max: 500.0,
        description: 'Typical range in normalized units',
      ),
      optimalRange: MetricRange(
        min: 100.0,
        max: 400.0,
        description: 'Balanced autonomic activity',
      ),
      icon: Icons.water_drop,
      color: Colors.orange,
      category: MetricCategory.frequencyDomain,
      relatedMetrics: ['highFrequency', 'lfHfRatio'],
      calculation: 'Power in 0.04-0.15 Hz band',
    ),

    'highFrequency': MetricInfo(
      name: 'High Frequency Power',
      shortName: 'HF',
      unit: 'ms²',
      description: 'Power in the high frequency band (0.15-0.4 Hz) of the heart rate variability spectrum.',
      significance: 'Primarily reflects parasympathetic (vagal) nervous system activity. Strongly correlated with RMSSD.',
      interpretation: 'Higher HF power indicates stronger parasympathetic activity, suggesting better recovery capacity and vagal tone.',
      keyPoints: [
        'Frequency band: 0.15-0.4 Hz',
        'Primary indicator of parasympathetic activity',
        'Strongly correlated with RMSSD',
        'Influenced by respiratory rate',
        'Higher values = better recovery capacity',
      ],
      normalRange: MetricRange(
        min: 50.0,
        max: 300.0,
        description: 'Typical range in normalized units',
      ),
      optimalRange: MetricRange(
        min: 100.0,
        max: 400.0,
        description: 'Strong parasympathetic activity',
      ),
      icon: Icons.air,
      color: Colors.cyan,
      category: MetricCategory.frequencyDomain,
      relatedMetrics: ['rmssd', 'lfHfRatio'],
      calculation: 'Power in 0.15-0.4 Hz band',
    ),

    'lfHfRatio': MetricInfo(
      name: 'LF/HF Ratio',
      shortName: 'LF/HF',
      unit: 'ratio',
      description: 'Ratio of low frequency to high frequency power, indicating autonomic balance.',
      significance: 'Reflects the balance between sympathetic and parasympathetic nervous system activity.',
      interpretation: 'Lower ratios suggest parasympathetic dominance (recovery state), while higher ratios may indicate sympathetic dominance (stress/arousal state).',
      keyPoints: [
        'Balance between sympathetic and parasympathetic',
        'Lower values = more parasympathetic (recovery)',
        'Higher values = more sympathetic (stress/arousal)',
        'Optimal range varies by individual',
        'Consider circadian rhythms and context',
      ],
      normalRange: MetricRange(
        min: 0.5,
        max: 2.0,
        description: 'Typical range for balanced autonomic function',
      ),
      optimalRange: MetricRange(
        min: 0.7,
        max: 1.5,
        description: 'Balanced autonomic activity',
      ),
      icon: Icons.balance,
      color: Colors.purple,
      category: MetricCategory.frequencyDomain,
      relatedMetrics: ['lowFrequency', 'highFrequency'],
      calculation: 'LF_power / HF_power',
    ),

    'baevsky': MetricInfo(
      name: 'Baevsky Stress Index',
      shortName: 'SI',
      unit: 'units',
      description: 'Geometric index reflecting the degree of autonomic regulation strain and stress level.',
      significance: 'Higher values indicate greater physiological stress and autonomic system strain.',
      interpretation: 'Lower values suggest better autonomic balance and less physiological stress. Higher values may indicate overtraining or stress.',
      keyPoints: [
        'Geometric measure of autonomic strain',
        'Higher values = more physiological stress',
        'Sensitive to overtraining and fatigue',
        'Based on histogram analysis of RR intervals',
        'Useful for stress monitoring',
      ],
      normalRange: MetricRange(
        min: 50.0,
        max: 200.0,
        description: 'Typical range for healthy individuals',
      ),
      optimalRange: MetricRange(
        min: 50.0,
        max: 120.0,
        description: 'Low stress, good autonomic balance',
      ),
      icon: Icons.trending_up,
      color: Color(0xFFD32F2F),
      category: MetricCategory.stress,
      relatedMetrics: ['amo50', 'moda'],
      calculation: 'AMo / (2 × Mode × MxDMn)',
    ),

    'coefficientOfVariance': MetricInfo(
      name: 'Coefficient of Variance',
      shortName: 'CV',
      unit: '%',
      description: 'Ratio of standard deviation to mean RR interval, expressed as a percentage.',
      significance: 'Normalized measure of HRV that accounts for heart rate differences. Useful for comparing across different heart rates.',
      interpretation: 'Higher values indicate greater relative variability. Useful for comparing HRV across different individuals or conditions.',
      keyPoints: [
        'Normalized measure of HRV',
        'Accounts for heart rate differences',
        'Useful for comparisons across conditions',
        'Higher values = greater relative variability',
        'Less dependent on absolute heart rate',
      ],
      normalRange: MetricRange(
        min: 2.0,
        max: 8.0,
        description: 'Typical percentage range',
      ),
      optimalRange: MetricRange(
        min: 3.0,
        max: 7.0,
        description: 'Good relative variability',
      ),
      icon: Icons.percent,
      color: Colors.indigo,
      category: MetricCategory.timeDomain,
      relatedMetrics: ['sdnn', 'meanRr'],
      calculation: '(SDNN / Mean_RR) × 100',
    ),

    'mxdmn': MetricInfo(
      name: 'Max - Min Difference',
      shortName: 'MxDMn',
      unit: 'ms',
      description: 'Difference between the longest and shortest RR intervals in the recording.',
      significance: 'Simple measure of total variability range. Sensitive to artifacts and outliers.',
      interpretation: 'Higher values indicate greater total variability, but can be influenced by measurement artifacts or ectopic beats.',
      keyPoints: [
        'Simple range measure of variability',
        'Difference between max and min RR intervals',
        'Sensitive to artifacts and outliers',
        'Easy to calculate and understand',
        'Should be interpreted with caution',
      ],
      normalRange: MetricRange(
        min: 100.0,
        max: 500.0,
        description: 'Typical range for clean recordings',
      ),
      optimalRange: MetricRange(
        min: 150.0,
        max: 400.0,
        description: 'Good variability without artifacts',
      ),
      icon: Icons.straighten,
      color: Colors.brown,
      category: MetricCategory.geometric,
      relatedMetrics: ['sdnn'],
      calculation: 'max(RR_intervals) - min(RR_intervals)',
    ),

    'moda': MetricInfo(
      name: 'Mode of RR Intervals',
      shortName: 'Mo',
      unit: 'ms',
      description: 'Most frequently occurring RR interval value in the recording.',
      significance: 'Represents the dominant RR interval and reflects the predominant autonomic regulation level.',
      interpretation: 'The mode reflects the most common heart rate during the measurement and is used in geometric analysis methods.',
      keyPoints: [
        'Most frequent RR interval value',
        'Reflects predominant autonomic regulation',
        'Used in geometric analysis methods',
        'Component of Baevsky Stress Index',
        'Indicates typical heart rate for the recording',
      ],
      normalRange: MetricRange(
        min: 600.0,
        max: 1200.0,
        description: 'Typical range based on heart rate',
      ),
      optimalRange: MetricRange(
        min: 750.0,
        max: 1100.0,
        description: 'Optimal heart rate range',
      ),
      icon: Icons.bar_chart,
      color: Colors.teal,
      category: MetricCategory.geometric,
      relatedMetrics: ['meanRr', 'baevsky'],
      calculation: 'most_frequent(RR_intervals)',
    ),

    'amo50': MetricInfo(
      name: 'Amplitude of Mode',
      shortName: 'AMo50',
      unit: '%',
      description: 'Percentage of RR intervals that fall within ±50ms of the mode value.',
      significance: 'Higher values indicate greater concentration of RR intervals around the mode, suggesting reduced variability and increased sympathetic activity.',
      interpretation: 'Lower values are generally better, indicating greater HRV. Higher values may suggest stress, fatigue, or autonomic dysfunction.',
      keyPoints: [
        'Percentage of intervals within ±50ms of mode',
        'Higher values = reduced variability',
        'Lower values = better HRV',
        'Component of Baevsky Stress Index',
        'Sensitive to sympathetic activity',
      ],
      normalRange: MetricRange(
        min: 20.0,
        max: 60.0,
        description: 'Typical percentage range',
      ),
      optimalRange: MetricRange(
        min: 20.0,
        max: 40.0,
        description: 'Good variability around mode',
      ),
      icon: Icons.compress,
      color: Colors.deepOrange,
      category: MetricCategory.geometric,
      relatedMetrics: ['baevsky', 'moda'],
      calculation: '% of intervals within Mode ± 50ms',
    ),

    'pnn50': MetricInfo(
      name: 'Percentage of Successive Differences > 50ms',
      shortName: 'pNN50',
      unit: '%',
      description: 'Percentage of successive RR interval differences greater than 50ms.',
      significance: 'Strong indicator of parasympathetic activity, closely related to RMSSD.',
      interpretation: 'Higher values indicate better parasympathetic function and HRV. Lower values may suggest reduced autonomic function or stress.',
      keyPoints: [
        'Percentage of large successive differences',
        'Strong parasympathetic indicator',
        'Closely related to RMSSD',
        'Higher values = better autonomic function',
        'Threshold-based measure',
      ],
      normalRange: MetricRange(
        min: 5.0,
        max: 30.0,
        description: 'Typical percentage range',
      ),
      optimalRange: MetricRange(
        min: 10.0,
        max: 40.0,
        description: 'Strong parasympathetic activity',
      ),
      icon: Icons.speed,
      color: Colors.lightGreen,
      category: MetricCategory.timeDomain,
      relatedMetrics: ['rmssd', 'pnn20'],
      calculation: '% of |successive_differences| > 50ms',
    ),

    'pnn20': MetricInfo(
      name: 'Percentage of Successive Differences > 20ms',
      shortName: 'pNN20',
      unit: '%',
      description: 'Percentage of successive RR interval differences greater than 20ms.',
      significance: 'More sensitive measure of parasympathetic activity than pNN50, capturing smaller variations.',
      interpretation: 'Higher values indicate good autonomic function. More sensitive to subtle changes than pNN50.',
      keyPoints: [
        'More sensitive than pNN50',
        'Captures smaller autonomic variations',
        'Higher values = better autonomic function',
        'Useful for detecting subtle changes',
        'Complementary to pNN50',
      ],
      normalRange: MetricRange(
        min: 20.0,
        max: 70.0,
        description: 'Typical percentage range',
      ),
      optimalRange: MetricRange(
        min: 30.0,
        max: 80.0,
        description: 'Strong autonomic responsiveness',
      ),
      icon: Icons.speed,
      color: Colors.lime,
      category: MetricCategory.timeDomain,
      relatedMetrics: ['pnn50', 'rmssd'],
      calculation: '% of |successive_differences| > 20ms',
    ),

    'totalPower': MetricInfo(
      name: 'Total Power',
      shortName: 'TP',
      unit: 'ms²',
      description: 'Total power of the heart rate variability spectrum (0.0033-0.4 Hz).',
      significance: 'Reflects overall autonomic activity across all frequency bands.',
      interpretation: 'Higher values indicate greater overall HRV and autonomic activity. Represents the total variability in the signal.',
      keyPoints: [
        'Sum of all frequency domain power',
        'Reflects total autonomic activity',
        'Higher values = greater overall HRV',
        'Correlates with SDNN in time domain',
        'Comprehensive measure of variability',
      ],
      normalRange: MetricRange(
        min: 500.0,
        max: 3000.0,
        description: 'Typical range for short-term recordings',
      ),
      optimalRange: MetricRange(
        min: 1000.0,
        max: 4000.0,
        description: 'Strong overall autonomic activity',
      ),
      icon: Icons.all_inclusive,
      color: Colors.deepPurple,
      category: MetricCategory.frequencyDomain,
      relatedMetrics: ['sdnn', 'lowFrequency', 'highFrequency'],
      calculation: 'Sum of all spectral power',
    ),

    'dfaAlpha1': MetricInfo(
      name: 'Detrended Fluctuation Analysis α1',
      shortName: 'DFA α1',
      unit: 'ratio',
      description: 'Short-term fractal scaling exponent reflecting the correlation properties of heart rate dynamics.',
      significance: 'Measures the intrinsic correlation properties of heart rate fluctuations, independent of traditional time and frequency domain measures.',
      interpretation: 'Values around 1.0 indicate healthy fractal correlation. Values significantly above or below may indicate pathological conditions.',
      keyPoints: [
        'Fractal analysis of heart rate dynamics',
        'Independent of traditional HRV measures',
        'Values around 1.0 = healthy correlation',
        'Advanced nonlinear measure',
        'Sensitive to autonomic dysfunction',
      ],
      normalRange: MetricRange(
        min: 0.8,
        max: 1.3,
        description: 'Typical range for healthy individuals',
      ),
      optimalRange: MetricRange(
        min: 0.9,
        max: 1.2,
        description: 'Optimal fractal correlation',
      ),
      icon: Icons.insights,
      color: Colors.blueGrey,
      category: MetricCategory.nonLinear,
      relatedMetrics: [],
      calculation: 'Fractal scaling exponent (4-16 beats)',
    ),
  };

  /// Get metric info by key
  static MetricInfo? getMetricInfo(String key) {
    return metrics[key];
  }

  /// Get all metrics in a category
  static List<MapEntry<String, MetricInfo>> getMetricsByCategory(MetricCategory category) {
    return metrics.entries.where((entry) => entry.value.category == category).toList();
  }

  /// Get category display name
  static String getCategoryName(MetricCategory category) {
    switch (category) {
      case MetricCategory.timeDomain:
        return 'Time Domain';
      case MetricCategory.frequencyDomain:
        return 'Frequency Domain';
      case MetricCategory.nonLinear:
        return 'Non-linear';
      case MetricCategory.geometric:
        return 'Geometric';
      case MetricCategory.stress:
        return 'Stress Index';
    }
  }

  /// Get category description
  static String getCategoryDescription(MetricCategory category) {
    switch (category) {
      case MetricCategory.timeDomain:
        return 'Statistical measures calculated directly from RR intervals';
      case MetricCategory.frequencyDomain:
        return 'Measures derived from spectral analysis of RR intervals';
      case MetricCategory.nonLinear:
        return 'Advanced measures capturing complex heart rate dynamics';
      case MetricCategory.geometric:
        return 'Measures based on geometric patterns in RR interval distributions';
      case MetricCategory.stress:
        return 'Composite indices reflecting physiological stress levels';
    }
  }
}