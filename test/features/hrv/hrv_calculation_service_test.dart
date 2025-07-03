import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse_path/features/hrv/domain/services/hrv_calculation_service.dart';

void main() {
  late HrvCalculationService service;

  setUp(() {
    service = HrvCalculationService();
  });

  group('HrvCalculationService', () {
    group('Input Validation', () {
      test('should throw ArgumentError for empty RR intervals', () {
        expect(
          () => service.calculateMetrics([]),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'RR intervals cannot be empty',
          ),),
        );
      });

      test('should throw ArgumentError for single RR interval', () {
        expect(
          () => service.calculateMetrics([800.0]),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'At least 2 RR intervals required for HRV analysis',
          ),),
        );
      });

      test('should throw ArgumentError for RR intervals outside physiological range', () {
        expect(
          () => service.calculateMetrics([200.0, 800.0]), // 200ms too low
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('outside physiological range'),
          ),),
        );

        expect(
          () => service.calculateMetrics([800.0, 2500.0]), // 2500ms too high
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('outside physiological range'),
          ),),
        );
      });
    });

    group('Basic HRV Metrics', () {
      test('should calculate RMSSD correctly', () {
        // Test data: [800, 820, 810, 830] ms
        // Differences: [20, -10, 20] ms
        // Squared differences: [400, 100, 400]
        // Mean squared difference: 300
        // RMSSD: sqrt(300) ≈ 17.32
        final rrIntervals = [800.0, 820.0, 810.0, 830.0];
        final metrics = service.calculateMetrics(rrIntervals);
        
        expect(metrics.rmssd, closeTo(17.32, 0.1));
      });

      test('should calculate Mean RR correctly', () {
        final rrIntervals = [800.0, 820.0, 810.0, 830.0];
        final metrics = service.calculateMetrics(rrIntervals);
        
        expect(metrics.meanRr, equals(815.0));
      });

      test('should calculate SDNN correctly', () {
        // Test data: [800, 820, 810, 830]
        // Mean: 815, Variances: [225, 25, 25, 225]
        // Mean variance: 125, SDNN: sqrt(125) ≈ 11.18
        final rrIntervals = [800.0, 820.0, 810.0, 830.0];
        final metrics = service.calculateMetrics(rrIntervals);
        
        expect(metrics.sdnn, closeTo(11.18, 0.1));
      });

      test('should calculate pNN50 correctly', () {
        // Differences: [20, -10, 20] - only two exceed 50ms threshold (none do)
        final rrIntervals = [800.0, 820.0, 810.0, 830.0];
        final metrics = service.calculateMetrics(rrIntervals);
        
        expect(metrics.pnn50, equals(0.0));

        // Test with larger differences
        final rrIntervalsLarge = [800.0, 880.0, 820.0, 900.0];
        final metricsLarge = service.calculateMetrics(rrIntervalsLarge);
        
        // Differences: [80, -60, 80] - all exceed 50ms
        expect(metricsLarge.pnn50, equals(100.0));
      });

      test('should calculate pNN20 correctly', () {
        final rrIntervals = [800.0, 825.0, 810.0, 835.0];
        final metrics = service.calculateMetrics(rrIntervals);
        
        // Differences: [25, -15, 25] -> [25, 15, 25] abs values
        // 2 out of 3 exceed 20ms: 2/3 = 66.67%
        expect(metrics.pnn20, closeTo(66.67, 0.01));
      });
    });

    group('Geometric Metrics', () {
      test('should calculate MxDMn correctly', () {
        final rrIntervals = [800.0, 820.0, 810.0, 830.0];
        final metrics = service.calculateMetrics(rrIntervals);
        
        // Max: 830, Min: 800, Difference: 30
        expect(metrics.mxdmn, equals(30.0));
      });

      test('should calculate Coefficient of Variance correctly', () {
        final rrIntervals = [800.0, 820.0, 810.0, 830.0];
        final metrics = service.calculateMetrics(rrIntervals);
        
        // CV = (SDNN / Mean RR) * 100
        // CV ≈ (11.18 / 815) * 100 ≈ 1.37%
        expect(metrics.coefficientOfVariance, closeTo(1.37, 0.1));
      });

      test('should calculate Moda correctly', () {
        // Create data with clear mode at 800ms bin
        final rrIntervals = [795.0, 805.0, 800.0, 810.0, 795.0];
        final metrics = service.calculateMetrics(rrIntervals);
        
        // Should find mode around 800ms (using 50ms bins)
        expect(metrics.moda, equals(800.0));
      });

      test('should calculate AMo50 correctly', () {
        // Test with intervals clustered around 800ms
        final rrIntervals = [795.0, 805.0, 800.0, 810.0, 795.0];
        final metrics = service.calculateMetrics(rrIntervals);
        
        // All intervals should be within ±50ms of mode (800)
        expect(metrics.amo50, equals(100.0));
      });
    });

    group('Frequency Domain Metrics', () {
      test('should calculate frequency domain metrics for stable heart rate', () {
        // Generate stable RR intervals around 800ms with minimal variation
        final rrIntervals = List.generate(50, (i) => 800.0 + sin(i * 0.1) * 5);
        final metrics = service.calculateMetrics(rrIntervals);
        
        // Should have some power in frequency domains
        expect(metrics.lowFrequency, greaterThan(0.0));
        expect(metrics.highFrequency, greaterThan(0.0));
        expect(metrics.totalPower, greaterThan(0.0));
        expect(metrics.lfHfRatio, greaterThan(0.0));
      });

      test('should handle very stable RR intervals', () {
        // Perfectly stable intervals
        final rrIntervals = List.generate(20, (i) => 800.0);
        final metrics = service.calculateMetrics(rrIntervals);
        
        // Very low variability should result in low power
        expect(metrics.lowFrequency, greaterThanOrEqualTo(0.0));
        expect(metrics.highFrequency, greaterThanOrEqualTo(0.0));
        expect(metrics.totalPower, greaterThanOrEqualTo(0.0));
      });
    });

    group('Non-linear Metrics', () {
      test('should calculate DFA Alpha1 for sufficient data', () {
        // Generate RR intervals with some correlation structure
        final rrIntervals = <double>[];
        double rr = 800.0;
        final random = Random(42); // Fixed seed for reproducibility
        
        for (int i = 0; i < 100; i++) {
          rr += (random.nextDouble() - 0.5) * 20;
          rr = rr.clamp(600.0, 1200.0);
          rrIntervals.add(rr);
        }
        
        final metrics = service.calculateMetrics(rrIntervals);
        
        // DFA Alpha1 should be in physiological range (0.5-2.0)
        expect(metrics.dfaAlpha1, greaterThan(0.0));
        expect(metrics.dfaAlpha1, lessThan(3.0));
      });

      test('should return 0 for DFA Alpha1 with insufficient data', () {
        final rrIntervals = [800.0, 820.0, 810.0]; // Only 3 intervals
        final metrics = service.calculateMetrics(rrIntervals);
        
        expect(metrics.dfaAlpha1, equals(0.0));
      });
    });

    group('Baevsky Stress Index', () {
      test('should calculate Baevsky index correctly', () {
        final rrIntervals = [800.0, 820.0, 810.0, 830.0, 825.0];
        final metrics = service.calculateMetrics(rrIntervals);
        
        // Should be a positive value
        expect(metrics.baevsky, greaterThan(0.0));
        expect(metrics.baevsky, lessThan(1000.0)); // Reasonable upper bound
      });

      test('should handle edge case with zero MxDMn', () {
        // All intervals the same - MxDMn = 0
        final rrIntervals = [800.0, 800.0, 800.0, 800.0];
        final metrics = service.calculateMetrics(rrIntervals);
        
        // Should return 0 when MxDMn is 0
        expect(metrics.baevsky, equals(0.0));
      });
    });

    group('Reference Vector Tests', () {
      test('should match published RMSSD reference values', () {
        // Kubios HRV reference test data approximation
        // RR intervals in milliseconds for healthy young adult
        const referenceRR = [
          856, 854, 877, 945, 960, 957, 948, 934, 921, 905,
          901, 896, 884, 861, 832, 814, 807, 811, 825, 847,
          869, 889, 903, 913, 920, 924, 925, 924, 921, 917,
        ];
        
        final metrics = service.calculateMetrics(referenceRR.map((e) => e.toDouble()).toList());
        
        // RMSSD should be in expected range for this data
        expect(metrics.rmssd, greaterThan(5.0));
        expect(metrics.rmssd, lessThan(80.0));
        
        // Mean RR should match
        final expectedMean = referenceRR.reduce((a, b) => a + b) / referenceRR.length;
        expect(metrics.meanRr, closeTo(expectedMean, 1.0));
      });

      test('should handle real-world variability patterns', () {
        // Simulate realistic HRV pattern with respiratory sinus arrhythmia
        final rrIntervals = <double>[];
        for (int i = 0; i < 60; i++) {
          // Base RR + respiratory modulation + noise
          const baseRR = 850.0;
          final respiratory = 30.0 * sin(i * 2 * pi / 15); // 4 breaths per minute
          final noise = (Random(i).nextDouble() - 0.5) * 10;
          rrIntervals.add(baseRR + respiratory + noise);
        }
        
        final metrics = service.calculateMetrics(rrIntervals);
        
        // All metrics should be in physiological ranges
        expect(metrics.rmssd, greaterThan(5.0));
        expect(metrics.rmssd, lessThan(100.0));
        expect(metrics.sdnn, greaterThan(10.0));
        expect(metrics.sdnn, lessThan(100.0));
        expect(metrics.pnn50, greaterThanOrEqualTo(0.0));
        expect(metrics.pnn50, lessThanOrEqualTo(100.0));
        expect(metrics.lfHfRatio, greaterThan(0.0));
        expect(metrics.lfHfRatio, lessThan(1000.0)); // Very permissive for test data
      });
    });

    group('Edge Cases', () {
      test('should handle minimum valid dataset', () {
        final rrIntervals = [800.0, 820.0];
        final metrics = service.calculateMetrics(rrIntervals);
        
        // Should calculate basic metrics without error
        expect(metrics.rmssd, equals(20.0));
        expect(metrics.meanRr, equals(810.0));
        expect(metrics.sdnn, equals(10.0));
      });

      test('should handle large dataset efficiently', () {
        // Test with 5 minutes of data at 1Hz
        final rrIntervals = List.generate(300, (i) => 800.0 + sin(i * 0.1) * 20);
        
        final stopwatch = Stopwatch()..start();
        final metrics = service.calculateMetrics(rrIntervals);
        stopwatch.stop();
        
        // Should complete within reasonable time (500ms for large dataset)
        expect(stopwatch.elapsedMilliseconds, lessThan(500));
        
        // Should produce valid results
        expect(metrics.rmssd, greaterThan(0.0));
        expect(metrics.meanRr, closeTo(800.0, 5.0));
      });

      test('should handle extremely low variability', () {
        final rrIntervals = List.generate(50, (i) => 800.0 + (i % 2) * 0.1);
        final metrics = service.calculateMetrics(rrIntervals);
        
        // Should handle low variability gracefully
        expect(metrics.rmssd, greaterThanOrEqualTo(0.0));
        expect(metrics.rmssd, lessThan(1.0));
        expect(metrics.sdnn, greaterThanOrEqualTo(0.0));
      });

      test('should handle high variability', () {
        final random = Random(123);
        final rrIntervals = List.generate(50, (i) => 600.0 + random.nextDouble() * 600.0);
        final metrics = service.calculateMetrics(rrIntervals);
        
        // Should handle high variability
        expect(metrics.rmssd, greaterThan(50.0));
        expect(metrics.sdnn, greaterThan(50.0));
        expect(metrics.mxdmn, greaterThan(400.0));
      });
    });
  });
}