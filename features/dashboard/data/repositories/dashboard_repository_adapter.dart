import '../../../../shared/models/hrv_reading.dart';
import 'database_hrv_repository.dart';
import 'simple_hrv_repository.dart';
import '../../domain/models/dashboard_data.dart';

/// Adapter to make DatabaseHrvRepository compatible with existing DashboardRepository interface
/// 
/// This bridges the gap between the new encrypted database repository
/// and the existing dashboard code that expects SimpleHrvRepository interface
class DashboardRepositoryAdapter {
  final DatabaseHrvRepository _databaseRepository;

  DashboardRepositoryAdapter(this._databaseRepository);

  /// Get dashboard data with statistics and trends
  Future<DashboardData> getDashboardData() async {
    try {
      final statistics = await _databaseRepository.getStatistics();
      final trendReadings = await _databaseRepository.getTrendReadings();
      
      return DashboardData(
        latestReading: await _databaseRepository.getLatestReading(),
        statistics: statistics,
        trendReadings: trendReadings,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      // Return empty dashboard data on error
      return DashboardData(
        latestReading: null,
        statistics: const DashboardStatistics(
          totalReadings: 0,
          averageStress: 0,
          averageRecovery: 0,
          averageEnergy: 0,
          averageRmssd: 0.0,
          averageHeartRate: 0.0,
          streakDays: 0,
        ),
        trendReadings: const [],
        lastUpdated: DateTime.now(),
      );
    }
  }

  /// Get trend readings for the chart
  Future<List<HrvReading>> getTrendReadings({int days = 7}) async {
    return await _databaseRepository.getTrendReadings(days: days);
  }

  /// Get statistics for the dashboard
  Future<DashboardStatistics> getStatistics({int days = 30}) async {
    return await _databaseRepository.getStatistics(days: days);
  }

  /// Get the latest reading
  Future<HrvReading?> getLatestReading() async {
    return await _databaseRepository.getLatestReading();
  }

  /// Save a new reading
  Future<void> saveReading(HrvReading reading) async {
    return await _databaseRepository.saveReading(reading);
  }

  /// Refresh dashboard data (placeholder for any refresh logic)
  Future<void> refresh() async {
    // Database repository doesn't need explicit refresh
    // Data is always current from the database
  }

  /// Add sample data for demo
  Future<void> addSampleData() async {
    return await _databaseRepository.addSampleData();
  }

  /// Get total readings count
  Future<int> getTotalReadingsCount() async {
    return await _databaseRepository.getTotalReadingsCount();
  }

  /// Delete a reading by ID
  Future<bool> deleteReading(String id) async {
    return await _databaseRepository.deleteReading(id);
  }

  /// Get readings within a date range
  Future<List<HrvReading>> getReadingsInRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return await _databaseRepository.getReadingsInRange(
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// Clear all readings
  Future<void> clearAllReadings() async {
    return await _databaseRepository.clearAllReadings();
  }

  /// Dispose resources
  Future<void> dispose() async {
    return await _databaseRepository.dispose();
  }
}