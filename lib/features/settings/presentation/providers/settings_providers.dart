import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/repositories/settings_repository.dart';
import '../../domain/models/user_preferences.dart';
import '../../../../core/di/injection_container.dart';

/// Provider for the settings repository
final settingsRepositoryProvider = FutureProvider<SettingsRepository>((ref) async {
  try {
    return await sl.getAsync<SettingsRepository>();
  } catch (e) {
    // Fallback if settings repository is not available
    final repository = SettingsRepository(sl<FlutterSecureStorage>());
    await repository.initialize();
    return repository;
  }
});

/// Provider for user preferences
final userPreferencesProvider = FutureProvider<UserPreferences>((ref) async {
  final repository = await ref.watch(settingsRepositoryProvider.future);
  return await repository.getUserPreferences();
});

/// Provider for updating user preferences
final userPreferencesNotifierProvider = StateNotifierProvider<UserPreferencesNotifier, AsyncValue<UserPreferences>>((ref) {
  // We need to handle the async repository in the notifier itself
  return UserPreferencesNotifier(ref);
});

/// State notifier for managing user preferences
class UserPreferencesNotifier extends StateNotifier<AsyncValue<UserPreferences>> {
  final Ref _ref;
  SettingsRepository? _repository;

  UserPreferencesNotifier(this._ref) : super(const AsyncValue.loading()) {
    _initializeAndLoad();
  }

  /// Initialize repository and load preferences
  Future<void> _initializeAndLoad() async {
    try {
      _repository = await _ref.read(settingsRepositoryProvider.future);
      await _loadPreferences();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Load initial preferences
  Future<void> _loadPreferences() async {
    try {
      if (_repository == null) return;
      final preferences = await _repository!.getUserPreferences();
      state = AsyncValue.data(preferences);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Update user preferences
  Future<void> updatePreferences(UserPreferences preferences) async {
    try {
      if (_repository == null) return;
      await _repository!.saveUserPreferences(preferences);
      state = AsyncValue.data(preferences);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Update a specific preference field
  Future<void> updatePreference<T>(String key, T value) async {
    try {
      if (_repository == null) return;
      await _repository!.updatePreference(key, value);
      await _loadPreferences(); // Reload to get updated state
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Reset to default preferences
  Future<void> resetToDefaults() async {
    try {
      if (_repository == null) return;
      await _repository!.resetToDefaults();
      await _loadPreferences();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Export preferences as JSON
  Future<String> exportPreferences() async {
    if (_repository == null) throw Exception('Settings repository not initialized');
    return await _repository!.exportPreferences();
  }

  /// Import preferences from JSON
  Future<void> importPreferences(String jsonString) async {
    try {
      if (_repository == null) return;
      await _repository!.importPreferences(jsonString);
      await _loadPreferences();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Update user profile information
  Future<void> updateProfile({
    String? userName,
    String? userEmail,
    int? age,
    UserGender? gender,
    double? heightCm,
    double? weightKg,
    ActivityLevel? activityLevel,
    bool? hasChronicConditions,
    List<String>? medications,
  }) async {
    final currentState = state;
    if (currentState is AsyncData<UserPreferences>) {
      final currentPreferences = currentState.value;
      final updatedPreferences = currentPreferences.copyWith(
        userName: userName ?? currentPreferences.userName,
        userEmail: userEmail ?? currentPreferences.userEmail,
        age: age ?? currentPreferences.age,
        gender: gender ?? currentPreferences.gender,
        heightCm: heightCm ?? currentPreferences.heightCm,
        weightKg: weightKg ?? currentPreferences.weightKg,
        activityLevel: activityLevel ?? currentPreferences.activityLevel,
        hasChronicConditions: hasChronicConditions ?? currentPreferences.hasChronicConditions,
        medications: medications ?? currentPreferences.medications,
      );
      await updatePreferences(updatedPreferences);
    }
  }

  /// Update capture preferences
  Future<void> updateCapturePreferences({
    CaptureMethod? preferredCaptureMethod,
    int? captureTimeSeconds,
    bool? enableCaptureSound,
    bool? enableHapticFeedback,
    bool? enableFlashlight,
    bool? autoStartCapture,
  }) async {
    final currentState = state;
    if (currentState is AsyncData<UserPreferences>) {
      final currentPreferences = currentState.value;
      final updatedPreferences = currentPreferences.copyWith(
        preferredCaptureMethod: preferredCaptureMethod ?? currentPreferences.preferredCaptureMethod,
        captureTimeSeconds: captureTimeSeconds ?? currentPreferences.captureTimeSeconds,
        enableCaptureSound: enableCaptureSound ?? currentPreferences.enableCaptureSound,
        enableHapticFeedback: enableHapticFeedback ?? currentPreferences.enableHapticFeedback,
        enableFlashlight: enableFlashlight ?? currentPreferences.enableFlashlight,
        autoStartCapture: autoStartCapture ?? currentPreferences.autoStartCapture,
      );
      await updatePreferences(updatedPreferences);
    }
  }

  /// Update privacy and data preferences
  Future<void> updatePrivacyPreferences({
    bool? enableCloudSync,
    bool? enableDataExport,
    bool? shareAnonymousData,
    bool? enableCrashReporting,
    DataRetentionPeriod? dataRetention,
  }) async {
    final currentState = state;
    if (currentState is AsyncData<UserPreferences>) {
      final currentPreferences = currentState.value;
      final updatedPreferences = currentPreferences.copyWith(
        enableCloudSync: enableCloudSync ?? currentPreferences.enableCloudSync,
        enableDataExport: enableDataExport ?? currentPreferences.enableDataExport,
        shareAnonymousData: shareAnonymousData ?? currentPreferences.shareAnonymousData,
        enableCrashReporting: enableCrashReporting ?? currentPreferences.enableCrashReporting,
        dataRetention: dataRetention ?? currentPreferences.dataRetention,
      );
      await updatePreferences(updatedPreferences);
    }
  }

  /// Update notification preferences
  Future<void> updateNotificationPreferences({
    bool? enableDailyReminders,
    TimeOfDay? dailyReminderTime,
    bool? enableWeeklyReports,
    bool? enableTrendAlerts,
    bool? enableOvertrainingAlerts,
  }) async {
    final currentState = state;
    if (currentState is AsyncData<UserPreferences>) {
      final currentPreferences = currentState.value;
      final updatedPreferences = currentPreferences.copyWith(
        enableDailyReminders: enableDailyReminders ?? currentPreferences.enableDailyReminders,
        dailyReminderTime: dailyReminderTime ?? currentPreferences.dailyReminderTime,
        enableWeeklyReports: enableWeeklyReports ?? currentPreferences.enableWeeklyReports,
        enableTrendAlerts: enableTrendAlerts ?? currentPreferences.enableTrendAlerts,
        enableOvertrainingAlerts: enableOvertrainingAlerts ?? currentPreferences.enableOvertrainingAlerts,
      );
      await updatePreferences(updatedPreferences);
    }
  }

  /// Update display preferences
  Future<void> updateDisplayPreferences({
    ThemeMode? themeMode,
    bool? use24HourFormat,
    TemperatureUnit? temperatureUnit,
    DistanceUnit? distanceUnit,
    ChartTimeRange? defaultChartRange,
    bool? showAdvancedMetrics,
    bool? showConfidenceScores,
  }) async {
    final currentState = state;
    if (currentState is AsyncData<UserPreferences>) {
      final currentPreferences = currentState.value;
      final updatedPreferences = currentPreferences.copyWith(
        themeMode: themeMode ?? currentPreferences.themeMode,
        use24HourFormat: use24HourFormat ?? currentPreferences.use24HourFormat,
        temperatureUnit: temperatureUnit ?? currentPreferences.temperatureUnit,
        distanceUnit: distanceUnit ?? currentPreferences.distanceUnit,
        defaultChartRange: defaultChartRange ?? currentPreferences.defaultChartRange,
        showAdvancedMetrics: showAdvancedMetrics ?? currentPreferences.showAdvancedMetrics,
        showConfidenceScores: showConfidenceScores ?? currentPreferences.showConfidenceScores,
      );
      await updatePreferences(updatedPreferences);
    }
  }

  /// Update adaptive pacing preferences
  Future<void> updateAdaptivePacingPreferences({
    bool? enableAdaptivePacing,
    PemRiskLevel? pemRiskThreshold,
    bool? showPemWarnings,
    int? restDayThresholdScore,
  }) async {
    final currentState = state;
    if (currentState is AsyncData<UserPreferences>) {
      final currentPreferences = currentState.value;
      final updatedPreferences = currentPreferences.copyWith(
        enableAdaptivePacing: enableAdaptivePacing ?? currentPreferences.enableAdaptivePacing,
        pemRiskThreshold: pemRiskThreshold ?? currentPreferences.pemRiskThreshold,
        showPemWarnings: showPemWarnings ?? currentPreferences.showPemWarnings,
        restDayThresholdScore: restDayThresholdScore ?? currentPreferences.restDayThresholdScore,
      );
      await updatePreferences(updatedPreferences);
    }
  }
}

/// Provider for checking if onboarding is complete
final isOnboardingCompleteProvider = FutureProvider<bool>((ref) async {
  try {
    final repository = await ref.watch(settingsRepositoryProvider.future);
    return await repository.isOnboardingComplete();
  } catch (e) {
    // Return false if settings repository is not available
    return false;
  }
});

/// Provider for theme mode
final themeModeProvider = Provider<ThemeMode>((ref) {
  final preferencesAsync = ref.watch(userPreferencesProvider);
  return preferencesAsync.when(
    data: (preferences) => preferences.themeMode,
    loading: () => ThemeMode.system,
    error: (_, __) => ThemeMode.system,
  );
});

/// Provider for capture method preference
final captureMethodProvider = Provider<CaptureMethod>((ref) {
  final preferencesAsync = ref.watch(userPreferencesProvider);
  return preferencesAsync.when(
    data: (preferences) => preferences.preferredCaptureMethod,
    loading: () => CaptureMethod.camera,
    error: (_, __) => CaptureMethod.camera,
  );
});

/// Provider for adaptive pacing enabled state
final adaptivePacingEnabledProvider = Provider<bool>((ref) {
  final preferencesAsync = ref.watch(userPreferencesProvider);
  return preferencesAsync.when(
    data: (preferences) => preferences.enableAdaptivePacing,
    loading: () => true,
    error: (_, __) => true,
  );
});

/// Provider for cloud sync enabled state
final cloudSyncEnabledProvider = Provider<bool>((ref) {
  final preferencesAsync = ref.watch(userPreferencesProvider);
  return preferencesAsync.when(
    data: (preferences) => preferences.enableCloudSync,
    loading: () => true,
    error: (_, __) => true,
  );
});