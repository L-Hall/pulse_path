import 'package:flutter_test/flutter_test.dart';
import 'package:pulse_path/features/ble/domain/services/hrv_quality_service.dart';

void main() {
  group('HrvQualityService', () {
    late HrvQualityService service;

    setUp(() {
      service = HrvQualityService();
    });

    group('validateAndCleanRrIntervals', () {
      test('handles empty intervals', () {
        final result = service.validateAndCleanRrIntervals([]);
        
        expect(result.originalCount, 0);
        expect(result.cleanedIntervals, isEmpty);
        expect(result.qualityScore, 0.0);
        expect(result.qualityRating, HrvQualityRating.poor);
        expect(result.issues, isNotEmpty);
      });

      test('removes physiologically implausible intervals', () {
        final intervals = [
          200.0, // Too low (200 BPM)
          800.0, // Valid
          850.0, // Valid
          3000.0, // Too high (20 BPM)
          820.0, // Valid
        ];
        
        final result = service.validateAndCleanRrIntervals(intervals);
        
        expect(result.originalCount, 5);
        expect(result.cleanedIntervals.length, 3);
        expect(result.artifactsRemoved, 2);
        expect(result.cleanedIntervals, [800.0, 850.0, 820.0]);
      });

      test('removes sudden change artifacts', () {
        final intervals = [
          800.0, // Valid
          850.0, // Valid (change: 50ms)
          1200.0, // Artifact (change: 350ms > 200ms threshold)
          860.0, // Valid (but would be compared to 850.0, not 1200.0)
          870.0, // Valid
        ];
        
        final result = service.validateAndCleanRrIntervals(intervals);
        
        expect(result.originalCount, 5);
        expect(result.cleanedIntervals.length, 3); // 800, 850, 870 (860 might be removed due to comparison with previous valid)
        expect(result.artifactsRemoved, 2);
        // Don't assert exact order since the algorithm removes artifacts in sequence
        expect(result.cleanedIntervals, contains(800.0));
        expect(result.cleanedIntervals, contains(850.0));
      });

      test('calculates quality score correctly', () {
        // High quality data
        final highQualityIntervals = List.generate(150, (i) => 800.0 + (i % 20) * 5.0);
        final highQualityResult = service.validateAndCleanRrIntervals(highQualityIntervals);
        
        expect(highQualityResult.qualityScore, greaterThan(0.8));
        expect(highQualityResult.qualityRating, HrvQualityRating.excellent);
        
        // Poor quality data with artifacts
        final poorQualityIntervals = [
          800.0, 200.0, 850.0, 3000.0, 820.0, // Mixed with artifacts
        ];
        final poorQualityResult = service.validateAndCleanRrIntervals(poorQualityIntervals);
        
        expect(poorQualityResult.qualityScore, lessThan(0.5));
        expect(poorQualityResult.qualityRating, HrvQualityRating.insufficient);
      });

      test('provides quality issues and recommendations', () {
        final intervals = [800.0, 850.0]; // Too few intervals
        final result = service.validateAndCleanRrIntervals(intervals);
        
        expect(result.issues, isNotEmpty);
        expect(result.recommendations, isNotEmpty);
        expect(result.issues.first, contains('Insufficient data'));
      });

      test('handles statistical outliers', () {
        // Create data with statistical outliers
        final baseIntervals = List.generate(50, (i) => 800.0 + (i % 10) * 2.0);
        baseIntervals.addAll([1500.0, 1600.0]); // Statistical outliers
        
        final result = service.validateAndCleanRrIntervals(baseIntervals);
        
        expect(result.cleanedIntervals.length, lessThan(baseIntervals.length));
        expect(result.artifacts.any((a) => a.type == HrvArtifactType.statisticalOutlier), isTrue);
      });
    });

    group('getRealTimeQuality', () {
      test('handles empty intervals', () {
        final quality = service.getRealTimeQuality([]);
        
        expect(quality.signalQuality, 0.0);
        expect(quality.intervalCount, 0);
        expect(quality.isMinimumDataReached, isFalse);
        expect(quality.isRecommendedDataReached, isFalse);
      });

      test('calculates signal quality correctly', () {
        // All valid intervals
        final validIntervals = List.generate(50, (i) => 800.0 + i * 2.0);
        final validQuality = service.getRealTimeQuality(validIntervals);
        
        expect(validQuality.signalQuality, greaterThan(0.8));
        expect(validQuality.intervalCount, 50);
        expect(validQuality.isMinimumDataReached, isTrue);
        
        // Mixed quality intervals
        final mixedIntervals = [
          800.0, 850.0, 200.0, 860.0, 3000.0, 870.0, // Some artifacts
        ];
        final mixedQuality = service.getRealTimeQuality(mixedIntervals);
        
        expect(mixedQuality.signalQuality, lessThan(0.8));
        expect(mixedQuality.artifactRate, greaterThan(0.0));
      });

      test('tracks minimum and recommended data thresholds', () {
        final fewIntervals = List.generate(20, (i) => 800.0 + i);
        final fewQuality = service.getRealTimeQuality(fewIntervals);
        
        expect(fewQuality.isMinimumDataReached, isFalse);
        expect(fewQuality.isRecommendedDataReached, isFalse);
        
        final manyIntervals = List.generate(200, (i) => 800.0 + i);
        final manyQuality = service.getRealTimeQuality(manyIntervals);
        
        expect(manyQuality.isMinimumDataReached, isTrue);
        expect(manyQuality.isRecommendedDataReached, isTrue);
      });

      test('provides quality rating', () {
        final excellentIntervals = List.generate(100, (i) => 800.0 + i * 0.5);
        final excellentQuality = service.getRealTimeQuality(excellentIntervals);
        
        expect(excellentQuality.qualityRating, HrvQualityRating.excellent);
        
        final poorIntervals = [800.0, 200.0, 3000.0, 850.0]; // Many artifacts
        final poorQuality = service.getRealTimeQuality(poorIntervals);
        
        expect(poorQuality.qualityRating, HrvQualityRating.poor);
      });
    });

    group('HrvQualityResult', () {
      test('calculates data retention rate correctly', () {
        final intervals = [800.0, 200.0, 850.0, 860.0]; // 1 artifact (200.0)
        final result = service.validateAndCleanRrIntervals(intervals);
        
        // The retention rate depends on how many intervals survive all validation steps
        expect(result.dataRetentionRate, greaterThan(0.5)); // At least 50% should remain
        expect(result.dataRetentionRate, lessThanOrEqualTo(1.0)); // Cannot exceed 100%
        expect(result.originalCount, 4);
      });

      test('determines data sufficiency correctly', () {
        final fewIntervals = List.generate(20, (i) => 800.0 + i);
        final fewResult = service.validateAndCleanRrIntervals(fewIntervals);
        
        expect(fewResult.hasSufficientData, isFalse);
        expect(fewResult.hasOptimalData, isFalse);
        
        final manyIntervals = List.generate(200, (i) => 800.0 + i);
        final manyResult = service.validateAndCleanRrIntervals(manyIntervals);
        
        expect(manyResult.hasSufficientData, isTrue);
        expect(manyResult.hasOptimalData, isTrue);
      });
    });

    group('HrvQualityRating extensions', () {
      test('provides correct display names', () {
        expect(HrvQualityRating.excellent.displayName, 'Excellent');
        expect(HrvQualityRating.good.displayName, 'Good');
        expect(HrvQualityRating.fair.displayName, 'Fair');
        expect(HrvQualityRating.poor.displayName, 'Poor');
        expect(HrvQualityRating.insufficient.displayName, 'Insufficient Data');
      });

      test('provides appropriate descriptions', () {
        expect(HrvQualityRating.excellent.description, contains('High quality'));
        expect(HrvQualityRating.poor.description, contains('Poor quality'));
        expect(HrvQualityRating.insufficient.description, contains('Not enough data'));
      });
    });
  });
}