import 'package:flutter_test/flutter_test.dart';
import '../../lib/core/services/performance_monitoring_service.dart';
import '../../lib/core/services/error_handling_service.dart';
import '../../lib/core/services/logging_service.dart';
import '../../lib/features/hrv/domain/services/hrv_calculation_service.dart';
import '../../lib/features/hrv/domain/services/hrv_scoring_service.dart';
import '../support/test_utils.dart';
import '../support/mock_data_service.dart';

/// Comprehensive performance test suite for PulsePath core services
/// Ensures all critical operations meet performance benchmarks
void main() {
  group('Performance Test Suite', () {
    late TestUtils testUtils;
    late MockDataService mockDataService;
    late PerformanceMonitoringService perfMonitor;

    setUpAll(() async {
      testUtils = TestUtils();
      mockDataService = MockDataService();
      await testUtils.initializeTestEnvironment(enableLogging: false);
      
      perfMonitor = PerformanceMonitoringService();
      await perfMonitor.initialize();
    });

    tearDownAll(() async {
      perfMonitor.dispose();
      await testUtils.cleanupTestEnvironment();
    });

    group('HRV Calculation Performance', () {
      late HrvCalculationService calculationService;
      
      setUp(() {
        calculationService = HrvCalculationService();
      });

      test('RMSSD calculation completes within threshold', () async {
        final rrIntervals = List.generate(180, (index) => 800.0 + (index % 200));
        
        await testUtils.verifyPerformance(
          () async => calculationService.calculateMetrics(rrIntervals),
          const Duration(milliseconds: 50),
          operationName: 'HRV metrics calculation (180 intervals)',
        );
      });

      test('Complete HRV metrics calculation meets performance target', () async {
        final rrIntervals = List.generate(300, (index) => 700.0 + (index % 400));
        
        await testUtils.verifyPerformance(
          () async => calculationService.calculateMetrics(rrIntervals),
          PerformanceBenchmarks.maxHrvCalculation,
          operationName: 'Complete HRV metrics calculation',
        );
      });

      test('Large dataset calculation performance', () async {
        final largeDataset = List.generate(1000, (index) => 600.0 + (index % 600));
        
        await testUtils.verifyPerformance(
          () async => calculationService.calculateMetrics(largeDataset),
          const Duration(milliseconds: 200),
          operationName: 'HRV metrics calculation (1000 intervals)',
        );
      });

      test('Memory usage remains stable during repeated calculations', () async {
        final rrIntervals = List.generate(200, (index) => 800.0 + (index % 300));
        
        // Perform multiple calculations to test memory stability
        for (int i = 0; i < 100; i++) {
          calculationService.calculateMetrics(rrIntervals);
          await calculationService.calculateSDNN(rrIntervals);
        }
        
        // Verify no memory leaks by checking performance monitor
        final healthStatus = perfMonitor.getSystemHealth();
        expect(healthStatus['memory_usage_mb'], lessThan(200)); // Should be under 200MB
      });
    });

    group('HRV Scoring Performance', () {
      late HrvScoringService scoringService;
      
      setUp(() {
        scoringService = HrvScoringService();
      });

      test('Stress score calculation performance', () async {
        await testUtils.verifyPerformance(
          () async => scoringService.calculateStressScore(rmssd: 45.0, age: 30),
          const Duration(milliseconds: 10),
          operationName: 'Stress score calculation',
        );
      });

      test('Recovery score calculation performance', () async {
        await testUtils.verifyPerformance(
          () async => scoringService.calculateRecoveryScore(rmssd: 45.0, age: 30, gender: 'male'),
          const Duration(milliseconds: 10),
          operationName: 'Recovery score calculation',
        );
      });

      test('Energy score calculation performance', () async {
        await testUtils.verifyPerformance(
          () async => scoringService.calculateEnergyScore(
            rmssd: 45.0,
            meanRr: 850.0,
            age: 30,
            fitnessLevel: 'moderate',
          ),
          const Duration(milliseconds: 10),
          operationName: 'Energy score calculation',
        );
      });

      test('Batch scoring performance', () async {
        final readings = mockDataService.generateHrvTimeSeries(
          startDate: DateTime.now().subtract(const Duration(days: 7)),
          endDate: DateTime.now(),
          averageReadingsPerDay: 5,
        );
        
        await testUtils.verifyPerformance(
          () async {
            for (final reading in readings) {
              await scoringService.calculateStressScore(rmssd: reading.metrics.rmssd, age: 30);
              await scoringService.calculateRecoveryScore(rmssd: reading.metrics.rmssd, age: 30, gender: 'male');
              await scoringService.calculateEnergyScore(
                rmssd: reading.metrics.rmssd,
                meanRr: reading.metrics.meanRr,
                age: 30,
                fitnessLevel: 'moderate',
              );
            }
          },
          const Duration(milliseconds: 500),
          operationName: 'Batch scoring (${readings.length} readings)',
        );
      });
    });

    group('Service Initialization Performance', () {
      test('Error handling service initialization', () async {
        await testUtils.verifyPerformance(
          () async {
            final service = ErrorHandlingService();
            service.initialize();
          },
          const Duration(milliseconds: 100),
          operationName: 'ErrorHandlingService initialization',
        );
      });

      test('Logging service initialization', () async {
        await testUtils.verifyPerformance(
          () async {
            final service = LoggingService();
            await service.initialize(enableFileLogging: false);
          },
          const Duration(milliseconds: 500),
          operationName: 'LoggingService initialization',
        );
      });

      test('Performance monitoring service initialization', () async {
        await testUtils.verifyPerformance(
          () async {
            final service = PerformanceMonitoringService();
            await service.initialize();
            service.dispose();
          },
          const Duration(milliseconds: 200),
          operationName: 'PerformanceMonitoringService initialization',
        );
      });
    });

    group('Data Processing Performance', () {
      test('Mock data generation performance', () async {
        await testUtils.verifyPerformance(
          () async {
            mockDataService.generateHrvTimeSeries(
              startDate: DateTime.now().subtract(const Duration(days: 30)),
              endDate: DateTime.now(),
              averageReadingsPerDay: 3,
            );
          },
          const Duration(milliseconds: 1000),
          operationName: 'Generate 30-day HRV time series',
        );
      });

      test('Dashboard data generation performance', () async {
        await testUtils.verifyPerformance(
          () async {
            mockDataService.generateMockDashboardData(trendDays: 30);
          },
          const Duration(milliseconds: 2000),
          operationName: 'Generate mock dashboard data',
        );
      });

      test('Large dataset processing', () async {
        final largeTimeSeries = mockDataService.generateHrvTimeSeries(
          startDate: DateTime.now().subtract(const Duration(days: 365)),
          endDate: DateTime.now(),
          averageReadingsPerDay: 5,
        );
        
        await testUtils.verifyPerformance(
          () async {
            // Simulate processing all readings
            double totalRmssd = 0;
            for (final reading in largeTimeSeries) {
              totalRmssd += reading.rmssd;
            }
            final averageRmssd = totalRmssd / largeTimeSeries.length;
            expect(averageRmssd, greaterThan(0));
          },
          const Duration(milliseconds: 500),
          operationName: 'Process large dataset (${largeTimeSeries.length} readings)',
        );
      });
    });

    group('Memory Management Performance', () {
      test('Service cleanup prevents memory leaks', () async {
        final initialHealth = perfMonitor.getSystemHealth();
        final initialMemory = initialHealth['memory_usage_mb'] as double? ?? 0;
        
        // Create and dispose multiple services
        for (int i = 0; i < 10; i++) {
          final tempPerfMonitor = PerformanceMonitoringService();
          await tempPerfMonitor.initialize();
          tempPerfMonitor.dispose();
        }
        
        // Check memory hasn't grown significantly
        final finalHealth = perfMonitor.getSystemHealth();
        final finalMemory = finalHealth['memory_usage_mb'] as double? ?? 0;
        
        expect(finalMemory - initialMemory, lessThan(50)); // Less than 50MB growth
      });

      test('Performance metrics collection efficiency', () async {
        perfMonitor.clearMetrics();
        
        // Record many metrics
        await testUtils.verifyPerformance(
          () async {
            for (int i = 0; i < 1000; i++) {
              perfMonitor.recordMetric(PerformanceMetric.widgetBuild, i.toDouble());
            }
          },
          const Duration(milliseconds: 100),
          operationName: 'Record 1000 performance metrics',
        );
        
        // Verify metrics are stored efficiently
        final stats = perfMonitor.getMetricStatistics(PerformanceMetric.widgetBuild);
        expect(stats['count'], equals(1000));
      });
    });

    group('Error Handling Performance', () {
      test('Error logging performance', () async {
        final errorService = testUtils.serviceLocator<ErrorHandlingService>();
        
        await testUtils.verifyPerformance(
          () async {
            for (int i = 0; i < 100; i++) {
              errorService.logError(
                'Test error $i',
                category: ErrorCategory.general,
                context: {'iteration': i},
              );
            }
          },
          const Duration(milliseconds: 500),
          operationName: 'Log 100 errors',
        );
      });

      test('Exception handling overhead', () async {
        await testUtils.verifyPerformance(
          () async {
            for (int i = 0; i < 100; i++) {
              try {
                throw Exception('Test exception $i');
              } catch (e) {
                // Simulate error handling
              }
            }
          },
          const Duration(milliseconds: 50),
          operationName: 'Handle 100 exceptions',
        );
      });
    });

    group('Performance Monitoring Overhead', () {
      test('Timer operations have minimal overhead', () async {
        await testUtils.verifyPerformance(
          () async {
            for (int i = 0; i < 100; i++) {
              perfMonitor.startTimer('test_$i', PerformanceMetric.widgetBuild);
              perfMonitor.stopTimer('test_$i', PerformanceMetric.widgetBuild);
            }
          },
          const Duration(milliseconds: 100),
          operationName: '100 timer start/stop cycles',
        );
      });

      test('Performance reporting generation', () async {
        // Generate some test metrics
        for (int i = 0; i < 50; i++) {
          perfMonitor.recordMetric(PerformanceMetric.widgetBuild, i.toDouble());
          perfMonitor.recordMetric(PerformanceMetric.databaseQuery, (i * 2).toDouble());
        }
        
        await testUtils.verifyPerformance(
          () async {
            final report = perfMonitor.getPerformanceReport();
            expect(report['metrics'], isNotEmpty);
          },
          const Duration(milliseconds: 50),
          operationName: 'Generate performance report',
        );
      });
    });
  });
}