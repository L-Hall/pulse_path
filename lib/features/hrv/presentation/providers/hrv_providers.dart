import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/hrv_calculation_service.dart';
import '../../domain/services/hrv_scoring_service.dart';
import '../../../../shared/models/hrv_reading.dart';
import '../../../../core/di/injection_container.dart';

/// Provider for HRV calculation service
final hrvCalculationServiceProvider = Provider<HrvCalculationService>((ref) {
  return sl<HrvCalculationService>();
});

/// Provider for HRV scoring service
final hrvScoringServiceProvider = Provider<HrvScoringService>((ref) {
  return sl<HrvScoringService>();
});

/// State notifier for HRV metrics calculation
class HrvMetricsNotifier extends StateNotifier<AsyncValue<HrvMetrics?>> {
  HrvMetricsNotifier(this._calculationService) : super(const AsyncValue.data(null));
  
  final HrvCalculationService _calculationService;

  /// Calculate HRV metrics from RR intervals
  Future<HrvMetrics> calculateMetrics(List<double> rrIntervals) async {
    state = const AsyncValue.loading();
    
    try {
      final metrics = _calculationService.calculateMetrics(rrIntervals);
      state = AsyncValue.data(metrics);
      return metrics;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

/// Provider for HRV metrics calculation notifier
final hrvMetricsNotifierProvider = StateNotifierProvider<HrvMetricsNotifier, AsyncValue<HrvMetrics?>>((ref) {
  final calculationService = ref.watch(hrvCalculationServiceProvider);
  return HrvMetricsNotifier(calculationService);
});

/// State notifier for HRV scores calculation
class HrvScoresNotifier extends StateNotifier<AsyncValue<HrvScores?>> {
  HrvScoresNotifier(this._scoringService) : super(const AsyncValue.data(null));
  
  final HrvScoringService _scoringService;

  /// Calculate HRV scores from metrics
  Future<HrvScores> calculateScores(
    HrvMetrics metrics, {
    int? age,
    String? gender,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      final scores = _scoringService.calculateScores(
        metrics,
        age: age,
        gender: gender,
      );
      state = AsyncValue.data(scores);
      return scores;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

/// Provider for HRV scores calculation notifier
final hrvScoresNotifierProvider = StateNotifierProvider<HrvScoresNotifier, AsyncValue<HrvScores?>>((ref) {
  final scoringService = ref.watch(hrvScoringServiceProvider);
  return HrvScoresNotifier(scoringService);
});

/// State notifier for complete HRV reading processing
class HrvReadingNotifier extends StateNotifier<AsyncValue<HrvReading?>> {
  HrvReadingNotifier(this._ref) : super(const AsyncValue.data(null));
  
  final Ref _ref;

  /// Process RR intervals into complete HRV reading
  Future<HrvReading> processReading({
    required List<double> rrIntervals,
    required DateTime timestamp,
    required int durationSeconds,
    int? age,
    String? gender,
    String? notes,
    List<String>? tags,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      // Calculate metrics
      final metricsNotifier = _ref.read(hrvMetricsNotifierProvider.notifier);
      final metrics = await metricsNotifier.calculateMetrics(rrIntervals);
      
      // Calculate scores
      final scoresNotifier = _ref.read(hrvScoresNotifierProvider.notifier);
      final scores = await scoresNotifier.calculateScores(
        metrics,
        age: age,
        gender: gender,
      );
      
      // Create complete reading
      final reading = HrvReading(
        id: _generateId(),
        timestamp: timestamp,
        durationSeconds: durationSeconds,
        metrics: metrics,
        rrIntervals: rrIntervals,
        scores: scores,
        notes: notes,
        tags: tags,
        // isSynced: false, // Default value
      );
      
      state = AsyncValue.data(reading);
      return reading;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  /// Generate unique ID for HRV reading
  String _generateId() {
    return 'hrv_${DateTime.now().millisecondsSinceEpoch}';
  }
}

/// Provider for HRV reading processing notifier
final hrvReadingNotifierProvider = StateNotifierProvider<HrvReadingNotifier, AsyncValue<HrvReading?>>((ref) {
  return HrvReadingNotifier(ref);
});

/// State notifier for HRV data validation
class HrvValidationNotifier extends StateNotifier<bool> {
  HrvValidationNotifier() : super(true);

  /// Validate RR intervals for HRV analysis
  bool validateRrIntervals(List<double> rrIntervals) {
    final isValid = _performValidation(rrIntervals);
    state = isValid;
    return isValid;
  }

  /// Get validation error message
  String? getValidationError(List<double> rrIntervals) {
    if (rrIntervals.isEmpty) {
      return 'No RR intervals provided';
    }
    
    if (rrIntervals.length < 2) {
      return 'At least 2 RR intervals required for HRV analysis';
    }
    
    // Check physiological range
    for (final rr in rrIntervals) {
      if (rr < 300) {
        return 'RR interval ${rr.toStringAsFixed(1)}ms is too low (minimum 300ms)';
      }
      if (rr > 2000) {
        return 'RR interval ${rr.toStringAsFixed(1)}ms is too high (maximum 2000ms)';
      }
    }
    
    // Check for extreme outliers
    final sortedRr = List<double>.from(rrIntervals)..sort();
    final median = sortedRr[sortedRr.length ~/ 2];
    final maxDeviation = median * 0.5;
    
    for (final rr in rrIntervals) {
      if ((rr - median).abs() > maxDeviation) {
        return 'RR interval ${rr.toStringAsFixed(1)}ms is an extreme outlier';
      }
    }
    
    return null;
  }

  bool _performValidation(List<double> rrIntervals) {
    // Check minimum length
    if (rrIntervals.length < 2) {
      return false;
    }
    
    // Check physiological range (300-2000ms)
    for (final rr in rrIntervals) {
      if (rr < 300 || rr > 2000) {
        return false;
      }
    }
    
    // Check for extreme outliers (>50% deviation from median)
    final sortedRr = List<double>.from(rrIntervals)..sort();
    final median = sortedRr[sortedRr.length ~/ 2];
    final maxDeviation = median * 0.5;
    
    for (final rr in rrIntervals) {
      if ((rr - median).abs() > maxDeviation) {
        return false;
      }
    }
    
    return true;
  }
}

/// Provider for HRV validation notifier
final hrvValidationNotifierProvider = StateNotifierProvider<HrvValidationNotifier, bool>((ref) {
  return HrvValidationNotifier();
});

/// Provider for quick HRV metrics calculation (one-shot)
final hrvMetricsProvider = FutureProvider.family<HrvMetrics, List<double>>((ref, rrIntervals) async {
  final calculationService = ref.watch(hrvCalculationServiceProvider);
  return calculationService.calculateMetrics(rrIntervals);
});

/// Provider for quick HRV scores calculation (one-shot)
final hrvScoresProvider = FutureProvider.family<HrvScores, ({HrvMetrics metrics, int? age, String? gender})>((ref, params) async {
  final scoringService = ref.watch(hrvScoringServiceProvider);
  return scoringService.calculateScores(
    params.metrics,
    age: params.age,
    gender: params.gender,
  );
});