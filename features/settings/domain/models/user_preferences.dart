import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_preferences.freezed.dart';
part 'user_preferences.g.dart';

/// User preferences and settings model
@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    // Profile Information
    @Default('') String userName,
    @Default(null) String? userEmail,
    @Default(25) int age,
    @Default(UserGender.notSpecified) UserGender gender,
    @Default(170.0) double heightCm,
    @Default(70.0) double weightKg,
    @Default(ActivityLevel.moderate) ActivityLevel activityLevel,
    @Default(false) bool hasChronicConditions,
    @Default([]) List<String> medications,
    
    // HRV Capture Preferences
    @Default(CaptureMethod.camera) CaptureMethod preferredCaptureMethod,
    @Default(180) int captureTimeSeconds, // 3 minutes default
    @Default(true) bool enableCaptureSound,
    @Default(true) bool enableHapticFeedback,
    @Default(true) bool enableFlashlight,
    @Default(false) bool autoStartCapture,
    
    // Data & Privacy
    @Default(true) bool enableCloudSync,
    @Default(true) bool enableDataExport,
    @Default(false) bool shareAnonymousData,
    @Default(true) bool enableCrashReporting,
    @Default(DataRetentionPeriod.oneYear) DataRetentionPeriod dataRetention,
    
    // Notifications
    @Default(true) bool enableDailyReminders,
    @Default(TimeOfDay(hour: 9, minute: 0)) TimeOfDay dailyReminderTime,
    @Default(true) bool enableWeeklyReports,
    @Default(true) bool enableTrendAlerts,
    @Default(false) bool enableOvertrainingAlerts,
    
    // Display Preferences
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(true) bool use24HourFormat,
    @Default(TemperatureUnit.celsius) TemperatureUnit temperatureUnit,
    @Default(DistanceUnit.metric) DistanceUnit distanceUnit,
    @Default(ChartTimeRange.sevenDays) ChartTimeRange defaultChartRange,
    @Default(true) bool showAdvancedMetrics,
    @Default(true) bool showConfidenceScores,
    
    // Adaptive Pacing (Chronic Illness)
    @Default(true) bool enableAdaptivePacing,
    @Default(PemRiskLevel.moderate) PemRiskLevel pemRiskThreshold,
    @Default(true) bool showPemWarnings,
    @Default(60) int restDayThresholdScore,
    
    // Data Backup
    @Default(BackupFrequency.daily) BackupFrequency autoBackupFrequency,
    @Default(true) bool enableAutomaticBackup,
    @Default(null) DateTime? lastBackupDate,
    
    // Advanced Settings
    @Default(false) bool enableDeveloperMode,
    @Default(false) bool enableDebugLogging,
    @Default(SyncFrequency.realTime) SyncFrequency syncFrequency,
    @Default(true) bool enableDataValidation,
    
    // Metadata
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
    @Default(1) int version,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}

/// Time of day representation for JSON serialization
@freezed
class TimeOfDay with _$TimeOfDay {
  const factory TimeOfDay({
    required int hour,
    required int minute,
  }) = _TimeOfDay;

  factory TimeOfDay.fromJson(Map<String, dynamic> json) =>
      _$TimeOfDayFromJson(json);
}

// Enums for various settings options

enum UserGender {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female,
  @JsonValue('other')
  other,
  @JsonValue('not_specified')
  notSpecified,
}

enum ActivityLevel {
  @JsonValue('sedentary')
  sedentary,
  @JsonValue('light')
  light,
  @JsonValue('moderate')
  moderate,
  @JsonValue('vigorous')
  vigorous,
  @JsonValue('athlete')
  athlete,
}

enum CaptureMethod {
  @JsonValue('camera')
  camera,
  @JsonValue('ble')
  ble,
  @JsonValue('auto')
  auto, // Prefer BLE if available, fallback to camera
}

enum DataRetentionPeriod {
  @JsonValue('3_months')
  threeMonths,
  @JsonValue('6_months')
  sixMonths,
  @JsonValue('1_year')
  oneYear,
  @JsonValue('2_years')
  twoYears,
  @JsonValue('forever')
  forever,
}

enum ThemeMode {
  @JsonValue('system')
  system,
  @JsonValue('light')
  light,
  @JsonValue('dark')
  dark,
}

enum TemperatureUnit {
  @JsonValue('celsius')
  celsius,
  @JsonValue('fahrenheit')
  fahrenheit,
}

enum DistanceUnit {
  @JsonValue('metric')
  metric,
  @JsonValue('imperial')
  imperial,
}

enum ChartTimeRange {
  @JsonValue('3_days')
  threeDays,
  @JsonValue('7_days')
  sevenDays,
  @JsonValue('14_days')
  fourteenDays,
  @JsonValue('30_days')
  thirtyDays,
  @JsonValue('90_days')
  ninetyDays,
}

enum PemRiskLevel {
  @JsonValue('low')
  low,
  @JsonValue('moderate')
  moderate,
  @JsonValue('high')
  high,
  @JsonValue('critical')
  critical,
}

enum BackupFrequency {
  @JsonValue('never')
  never,
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
}

enum SyncFrequency {
  @JsonValue('real_time')
  realTime,
  @JsonValue('hourly')
  hourly,
  @JsonValue('daily')
  daily,
  @JsonValue('manual')
  manual,
}

/// Helper extensions for display values
extension UserGenderExtension on UserGender {
  String get displayName {
    switch (this) {
      case UserGender.male:
        return 'Male';
      case UserGender.female:
        return 'Female';
      case UserGender.other:
        return 'Other';
      case UserGender.notSpecified:
        return 'Prefer not to say';
    }
  }
}

extension ActivityLevelExtension on ActivityLevel {
  String get displayName {
    switch (this) {
      case ActivityLevel.sedentary:
        return 'Sedentary (Little to no exercise)';
      case ActivityLevel.light:
        return 'Light (1-3 days per week)';
      case ActivityLevel.moderate:
        return 'Moderate (3-5 days per week)';
      case ActivityLevel.vigorous:
        return 'Vigorous (6-7 days per week)';
      case ActivityLevel.athlete:
        return 'Athlete (2+ times per day)';
    }
  }
}

extension CaptureMethodExtension on CaptureMethod {
  String get displayName {
    switch (this) {
      case CaptureMethod.camera:
        return 'Phone Camera (PPG)';
      case CaptureMethod.ble:
        return 'Heart Rate Monitor';
      case CaptureMethod.auto:
        return 'Automatic (BLE preferred)';
    }
  }
}

extension DataRetentionPeriodExtension on DataRetentionPeriod {
  String get displayName {
    switch (this) {
      case DataRetentionPeriod.threeMonths:
        return '3 Months';
      case DataRetentionPeriod.sixMonths:
        return '6 Months';
      case DataRetentionPeriod.oneYear:
        return '1 Year';
      case DataRetentionPeriod.twoYears:
        return '2 Years';
      case DataRetentionPeriod.forever:
        return 'Forever';
    }
  }
}

extension ThemeModeExtension on ThemeMode {
  String get displayName {
    switch (this) {
      case ThemeMode.system:
        return 'System Default';
      case ThemeMode.light:
        return 'Light Mode';
      case ThemeMode.dark:
        return 'Dark Mode';
    }
  }
}

extension ChartTimeRangeExtension on ChartTimeRange {
  String get displayName {
    switch (this) {
      case ChartTimeRange.threeDays:
        return '3 Days';
      case ChartTimeRange.sevenDays:
        return '7 Days';
      case ChartTimeRange.fourteenDays:
        return '14 Days';
      case ChartTimeRange.thirtyDays:
        return '30 Days';
      case ChartTimeRange.ninetyDays:
        return '90 Days';
    }
  }
  
  int get days {
    switch (this) {
      case ChartTimeRange.threeDays:
        return 3;
      case ChartTimeRange.sevenDays:
        return 7;
      case ChartTimeRange.fourteenDays:
        return 14;
      case ChartTimeRange.thirtyDays:
        return 30;
      case ChartTimeRange.ninetyDays:
        return 90;
    }
  }
}

extension PemRiskLevelExtension on PemRiskLevel {
  String get displayName {
    switch (this) {
      case PemRiskLevel.low:
        return 'Low Risk';
      case PemRiskLevel.moderate:
        return 'Moderate Risk';
      case PemRiskLevel.high:
        return 'High Risk';
      case PemRiskLevel.critical:
        return 'Critical Risk';
    }
  }
  
  String get description {
    switch (this) {
      case PemRiskLevel.low:
        return 'Conservative approach, minimal PEM risk';
      case PemRiskLevel.moderate:
        return 'Balanced approach, standard PEM prevention';
      case PemRiskLevel.high:
        return 'Cautious approach, enhanced PEM monitoring';
      case PemRiskLevel.critical:
        return 'Maximum protection, strict activity limits';
    }
  }
}