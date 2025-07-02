import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../../data/repositories/dashboard_repository.dart';
import '../../data/repositories/simple_hrv_repository.dart';
import '../../domain/models/dashboard_data.dart';
import '../../../../core/di/injection_container.dart';

/// Provider for the simple HRV repository
final simpleHrvRepositoryProvider = Provider<SimpleHrvRepository>((ref) {
  return sl<SimpleHrvRepository>();
});

/// Provider for the dashboard repository - handles both sync and async cases with timeout
final dashboardRepositoryProvider = FutureProvider<DashboardRepository>((ref) async {
  debugPrint('🔄 DashboardRepository provider starting...');
  try {
    if (kIsWeb) {
      debugPrint('📱 Web platform - getting sync repository');
      // On web, repository is sync (no timeout needed)
      final repo = sl<DashboardRepository>();
      debugPrint('✅ Web repository obtained successfully');
      return repo;
    } else {
      debugPrint('📱 Mobile/Desktop platform - getting async repository with timeout');
      // On mobile/desktop, repository is async with timeout
      final repo = await sl.getAsync<DashboardRepository>()
          .timeout(const Duration(seconds: 5));
      debugPrint('✅ Mobile repository obtained successfully');
      return repo;
    }
  } catch (e) {
    debugPrint('❌ Failed to get DashboardRepository: $e');
    debugPrint('🔄 Creating fallback repository...');
    // Fallback to simple repository
    try {
      final simpleRepo = sl<SimpleHrvRepository>();
      final fallbackRepo = DashboardRepository(simpleRepo);
      debugPrint('✅ Fallback repository created successfully');
      return fallbackRepo;
    } catch (fallbackError) {
      debugPrint('❌ Fallback repository creation failed: $fallbackError');
      rethrow;
    }
  }
});

/// Provider for dashboard data - main state for the dashboard page with timeout and fallback
final dashboardDataProvider = FutureProvider<DashboardData>((ref) async {
  debugPrint('🔄 DashboardData provider starting...');
  try {
    debugPrint('⏳ Waiting for repository with timeout...');
    final repository = await ref.watch(dashboardRepositoryProvider.future)
        .timeout(const Duration(seconds: 3));
    debugPrint('✅ Repository obtained, getting dashboard data...');
    final data = await repository.getDashboardData()
        .timeout(const Duration(seconds: 2));
    debugPrint('✅ Dashboard data loaded successfully: ${data.trendReadings.length} readings');
    return data;
  } catch (e) {
    debugPrint('❌ Dashboard data provider error: $e');
    debugPrint('🔄 Creating empty fallback data...');
    // Return fallback data with graceful error handling
    final emptyData = DashboardData.empty();
    debugPrint('✅ Fallback data created');
    return emptyData;
  }
});

/// Provider for dashboard refresh functionality
final dashboardRefreshProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    ref.invalidate(dashboardDataProvider);
  };
});