import '../../domain/models/dashboard_data.dart';
import 'simple_hrv_repository.dart';
import '../../../../shared/models/hrv_reading.dart';

/// Repository for dashboard-specific data operations
class DashboardRepository {
  final SimpleHrvRepository _hrvRepository;

  DashboardRepository(this._hrvRepository);

  /// Get dashboard data for the main screen
  Future<DashboardData> getDashboardData() async {
    // Get the latest reading for current scores
    final latestReading = await _hrvRepository.getLatestReading();
    
    // Get statistics for the last 30 days
    final statistics = await _hrvRepository.getStatistics(days: 30);
    
    // Get trend data for the last 7 days
    final trendReadings = await _hrvRepository.getTrendReadings(days: 7);
    
    return DashboardData(
      latestReading: latestReading,
      statistics: statistics,
      trendReadings: trendReadings,
      lastUpdated: DateTime.now(),
    );
  }

  /// Get extended trend data for detailed charts
  Future<List<HrvReading>> getExtendedTrend({int days = 30}) async {
    return _hrvRepository.getTrendReadings(days: days);
  }

  /// Refresh dashboard data
  Future<DashboardData> refreshDashboard() async {
    return getDashboardData();
  }
}