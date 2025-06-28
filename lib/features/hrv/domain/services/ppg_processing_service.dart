import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

/// Service for processing PPG signals and extracting heart rate data
class PpgProcessingService {
  PpgProcessingService._();
  
  static final PpgProcessingService _instance = PpgProcessingService._();
  factory PpgProcessingService() => _instance;

  // PPG processing configuration
  static const int _sampleRate = 30; // 30 FPS target
  static const int _windowSize = 256; // Processing window size
  static const double _heartRateMin = 40.0; // Minimum valid heart rate
  static const double _heartRateMax = 200.0; // Maximum valid heart rate
  static const double _qualityThreshold = 0.7; // Minimum signal quality
  
  // Signal processing buffers
  final List<double> _signalBuffer = [];
  final List<double> _filteredBuffer = [];
  final List<DateTime> _timestampBuffer = [];
  final List<double> _heartRateBuffer = [];
  
  // RR interval extraction
  final List<double> _rrIntervals = [];
  final List<DateTime> _peakTimestamps = [];
  
  // Quality metrics
  double _currentSignalQuality = 0.0;
  double _currentHeartRate = 0.0;
  bool _isProcessing = false;

  /// Start processing PPG frames
  Stream<PpgProcessingResult> processFrameStream(Stream<Uint8List> frameStream) {
    if (_isProcessing) {
      throw PpgProcessingException('Processing already in progress');
    }

    _isProcessing = true;
    _resetBuffers();

    return frameStream.map((frameData) {
      try {
        final timestamp = DateTime.now();
        
        // Extract brightness signal from frame
        final brightness = _extractBrightness(frameData);
        
        // Add to signal buffer
        _signalBuffer.add(brightness);
        _timestampBuffer.add(timestamp);
        
        // Process if we have enough samples
        if (_signalBuffer.length >= _windowSize) {
          return _processSignalWindow();
        }
        
        // Return intermediate result
        return PpgProcessingResult(
          heartRate: _currentHeartRate,
          signalQuality: _currentSignalQuality,
          rrIntervals: List.from(_rrIntervals),
          isValidSignal: _currentSignalQuality >= _qualityThreshold,
        );
      } catch (e) {
        throw PpgProcessingException('Frame processing failed: $e');
      }
    });
  }

  /// Extract average brightness from frame data
  double _extractBrightness(Uint8List frameData) {
    if (frameData.isEmpty) return 0.0;
    
    // Calculate average brightness from the center region of the frame
    // This reduces noise from hand movement at edges
    final centerStart = frameData.length ~/ 4;
    final centerEnd = (frameData.length * 3) ~/ 4;
    
    double sum = 0.0;
    int count = 0;
    
    for (int i = centerStart; i < centerEnd; i++) {
      sum += frameData[i];
      count++;
    }
    
    return count > 0 ? sum / count : 0.0;
  }

  /// Process the current signal window to extract heart rate and RR intervals
  PpgProcessingResult _processSignalWindow() {
    // Apply filtering to remove noise
    _applyBandpassFilter();
    
    // Detect peaks and calculate heart rate
    final peaks = _detectPeaks();
    final heartRate = _calculateHeartRate(peaks);
    final quality = _assessSignalQuality();
    
    // Extract RR intervals if signal quality is good
    if (quality >= _qualityThreshold && peaks.length >= 2) {
      _extractRrIntervals(peaks);
    }
    
    _currentHeartRate = heartRate;
    _currentSignalQuality = quality;
    
    // Maintain buffer size
    _maintainBufferSize();
    
    return PpgProcessingResult(
      heartRate: heartRate,
      signalQuality: quality,
      rrIntervals: List.from(_rrIntervals),
      isValidSignal: quality >= _qualityThreshold,
    );
  }

  /// Apply bandpass filter to isolate heart rate frequencies (0.7-4.0 Hz)
  void _applyBandpassFilter() {
    _filteredBuffer.clear();
    
    if (_signalBuffer.length < 10) {
      _filteredBuffer.addAll(_signalBuffer);
      return;
    }
    
    // Simple moving average filter to remove DC component
    final dcFiltered = <double>[];
    const windowSize = 30;
    
    for (int i = 0; i < _signalBuffer.length; i++) {
      final start = max(0, i - windowSize ~/ 2);
      final end = min(_signalBuffer.length, i + windowSize ~/ 2);
      
      double sum = 0.0;
      for (int j = start; j < end; j++) {
        sum += _signalBuffer[j];
      }
      final mean = sum / (end - start);
      dcFiltered.add(_signalBuffer[i] - mean);
    }
    
    // Apply simple low-pass filter to reduce noise
    _filteredBuffer.add(dcFiltered[0]);
    for (int i = 1; i < dcFiltered.length; i++) {
      const alpha = 0.1; // Filter coefficient
      _filteredBuffer.add(alpha * dcFiltered[i] + (1 - alpha) * _filteredBuffer[i - 1]);
    }
  }

  /// Detect peaks in the filtered signal
  List<int> _detectPeaks() {
    if (_filteredBuffer.length < 10) return [];
    
    final peaks = <int>[];
    const minPeakDistance = 15; // Minimum samples between peaks (~0.5 seconds at 30fps)
    
    // Calculate dynamic threshold based on signal variance
    final mean = _filteredBuffer.reduce((a, b) => a + b) / _filteredBuffer.length;
    final variance = _filteredBuffer
        .map((x) => pow(x - mean, 2))
        .reduce((a, b) => a + b) / _filteredBuffer.length;
    final threshold = mean + sqrt(variance) * 0.5;
    
    // Find peaks
    for (int i = 1; i < _filteredBuffer.length - 1; i++) {
      final current = _filteredBuffer[i];
      final prev = _filteredBuffer[i - 1];
      final next = _filteredBuffer[i + 1];
      
      // Check if this is a local maximum above threshold
      if (current > prev && current > next && current > threshold) {
        // Check minimum distance from last peak
        if (peaks.isEmpty || (i - peaks.last) >= minPeakDistance) {
          peaks.add(i);
        }
      }
    }
    
    return peaks;
  }

  /// Calculate heart rate from detected peaks
  double _calculateHeartRate(List<int> peaks) {
    if (peaks.length < 2) return 0.0;
    
    // Calculate intervals between peaks
    final intervals = <double>[];
    for (int i = 1; i < peaks.length; i++) {
      final interval = (peaks[i] - peaks[i - 1]) / _sampleRate; // Convert to seconds
      intervals.add(interval);
    }
    
    if (intervals.isEmpty) return 0.0;
    
    // Calculate average interval and convert to BPM
    final averageInterval = intervals.reduce((a, b) => a + b) / intervals.length;
    final heartRate = 60.0 / averageInterval;
    
    // Validate heart rate range
    if (heartRate >= _heartRateMin && heartRate <= _heartRateMax) {
      _heartRateBuffer.add(heartRate);
      
      // Maintain buffer size for smoothing
      if (_heartRateBuffer.length > 10) {
        _heartRateBuffer.removeAt(0);
      }
      
      // Return smoothed heart rate
      return _heartRateBuffer.reduce((a, b) => a + b) / _heartRateBuffer.length;
    }
    
    return _currentHeartRate; // Return previous valid value
  }

  /// Assess signal quality based on various metrics
  double _assessSignalQuality() {
    if (_filteredBuffer.length < 30) return 0.0;
    
    // Signal-to-noise ratio assessment
    final mean = _filteredBuffer.reduce((a, b) => a + b) / _filteredBuffer.length;
    final variance = _filteredBuffer
        .map((x) => pow(x - mean, 2))
        .reduce((a, b) => a + b) / _filteredBuffer.length;
    final snr = variance > 0 ? mean.abs() / sqrt(variance) : 0.0;
    
    // Regularity assessment (coefficient of variation)
    if (_heartRateBuffer.length < 3) return snr.clamp(0.0, 1.0);
    
    final hrMean = _heartRateBuffer.reduce((a, b) => a + b) / _heartRateBuffer.length;
    final hrVariance = _heartRateBuffer
        .map((hr) => pow(hr - hrMean, 2))
        .reduce((a, b) => a + b) / _heartRateBuffer.length;
    final cv = hrMean > 0 ? sqrt(hrVariance) / hrMean : 1.0;
    
    // Combine metrics for overall quality score
    final regularityScore = (1.0 - cv.clamp(0.0, 1.0));
    final snrScore = snr.clamp(0.0, 1.0);
    
    return (regularityScore * 0.6 + snrScore * 0.4).clamp(0.0, 1.0);
  }

  /// Extract RR intervals from detected peaks
  void _extractRrIntervals(List<int> peaks) {
    if (peaks.length < 2) return;
    
    for (int i = 1; i < peaks.length; i++) {
      final peakIndex1 = peaks[i - 1];
      final peakIndex2 = peaks[i];
      
      if (peakIndex1 < _timestampBuffer.length && peakIndex2 < _timestampBuffer.length) {
        final timestamp1 = _timestampBuffer[peakIndex1];
        final timestamp2 = _timestampBuffer[peakIndex2];
        
        final rrInterval = timestamp2.difference(timestamp1).inMilliseconds.toDouble();
        
        // Validate RR interval range (300-2000ms)
        if (rrInterval >= 300 && rrInterval <= 2000) {
          _rrIntervals.add(rrInterval);
          _peakTimestamps.add(timestamp2);
        }
      }
    }
    
    // Limit buffer size to prevent memory issues
    if (_rrIntervals.length > 1000) {
      final removeCount = _rrIntervals.length - 1000;
      _rrIntervals.removeRange(0, removeCount);
      _peakTimestamps.removeRange(0, removeCount);
    }
  }

  /// Maintain buffer sizes to prevent memory overflow
  void _maintainBufferSize() {
    const maxBufferSize = 512;
    
    if (_signalBuffer.length > maxBufferSize) {
      final removeCount = _signalBuffer.length - maxBufferSize;
      _signalBuffer.removeRange(0, removeCount);
      _timestampBuffer.removeRange(0, removeCount);
      _filteredBuffer.removeRange(0, removeCount);
    }
  }

  /// Reset all processing buffers
  void _resetBuffers() {
    _signalBuffer.clear();
    _filteredBuffer.clear();
    _timestampBuffer.clear();
    _heartRateBuffer.clear();
    _rrIntervals.clear();
    _peakTimestamps.clear();
    _currentSignalQuality = 0.0;
    _currentHeartRate = 0.0;
  }

  /// Stop processing and cleanup
  void stopProcessing() {
    _isProcessing = false;
    // Keep buffers for final analysis
  }

  /// Get final RR intervals for HRV analysis
  List<double> getFinalRrIntervals() {
    return List.from(_rrIntervals);
  }

  /// Get processing statistics
  PpgProcessingStats getProcessingStats() {
    return PpgProcessingStats(
      totalSamples: _signalBuffer.length,
      validRrIntervals: _rrIntervals.length,
      averageHeartRate: _heartRateBuffer.isNotEmpty 
          ? _heartRateBuffer.reduce((a, b) => a + b) / _heartRateBuffer.length 
          : 0.0,
      averageSignalQuality: _currentSignalQuality,
      processingDuration: _timestampBuffer.isNotEmpty 
          ? _timestampBuffer.last.difference(_timestampBuffer.first)
          : Duration.zero,
    );
  }

  /// Check if currently processing
  bool get isProcessing => _isProcessing;
}

/// Result of PPG signal processing
class PpgProcessingResult {
  final double heartRate;
  final double signalQuality;
  final List<double> rrIntervals;
  final bool isValidSignal;

  const PpgProcessingResult({
    required this.heartRate,
    required this.signalQuality,
    required this.rrIntervals,
    required this.isValidSignal,
  });
}

/// Statistics from PPG processing session
class PpgProcessingStats {
  final int totalSamples;
  final int validRrIntervals;
  final double averageHeartRate;
  final double averageSignalQuality;
  final Duration processingDuration;

  const PpgProcessingStats({
    required this.totalSamples,
    required this.validRrIntervals,
    required this.averageHeartRate,
    required this.averageSignalQuality,
    required this.processingDuration,
  });
}

/// Custom exception for PPG processing operations
class PpgProcessingException implements Exception {
  final String message;
  
  const PpgProcessingException(this.message);
  
  @override
  String toString() => 'PpgProcessingException: $message';
}