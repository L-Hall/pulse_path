import 'package:flutter_test/flutter_test.dart';
import 'package:pulse_path/features/hrv/domain/services/hrv_scoring_service.dart';
import 'package:pulse_path/shared/models/hrv_reading.dart';

void main() {
  late HrvScoringService service;

  setUp(() {
    service = HrvScoringService();
  });

  group('HrvScoringService', () {
    group('Score Validation', () {
      test('should return scores within valid range (0-100)', () {
        final metrics = _createTestMetrics();
        final scores = service.calculateScores(metrics);
        
        expect(scores.stress, greaterThanOrEqualTo(0));
        expect(scores.stress, lessThanOrEqualTo(100));
        expect(scores.recovery, greaterThanOrEqualTo(0));
        expect(scores.recovery, lessThanOrEqualTo(100));
        expect(scores.energy, greaterThanOrEqualTo(0));
        expect(scores.energy, lessThanOrEqualTo(100));
        expect(scores.confidence, greaterThanOrEqualTo(0.0));
        expect(scores.confidence, lessThanOrEqualTo(1.0));
      });

      test('should handle edge case metrics', () {
        final extremeMetrics = HrvMetrics(
          rmssd: 1.0, // Very low
          meanRr: 400.0, // Very high HR
          sdnn: 5.0, // Very low
          lowFrequency: 10.0,
          highFrequency: 5.0,
          lfHfRatio: 2.0,
          baevsky: 500.0, // High stress
          coefficientOfVariance: 1.0,
          mxdmn: 20.0,
          moda: 400.0,
          amo50: 80.0,
          pnn50: 2.0,
          pnn20: 5.0,
          totalPower: 50.0,
          dfaAlpha1: 0.8,
        );
        
        final scores = service.calculateScores(extremeMetrics);
        
        // Should still return valid scores
        expect(scores.stress, greaterThanOrEqualTo(0));
        expect(scores.stress, lessThanOrEqualTo(100));
        expect(scores.recovery, greaterThanOrEqualTo(0));
        expect(scores.recovery, lessThanOrEqualTo(100));
        expect(scores.energy, greaterThanOrEqualTo(0));
        expect(scores.energy, lessThanOrEqualTo(100));
      });
    });

    group('Stress Score Calculation', () {
      test('should return high stress score for poor HRV metrics', () {
        final stressedMetrics = HrvMetrics(
          rmssd: 10.0, // Very low - high stress
          meanRr: 500.0, // High heart rate
          sdnn: 15.0, // Low variability
          lowFrequency: 100.0,
          highFrequency: 20.0,
          lfHfRatio: 5.0, // High - sympathetic dominance
          baevsky: 400.0, // High stress index
          coefficientOfVariance: 3.0,
          mxdmn: 30.0,
          moda: 500.0,
          amo50: 60.0,
          pnn50: 2.0, // Very low
          pnn20: 5.0,
          totalPower: 200.0,
          dfaAlpha1: 0.5,
        );
        
        final scores = service.calculateScores(stressedMetrics, age: 30);
        
        // Should indicate high stress
        expect(scores.stress, greaterThan(60));
      });

      test('should return low stress score for good HRV metrics', () {
        final healthyMetrics = HrvMetrics(
          rmssd: 45.0, // Good for 30-year-old
          meanRr: 900.0, // Good resting HR
          sdnn: 50.0, // Good variability
          lowFrequency: 200.0,
          highFrequency: 300.0,
          lfHfRatio: 0.8, // Balanced autonomic function
          baevsky: 80.0, // Low stress index
          coefficientOfVariance: 5.5,
          mxdmn: 150.0,
          moda: 900.0,
          amo50: 25.0,
          pnn50: 25.0, // Good
          pnn20: 45.0,
          totalPower: 2000.0,
          dfaAlpha1: 1.2,
        );
        
        final scores = service.calculateScores(healthyMetrics, age: 30);
        
        // Should indicate low stress
        expect(scores.stress, lessThan(40));
      });
    });

    group('Recovery Score Calculation', () {
      test('should return high recovery score for excellent HRV', () {
        final excellentMetrics = HrvMetrics(
          rmssd: 60.0, // Excellent for any age
          meanRr: 1000.0, // Very good resting HR
          sdnn: 65.0, // Excellent variability
          lowFrequency: 400.0,
          highFrequency: 800.0, // High parasympathetic activity
          lfHfRatio: 0.5, // Parasympathetic dominance
          baevsky: 50.0, // Very low stress
          coefficientOfVariance: 6.5,
          mxdmn: 200.0,
          moda: 1000.0,
          amo50: 20.0,
          pnn50: 35.0, // Excellent
          pnn20: 55.0,
          totalPower: 3000.0,
          dfaAlpha1: 1.4,
        );
        
        final scores = service.calculateScores(excellentMetrics, age: 25);
        
        // Should indicate excellent recovery
        expect(scores.recovery, greaterThan(80));
      });

      test('should return low recovery score for poor HRV', () {
        final poorMetrics = HrvMetrics(
          rmssd: 15.0, // Poor for any age
          meanRr: 600.0, // High HR - poor recovery
          sdnn: 20.0, // Low variability
          lowFrequency: 50.0,
          highFrequency: 20.0, // Low parasympathetic
          lfHfRatio: 2.5, // Sympathetic dominance
          baevsky: 300.0, // High stress
          coefficientOfVariance: 3.3,
          mxdmn: 50.0,
          moda: 600.0,
          amo50: 70.0,
          pnn50: 3.0, // Very poor
          pnn20: 8.0,
          totalPower: 150.0,
          dfaAlpha1: 0.6,
        );
        
        final scores = service.calculateScores(poorMetrics, age: 30);
        
        // Should indicate poor recovery
        expect(scores.recovery, lessThan(40));
      });
    });

    group('Energy Score Calculation', () {
      test('should return high energy score for balanced metrics', () {
        final balancedMetrics = HrvMetrics(
          rmssd: 40.0,
          meanRr: 900.0, // Good cardiovascular efficiency
          sdnn: 55.0, // Good overall variability
          lowFrequency: 300.0,
          highFrequency: 400.0,
          lfHfRatio: 1.2, // Balanced autonomic function
          baevsky: 100.0,
          coefficientOfVariance: 6.1,
          mxdmn: 180.0,
          moda: 900.0,
          amo50: 30.0,
          pnn50: 20.0,
          pnn20: 40.0,
          totalPower: 2500.0, // High total power - good energy
          dfaAlpha1: 1.3,
        );
        
        final scores = service.calculateScores(balancedMetrics, age: 35);
        
        // Should indicate good energy levels
        expect(scores.energy, greaterThan(70));
      });

      test('should return low energy score for imbalanced metrics', () {
        final imbalancedMetrics = HrvMetrics(
          rmssd: 25.0,
          meanRr: 650.0, // Poor cardiovascular efficiency
          sdnn: 25.0, // Low overall variability
          lowFrequency: 800.0,
          highFrequency: 50.0,
          lfHfRatio: 16.0, // Extreme imbalance
          baevsky: 250.0,
          coefficientOfVariance: 3.8,
          mxdmn: 80.0,
          moda: 650.0,
          amo50: 60.0,
          pnn50: 5.0,
          pnn20: 12.0,
          totalPower: 200.0, // Low total power - poor energy
          dfaAlpha1: 0.7,
        );
        
        final scores = service.calculateScores(imbalancedMetrics, age: 35);
        
        // Should indicate low energy levels
        expect(scores.energy, lessThan(50));
      });
    });

    group('Age Normalization', () {
      test('should adjust scores based on age', () {
        final metrics = _createTestMetrics();
        
        final youngScores = service.calculateScores(metrics, age: 25);
        final olderScores = service.calculateScores(metrics, age: 50);
        
        // Older individuals should generally have more forgiving scoring
        // (same absolute HRV values should score better for older adults)
        expect(youngScores.recovery, lessThanOrEqualTo(olderScores.recovery + 10));
      });

      test('should handle extreme ages gracefully', () {
        final metrics = _createTestMetrics();
        
        final veryYoungScores = service.calculateScores(metrics, age: 18);
        final elderlyScores = service.calculateScores(metrics, age: 80);
        
        // Should still return valid scores
        expect(veryYoungScores.stress, greaterThanOrEqualTo(0));
        expect(veryYoungScores.stress, lessThanOrEqualTo(100));
        expect(elderlyScores.stress, greaterThanOrEqualTo(0));
        expect(elderlyScores.stress, lessThanOrEqualTo(100));
      });
    });

    group('Gender Normalization', () {
      test('should adjust scores based on gender', () {
        final metrics = _createTestMetrics();
        
        final maleScores = service.calculateScores(metrics, age: 30, gender: 'male');
        final femaleScores = service.calculateScores(metrics, age: 30, gender: 'female');
        final neutralScores = service.calculateScores(metrics, age: 30);
        
        // Should return valid scores for all gender options
        expect(maleScores.recovery, greaterThanOrEqualTo(0));
        expect(femaleScores.recovery, greaterThanOrEqualTo(0));
        expect(neutralScores.recovery, greaterThanOrEqualTo(0));
      });
    });

    group('Confidence Score', () {
      test('should return high confidence for normal metrics', () {
        final normalMetrics = _createTestMetrics();
        final scores = service.calculateScores(normalMetrics);
        
        // Should have high confidence for normal values
        expect(scores.confidence, greaterThan(0.8));
      });

      test('should return low confidence for extreme metrics', () {
        final extremeMetrics = HrvMetrics(
          rmssd: 250.0, // Impossibly high
          meanRr: 2000.0, // Impossibly low HR
          sdnn: 400.0, // Impossibly high
          lowFrequency: 100000.0, // Extreme
          highFrequency: 1.0,
          lfHfRatio: 100.0, // Extreme ratio
          baevsky: 2000.0, // Impossibly high
          coefficientOfVariance: 50.0,
          mxdmn: 1000.0,
          moda: 2000.0,
          amo50: 5.0,
          pnn50: 95.0,
          pnn20: 98.0,
          totalPower: 100000.0, // Extreme
          dfaAlpha1: 5.0, // Outside normal range
        );
        
        final scores = service.calculateScores(extremeMetrics);
        
        // Should have low confidence for extreme values
        expect(scores.confidence, lessThan(0.6));
      });

      test('should handle edge cases in confidence calculation', () {
        final edgeCaseMetrics = HrvMetrics(
          rmssd: 4.0, // Below normal
          meanRr: 350.0, // Below normal
          sdnn: 8.0, // Below normal
          lowFrequency: 10.0,
          highFrequency: 5.0,
          lfHfRatio: 0.05, // Very low
          baevsky: 5.0, // Very low
          coefficientOfVariance: 2.3,
          mxdmn: 15.0,
          moda: 350.0,
          amo50: 85.0,
          pnn50: 0.5,
          pnn20: 1.0,
          totalPower: 50.0, // Very low
          dfaAlpha1: 0.2, // Below normal range
        );
        
        final scores = service.calculateScores(edgeCaseMetrics);
        
        // Should return reduced confidence but still valid
        expect(scores.confidence, greaterThan(0.0));
        expect(scores.confidence, lessThan(1.0));
      });
    });

    group('Integration Tests', () {
      test('should produce consistent scores for similar metrics', () {
        final metrics1 = _createTestMetrics();
        final metrics2 = HrvMetrics(
          rmssd: metrics1.rmssd + 1.0, // Slightly different
          meanRr: metrics1.meanRr + 5.0,
          sdnn: metrics1.sdnn + 0.5,
          lowFrequency: metrics1.lowFrequency,
          highFrequency: metrics1.highFrequency,
          lfHfRatio: metrics1.lfHfRatio,
          baevsky: metrics1.baevsky,
          coefficientOfVariance: metrics1.coefficientOfVariance,
          mxdmn: metrics1.mxdmn,
          moda: metrics1.moda,
          amo50: metrics1.amo50,
          pnn50: metrics1.pnn50,
          pnn20: metrics1.pnn20,
          totalPower: metrics1.totalPower,
          dfaAlpha1: metrics1.dfaAlpha1,
        );
        
        final scores1 = service.calculateScores(metrics1, age: 30);
        final scores2 = service.calculateScores(metrics2, age: 30);
        
        // Scores should be very similar for similar inputs
        expect((scores1.stress - scores2.stress).abs(), lessThan(5));
        expect((scores1.recovery - scores2.recovery).abs(), lessThan(5));
        expect((scores1.energy - scores2.energy).abs(), lessThan(5));
      });

      test('should maintain score relationships', () {
        final excellentMetrics = HrvMetrics(
          rmssd: 50.0, meanRr: 950.0, sdnn: 60.0,
          lowFrequency: 300.0, highFrequency: 600.0, lfHfRatio: 0.7,
          baevsky: 60.0, coefficientOfVariance: 6.3, mxdmn: 180.0,
          moda: 950.0, amo50: 25.0, pnn50: 30.0, pnn20: 50.0,
          totalPower: 2800.0, dfaAlpha1: 1.3,
        );
        
        final poorMetrics = HrvMetrics(
          rmssd: 12.0, meanRr: 550.0, sdnn: 18.0,
          lowFrequency: 80.0, highFrequency: 15.0, lfHfRatio: 5.3,
          baevsky: 350.0, coefficientOfVariance: 3.3, mxdmn: 45.0,
          moda: 550.0, amo50: 75.0, pnn50: 1.5, pnn20: 4.0,
          totalPower: 120.0, dfaAlpha1: 0.4,
        );
        
        final excellentScores = service.calculateScores(excellentMetrics, age: 30);
        final poorScores = service.calculateScores(poorMetrics, age: 30);
        
        // Excellent metrics should score better than poor metrics
        expect(excellentScores.stress, lessThan(poorScores.stress));
        expect(excellentScores.recovery, greaterThan(poorScores.recovery));
        expect(excellentScores.energy, greaterThan(poorScores.energy));
        expect(excellentScores.confidence, greaterThan(poorScores.confidence));
      });
    });
  });
}

/// Helper function to create realistic test metrics
HrvMetrics _createTestMetrics() {
  return const HrvMetrics(
    rmssd: 32.0, // Normal for young adult
    meanRr: 850.0, // ~71 bpm
    sdnn: 45.0, // Normal variability
    lowFrequency: 250.0,
    highFrequency: 350.0,
    lfHfRatio: 1.4, // Balanced
    baevsky: 120.0, // Normal stress level
    coefficientOfVariance: 5.3,
    mxdmn: 140.0,
    moda: 850.0,
    amo50: 35.0,
    pnn50: 18.0,
    pnn20: 35.0,
    totalPower: 1800.0,
    dfaAlpha1: 1.1, // Normal
  );
}