import 'dart:math';
import '../../../../shared/models/hrv_reading.dart';
import '../../../../core/utils/app_utils.dart';

class HrvCalculationService {
  HrvCalculationService._();
  
  static final HrvCalculationService _instance = HrvCalculationService._();
  factory HrvCalculationService() => _instance;

  /// Calculate all HRV metrics from RR intervals
  /// RR intervals should be in milliseconds
  HrvMetrics calculateMetrics(List<double> rrIntervals) {
    if (rrIntervals.isEmpty) {
      throw ArgumentError('RR intervals cannot be empty');
    }

    if (rrIntervals.length < 2) {
      throw ArgumentError('At least 2 RR intervals required for HRV analysis');
    }

    // Validate RR intervals are within physiological range (300-2000ms)
    for (final rr in rrIntervals) {
      if (rr < 300 || rr > 2000) {
        throw ArgumentError('RR interval $rr ms is outside physiological range (300-2000ms)');
      }
    }

    return HrvMetrics(
      rmssd: AppUtils.calculateRmssd(rrIntervals),
      meanRr: AppUtils.calculateMeanRr(rrIntervals),
      sdnn: AppUtils.calculateSdnn(rrIntervals),
      lowFrequency: _calculateLowFrequency(rrIntervals),
      highFrequency: _calculateHighFrequency(rrIntervals),
      lfHfRatio: _calculateLfHfRatio(rrIntervals),
      baevsky: _calculateBaevsky(rrIntervals),
      coefficientOfVariance: _calculateCoefficientOfVariance(rrIntervals),
      mxdmn: _calculateMxdmn(rrIntervals),
      moda: _calculateModa(rrIntervals),
      amo50: _calculateAmo50(rrIntervals),
      pnn50: AppUtils.calculatePnn50(rrIntervals),
      pnn20: AppUtils.calculatePnn20(rrIntervals),
      totalPower: _calculateTotalPower(rrIntervals),
      dfaAlpha1: _calculateDfaAlpha1(rrIntervals),
    );
  }

  /// Calculate Low Frequency power (0.04-0.15 Hz)
  double _calculateLowFrequency(List<double> rrIntervals) {
    final psd = _calculatePowerSpectralDensity(rrIntervals);
    final samplingRate = _calculateSamplingRate(rrIntervals);
    
    final lowFreqStart = (0.04 * psd.length / samplingRate).floor();
    final lowFreqEnd = (0.15 * psd.length / samplingRate).ceil();
    
    double lfPower = 0.0;
    for (int i = lowFreqStart; i < lowFreqEnd && i < psd.length; i++) {
      lfPower += psd[i];
    }
    
    return lfPower;
  }

  /// Calculate High Frequency power (0.15-0.4 Hz)
  double _calculateHighFrequency(List<double> rrIntervals) {
    final psd = _calculatePowerSpectralDensity(rrIntervals);
    final samplingRate = _calculateSamplingRate(rrIntervals);
    
    final highFreqStart = (0.15 * psd.length / samplingRate).floor();
    final highFreqEnd = (0.4 * psd.length / samplingRate).ceil();
    
    double hfPower = 0.0;
    for (int i = highFreqStart; i < highFreqEnd && i < psd.length; i++) {
      hfPower += psd[i];
    }
    
    return hfPower;
  }

  /// Calculate LF/HF ratio
  double _calculateLfHfRatio(List<double> rrIntervals) {
    final lf = _calculateLowFrequency(rrIntervals);
    final hf = _calculateHighFrequency(rrIntervals);
    
    if (hf == 0) return 0.0;
    return lf / hf;
  }

  /// Calculate Total Power (0.0-0.4 Hz)
  double _calculateTotalPower(List<double> rrIntervals) {
    final psd = _calculatePowerSpectralDensity(rrIntervals);
    return psd.reduce((a, b) => a + b);
  }

  /// Calculate Baevsky Stress Index
  double _calculateBaevsky(List<double> rrIntervals) {
    final moda = _calculateModa(rrIntervals);
    final amo = _calculateAmo50(rrIntervals);
    final mxdmn = _calculateMxdmn(rrIntervals);
    
    if (mxdmn == 0) return 0.0;
    return amo / (2 * moda * mxdmn / 1000);
  }

  /// Calculate Coefficient of Variance
  double _calculateCoefficientOfVariance(List<double> rrIntervals) {
    final mean = AppUtils.calculateMeanRr(rrIntervals);
    final sdnn = AppUtils.calculateSdnn(rrIntervals);
    
    if (mean == 0) return 0.0;
    return (sdnn / mean) * 100;
  }

  /// Calculate MxDMn (Maximum - Minimum RR interval difference)
  double _calculateMxdmn(List<double> rrIntervals) {
    if (rrIntervals.isEmpty) return 0.0;
    
    final max = rrIntervals.reduce((a, b) => a > b ? a : b);
    final min = rrIntervals.reduce((a, b) => a < b ? a : b);
    
    return max - min;
  }

  /// Calculate Moda (Mode of RR intervals)
  double _calculateModa(List<double> rrIntervals) {
    if (rrIntervals.isEmpty) return 0.0;
    
    // Create histogram with 50ms bins
    final Map<int, int> histogram = {};
    
    for (final rr in rrIntervals) {
      final bin = (rr / 50).round() * 50;
      histogram[bin] = (histogram[bin] ?? 0) + 1;
    }
    
    // Find bin with maximum frequency
    int maxCount = 0;
    int modaBin = 0;
    
    histogram.forEach((bin, count) {
      if (count > maxCount) {
        maxCount = count;
        modaBin = bin;
      }
    });
    
    return modaBin.toDouble();
  }

  /// Calculate AMo50 (Amplitude of Mode)
  double _calculateAmo50(List<double> rrIntervals) {
    if (rrIntervals.isEmpty) return 0.0;
    
    final moda = _calculateModa(rrIntervals);
    
    // Count intervals within ±50ms of mode
    int count = 0;
    for (final rr in rrIntervals) {
      if ((rr - moda).abs() <= 50) {
        count++;
      }
    }
    
    return (count / rrIntervals.length) * 100;
  }

  /// Calculate DFA α1 (Detrended Fluctuation Analysis)
  double _calculateDfaAlpha1(List<double> rrIntervals) {
    if (rrIntervals.length < 16) return 0.0;
    
    // Convert to cumulative sum
    final mean = rrIntervals.reduce((a, b) => a + b) / rrIntervals.length;
    final cumSum = <double>[];
    double sum = 0.0;
    
    for (final rr in rrIntervals) {
      sum += (rr - mean);
      cumSum.add(sum);
    }
    
    // Calculate fluctuation function for different box sizes
    final logN = <double>[];
    final logF = <double>[];
    
    // Box sizes from 4 to N/4
    for (int boxSize = 4; boxSize <= rrIntervals.length ~/ 4; boxSize += 2) {
      final numBoxes = rrIntervals.length ~/ boxSize;
      double fluctuation = 0.0;
      
      for (int i = 0; i < numBoxes; i++) {
        final boxStart = i * boxSize;
        final boxEnd = boxStart + boxSize;
        
        // Detrend each box using linear regression
        final detrended = _detrend(cumSum.sublist(boxStart, boxEnd));
        
        // Calculate mean square fluctuation
        for (final value in detrended) {
          fluctuation += value * value;
        }
      }
      
      fluctuation = sqrt(fluctuation / (numBoxes * boxSize));
      
      if (fluctuation > 0) {
        logN.add(log(boxSize));
        logF.add(log(fluctuation));
      }
    }
    
    // Calculate slope using linear regression
    if (logN.length < 2) return 0.0;
    
    final meanLogN = logN.reduce((a, b) => a + b) / logN.length;
    final meanLogF = logF.reduce((a, b) => a + b) / logF.length;
    
    double numerator = 0.0;
    double denominator = 0.0;
    
    for (int i = 0; i < logN.length; i++) {
      final diffN = logN[i] - meanLogN;
      final diffF = logF[i] - meanLogF;
      numerator += diffN * diffF;
      denominator += diffN * diffN;
    }
    
    return denominator == 0 ? 0.0 : numerator / denominator;
  }

  /// Helper method to detrend data using linear regression
  List<double> _detrend(List<double> data) {
    if (data.length < 2) return data;
    
    final n = data.length;
    final meanX = (n - 1) / 2.0;
    final meanY = data.reduce((a, b) => a + b) / n;
    
    double numerator = 0.0;
    double denominator = 0.0;
    
    for (int i = 0; i < n; i++) {
      final diffX = i - meanX;
      numerator += diffX * (data[i] - meanY);
      denominator += diffX * diffX;
    }
    
    final slope = denominator == 0 ? 0.0 : numerator / denominator;
    final intercept = meanY - slope * meanX;
    
    final detrended = <double>[];
    for (int i = 0; i < n; i++) {
      final trend = slope * i + intercept;
      detrended.add(data[i] - trend);
    }
    
    return detrended;
  }

  /// Calculate power spectral density using simple periodogram
  List<double> _calculatePowerSpectralDensity(List<double> rrIntervals) {
    // Resample to uniform intervals (4Hz = 250ms)
    final uniformIntervals = _resampleToUniform(rrIntervals, 250.0);
    final n = uniformIntervals.length;
    
    if (n < 4) return [0.0];
    
    // Apply Hanning window
    final windowed = <double>[];
    for (int i = 0; i < n; i++) {
      final window = 0.5 * (1 - cos(2 * pi * i / (n - 1)));
      windowed.add(uniformIntervals[i] * window);
    }
    
    // Simple periodogram (magnitude squared of DFT)
    final psd = <double>[];
    for (int k = 0; k < n ~/ 2; k++) {
      double real = 0.0;
      double imag = 0.0;
      
      for (int i = 0; i < n; i++) {
        final angle = -2 * pi * k * i / n;
        real += windowed[i] * cos(angle);
        imag += windowed[i] * sin(angle);
      }
      
      psd.add((real * real + imag * imag) / n);
    }
    
    return psd;
  }

  /// Resample RR intervals to uniform time intervals
  List<double> _resampleToUniform(List<double> rrIntervals, double intervalMs) {
    if (rrIntervals.length < 2) return rrIntervals;
    
    // Create time series
    final times = <double>[0.0];
    for (int i = 1; i < rrIntervals.length; i++) {
      times.add(times.last + rrIntervals[i-1]);
    }
    
    // Resample at uniform intervals
    final uniformData = <double>[];
    final totalTime = times.last;
    
    for (double t = 0; t < totalTime; t += intervalMs) {
      // Linear interpolation
      int index = 0;
      while (index < times.length - 1 && times[index + 1] <= t) {
        index++;
      }
      
      if (index == times.length - 1) {
        uniformData.add(rrIntervals[index]);
      } else {
        final t1 = times[index];
        final t2 = times[index + 1];
        final rr1 = rrIntervals[index];
        final rr2 = rrIntervals[index + 1];
        
        final alpha = (t - t1) / (t2 - t1);
        uniformData.add(rr1 + alpha * (rr2 - rr1));
      }
    }
    
    return uniformData;
  }

  /// Calculate effective sampling rate from RR intervals
  double _calculateSamplingRate(List<double> rrIntervals) {
    if (rrIntervals.length < 2) return 1.0;
    
    final meanRr = rrIntervals.reduce((a, b) => a + b) / rrIntervals.length;
    return 1000.0 / meanRr; // Convert ms to Hz
  }
}