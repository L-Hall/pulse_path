import '../../../../shared/models/hrv_reading.dart';
import 'simple_hrv_repository.dart';

/// Interface for HRV data repositories
/// 
/// Defines the contract that all HRV repositories must implement
/// to be compatible with the dashboard system
abstract class HrvRepositoryInterface {
  /// Add a new reading
  Future<void> saveReading(HrvReading reading);

  /// Get the most recent reading
  Future<HrvReading?> getLatestReading({bool? realDataOnly});

  /// Get readings for the last N days
  Future<List<HrvReading>> getTrendReadings({int days = 7, bool? realDataOnly});

  /// Get basic statistics
  Future<DashboardStatistics> getStatistics({int days = 30, bool? realDataOnly});

  /// Add sample data for demo
  Future<void> addSampleData();

  /// Get real data count to check if user has captured any real readings
  Future<int> getRealDataCount({int days = 30});

  /// Clear all sample data, keeping only real user data
  Future<void> clearSampleData();

  /// Get data source breakdown for analytics
  Future<DataSourceBreakdown> getDataSourceBreakdown({int days = 30});
}

/// Data source breakdown for analytics
class DataSourceBreakdown {
  final int realDataCount;
  final int sampleDataCount;
  final int totalReadings;
  final double realDataPercentage;

  const DataSourceBreakdown({
    required this.realDataCount,
    required this.sampleDataCount,
    required this.totalReadings,
    required this.realDataPercentage,
  });

  /// Check if user has primarily real data
  bool get hasSignificantRealData => realDataPercentage >= 50.0;

  /// Check if user has any real data
  bool get hasAnyRealData => realDataCount > 0;

  /// Check if user has only sample data
  bool get hasOnlySampleData => realDataCount == 0 && sampleDataCount > 0;

  @override
  String toString() {
    return 'DataSourceBreakdown(real: $realDataCount, sample: $sampleDataCount, percentage: ${realDataPercentage.toStringAsFixed(1)}%)';
  }
}