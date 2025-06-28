import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/dashboard_repository.dart';
import '../../data/repositories/simple_hrv_repository.dart';
import '../../domain/models/dashboard_data.dart';
import '../../../../core/di/injection_container.dart';

/// Provider for the simple HRV repository
final simpleHrvRepositoryProvider = Provider<SimpleHrvRepository>((ref) {
  return sl<SimpleHrvRepository>();
});

/// Provider for the dashboard repository
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return sl<DashboardRepository>();
});

/// Provider for dashboard data - main state for the dashboard page
final dashboardDataProvider = FutureProvider<DashboardData>((ref) async {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository.getDashboardData();
});

/// Provider for dashboard refresh functionality
final dashboardRefreshProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    ref.invalidate(dashboardDataProvider);
  };
});