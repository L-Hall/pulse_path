import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../../data/repositories/dashboard_repository.dart';
import '../../data/repositories/simple_hrv_repository.dart';
import '../../data/repositories/hrv_repository_interface.dart';
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

/// Provider for data source breakdown to track real vs sample data
final dataSourceBreakdownProvider = FutureProvider<DataSourceBreakdown>((ref) async {
  try {
    final repository = await ref.watch(dashboardRepositoryProvider.future);
    // Access the underlying HRV repository to get breakdown
    final hrvRepo = kIsWeb ? sl<SimpleHrvRepository>() : await sl.getAsync<HrvRepositoryInterface>();
    return await hrvRepo.getDataSourceBreakdown(days: 30);
  } catch (e) {
    debugPrint('❌ Data source breakdown error: $e');
    // Return fallback breakdown indicating only sample data
    return const DataSourceBreakdown(
      realDataCount: 0,
      sampleDataCount: 7,
      totalReadings: 7,
      realDataPercentage: 0.0,
    );
  }
});

/// Provider for smart data mode preference
final smartDataModeProvider = StateProvider<bool>((ref) => true);

/// Provider that determines data filtering based on smart mixing preference and data availability
final smartDataFilterProvider = FutureProvider<bool?>((ref) async {
  final smartModeEnabled = ref.watch(smartDataModeProvider);
  if (!smartModeEnabled) return null; // Show all data when smart mode is disabled
  
  try {
    final breakdown = await ref.watch(dataSourceBreakdownProvider.future);
    
    // Smart mixing logic:
    // - If user has significant real data (>=50%), prioritize real data only
    // - If user has some real data but <50%, show mixed data
    // - If user has no real data, show sample data to avoid empty dashboard
    
    if (breakdown.hasSignificantRealData) {
      debugPrint('🧠 Smart mode: Prioritizing real data (${breakdown.realDataPercentage.toStringAsFixed(1)}% real)');
      return true; // Show only real data
    } else if (breakdown.hasAnyRealData) {
      debugPrint('🧠 Smart mode: Showing mixed data (${breakdown.realDataCount} real readings)');
      return null; // Show all data
    } else {
      debugPrint('🧠 Smart mode: Showing sample data (no real data available)');
      return false; // Show sample data to avoid empty dashboard
    }
  } catch (e) {
    debugPrint('❌ Smart data filter error: $e');
    return null; // Fallback to showing all data
  }
});

/// Enhanced dashboard data provider with smart data mixing
final smartDashboardDataProvider = FutureProvider<DashboardData>((ref) async {
  debugPrint('🔄 Smart dashboard data provider starting...');
  try {
    final smartFilter = await ref.watch(smartDataFilterProvider.future);
    debugPrint('🎯 Smart filter: $smartFilter');
    
    // Access the HRV repository directly for filtering
    final hrvRepo = kIsWeb ? sl<SimpleHrvRepository>() : await sl.getAsync<HrvRepositoryInterface>();
    
    // Get data based on smart filter
    final latestReading = await hrvRepo.getLatestReading(realDataOnly: smartFilter);
    final statistics = await hrvRepo.getStatistics(days: 30, realDataOnly: smartFilter);
    final trendReadings = await hrvRepo.getTrendReadings(days: 7, realDataOnly: smartFilter);
    
    debugPrint('✅ Smart dashboard data loaded: ${trendReadings.length} readings (filter: $smartFilter)');
    
    return DashboardData(
      latestReading: latestReading,
      statistics: statistics,
      trendReadings: trendReadings,
      lastUpdated: DateTime.now(),
    );
  } catch (e) {
    debugPrint('❌ Smart dashboard data error: $e, falling back to regular data');
    // Fallback to regular dashboard data
    return ref.watch(dashboardDataProvider.future);
  }
});