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
  Future<HrvReading?> getLatestReading();

  /// Get readings for the last N days
  Future<List<HrvReading>> getTrendReadings({int days = 7});

  /// Get basic statistics
  Future<DashboardStatistics> getStatistics({int days = 30});

  /// Add sample data for demo
  Future<void> addSampleData();
}