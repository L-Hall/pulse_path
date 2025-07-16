import 'dart:math';

class AppUtils {
  // Prevent instantiation
  AppUtils._();
  
  /// Validates if a heart rate value is within acceptable range
  static bool isValidHeartRate(int heartRate) {
    return heartRate >= 40 && heartRate <= 200;
  }
  
  /// Calculates score color based on value (0-100)
  static String getScoreColor(int score) {
    if (score >= 80) return '#4CAF50'; // Green
    if (score >= 60) return '#FF9800'; // Orange
    if (score >= 40) return '#FF5722'; // Red-Orange
    return '#F44336'; // Red
  }
  
  /// Formats duration in seconds to MM:SS format
  static String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
  
  /// Generates a random UUID v4
  static String generateUuid() {
    final random = Random();
    const chars = '0123456789abcdef';
    final uuid = StringBuffer();
    
    for (int i = 0; i < 32; i++) {
      if (i == 8 || i == 12 || i == 16 || i == 20) {
        uuid.write('-');
      }
      uuid.write(chars[random.nextInt(16)]);
    }
    
    return uuid.toString();
  }
  
  /// Calculates Root Mean Square of Successive Differences (RMSSD)
  static double calculateRmssd(List<double> rrIntervals) {
    if (rrIntervals.length < 2) return 0.0;
    
    double sumSquaredDiffs = 0.0;
    for (int i = 1; i < rrIntervals.length; i++) {
      final diff = rrIntervals[i] - rrIntervals[i - 1];
      sumSquaredDiffs += diff * diff;
    }
    
    return sqrt(sumSquaredDiffs / (rrIntervals.length - 1));
  }
  
  /// Calculates Standard Deviation of Normal-to-Normal intervals (SDNN)
  static double calculateSdnn(List<double> rrIntervals) {
    if (rrIntervals.isEmpty) return 0.0;
    
    final mean = rrIntervals.reduce((a, b) => a + b) / rrIntervals.length;
    final variance = rrIntervals
        .map((rr) => pow(rr - mean, 2))
        .reduce((a, b) => a + b) / rrIntervals.length;
    
    return sqrt(variance);
  }
  
  /// Calculates mean of R-R intervals
  static double calculateMeanRr(List<double> rrIntervals) {
    if (rrIntervals.isEmpty) return 0.0;
    return rrIntervals.reduce((a, b) => a + b) / rrIntervals.length;
  }
  
  /// Calculates percentage of successive RR intervals that differ by more than 50ms
  static double calculatePnn50(List<double> rrIntervals) {
    if (rrIntervals.length < 2) return 0.0;
    
    int count = 0;
    for (int i = 1; i < rrIntervals.length; i++) {
      if ((rrIntervals[i] - rrIntervals[i - 1]).abs() > 50) {
        count++;
      }
    }
    
    return (count / (rrIntervals.length - 1)) * 100;
  }
  
  /// Calculates percentage of successive RR intervals that differ by more than 20ms
  static double calculatePnn20(List<double> rrIntervals) {
    if (rrIntervals.length < 2) return 0.0;
    
    int count = 0;
    for (int i = 1; i < rrIntervals.length; i++) {
      if ((rrIntervals[i] - rrIntervals[i - 1]).abs() > 20) {
        count++;
      }
    }
    
    return (count / (rrIntervals.length - 1)) * 100;
  }
  
  /// Calculates Coefficient of Variance (CV) - SDNN/Mean RR
  static double calculateCoefficientOfVariance(List<double> rrIntervals) {
    if (rrIntervals.isEmpty) return 0.0;
    
    final mean = calculateMeanRr(rrIntervals);
    final sdnn = calculateSdnn(rrIntervals);
    
    if (mean == 0) return 0.0;
    return (sdnn / mean) * 100;
  }
  
  /// Calculates MxDMn (Maximum - Minimum RR interval difference)
  static double calculateMxdmn(List<double> rrIntervals) {
    if (rrIntervals.isEmpty) return 0.0;
    
    final max = rrIntervals.reduce((a, b) => a > b ? a : b);
    final min = rrIntervals.reduce((a, b) => a < b ? a : b);
    
    return max - min;
  }
  
  /// Validates timestamp is within reasonable range
  static bool isValidTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final oneYearAgo = now.subtract(const Duration(days: 365));
    final oneYearFromNow = now.add(const Duration(days: 365));
    
    return timestamp.isAfter(oneYearAgo) && timestamp.isBefore(oneYearFromNow);
  }
}