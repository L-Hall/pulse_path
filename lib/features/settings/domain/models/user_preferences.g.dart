// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPreferencesImpl(
      userName: json['userName'] as String? ?? '',
      userEmail: json['userEmail'] as String? ?? null,
      age: (json['age'] as num?)?.toInt() ?? 25,
      gender: $enumDecodeNullable(_$UserGenderEnumMap, json['gender']) ??
          UserGender.notSpecified,
      heightCm: (json['heightCm'] as num?)?.toDouble() ?? 170.0,
      weightKg: (json['weightKg'] as num?)?.toDouble() ?? 70.0,
      activityLevel:
          $enumDecodeNullable(_$ActivityLevelEnumMap, json['activityLevel']) ??
              ActivityLevel.moderate,
      hasChronicConditions: json['hasChronicConditions'] as bool? ?? false,
      medications: (json['medications'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      preferredCaptureMethod: $enumDecodeNullable(
              _$CaptureMethodEnumMap, json['preferredCaptureMethod']) ??
          CaptureMethod.camera,
      captureTimeSeconds: (json['captureTimeSeconds'] as num?)?.toInt() ?? 180,
      enableCaptureSound: json['enableCaptureSound'] as bool? ?? true,
      enableHapticFeedback: json['enableHapticFeedback'] as bool? ?? true,
      enableFlashlight: json['enableFlashlight'] as bool? ?? true,
      autoStartCapture: json['autoStartCapture'] as bool? ?? false,
      enableCloudSync: json['enableCloudSync'] as bool? ?? true,
      enableDataExport: json['enableDataExport'] as bool? ?? true,
      shareAnonymousData: json['shareAnonymousData'] as bool? ?? false,
      enableCrashReporting: json['enableCrashReporting'] as bool? ?? true,
      dataRetention: $enumDecodeNullable(
              _$DataRetentionPeriodEnumMap, json['dataRetention']) ??
          DataRetentionPeriod.oneYear,
      enableDailyReminders: json['enableDailyReminders'] as bool? ?? true,
      dailyReminderTime: json['dailyReminderTime'] == null
          ? const TimeOfDay(hour: 9, minute: 0)
          : TimeOfDay.fromJson(
              json['dailyReminderTime'] as Map<String, dynamic>),
      enableWeeklyReports: json['enableWeeklyReports'] as bool? ?? true,
      enableTrendAlerts: json['enableTrendAlerts'] as bool? ?? true,
      enableOvertrainingAlerts:
          json['enableOvertrainingAlerts'] as bool? ?? false,
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      use24HourFormat: json['use24HourFormat'] as bool? ?? true,
      temperatureUnit: $enumDecodeNullable(
              _$TemperatureUnitEnumMap, json['temperatureUnit']) ??
          TemperatureUnit.celsius,
      distanceUnit:
          $enumDecodeNullable(_$DistanceUnitEnumMap, json['distanceUnit']) ??
              DistanceUnit.metric,
      defaultChartRange: $enumDecodeNullable(
              _$ChartTimeRangeEnumMap, json['defaultChartRange']) ??
          ChartTimeRange.sevenDays,
      showAdvancedMetrics: json['showAdvancedMetrics'] as bool? ?? true,
      showConfidenceScores: json['showConfidenceScores'] as bool? ?? true,
      enableAdaptivePacing: json['enableAdaptivePacing'] as bool? ?? true,
      pemRiskThreshold: $enumDecodeNullable(
              _$PemRiskLevelEnumMap, json['pemRiskThreshold']) ??
          PemRiskLevel.moderate,
      showPemWarnings: json['showPemWarnings'] as bool? ?? true,
      restDayThresholdScore:
          (json['restDayThresholdScore'] as num?)?.toInt() ?? 60,
      autoBackupFrequency: $enumDecodeNullable(
              _$BackupFrequencyEnumMap, json['autoBackupFrequency']) ??
          BackupFrequency.daily,
      enableAutomaticBackup: json['enableAutomaticBackup'] as bool? ?? true,
      lastBackupDate: json['lastBackupDate'] == null
          ? null
          : DateTime.parse(json['lastBackupDate'] as String),
      enableDeveloperMode: json['enableDeveloperMode'] as bool? ?? false,
      enableDebugLogging: json['enableDebugLogging'] as bool? ?? false,
      syncFrequency:
          $enumDecodeNullable(_$SyncFrequencyEnumMap, json['syncFrequency']) ??
              SyncFrequency.realTime,
      enableDataValidation: json['enableDataValidation'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: (json['version'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$UserPreferencesImplToJson(
        _$UserPreferencesImpl instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'age': instance.age,
      'gender': _$UserGenderEnumMap[instance.gender]!,
      'heightCm': instance.heightCm,
      'weightKg': instance.weightKg,
      'activityLevel': _$ActivityLevelEnumMap[instance.activityLevel]!,
      'hasChronicConditions': instance.hasChronicConditions,
      'medications': instance.medications,
      'preferredCaptureMethod':
          _$CaptureMethodEnumMap[instance.preferredCaptureMethod]!,
      'captureTimeSeconds': instance.captureTimeSeconds,
      'enableCaptureSound': instance.enableCaptureSound,
      'enableHapticFeedback': instance.enableHapticFeedback,
      'enableFlashlight': instance.enableFlashlight,
      'autoStartCapture': instance.autoStartCapture,
      'enableCloudSync': instance.enableCloudSync,
      'enableDataExport': instance.enableDataExport,
      'shareAnonymousData': instance.shareAnonymousData,
      'enableCrashReporting': instance.enableCrashReporting,
      'dataRetention': _$DataRetentionPeriodEnumMap[instance.dataRetention]!,
      'enableDailyReminders': instance.enableDailyReminders,
      'dailyReminderTime': instance.dailyReminderTime,
      'enableWeeklyReports': instance.enableWeeklyReports,
      'enableTrendAlerts': instance.enableTrendAlerts,
      'enableOvertrainingAlerts': instance.enableOvertrainingAlerts,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'use24HourFormat': instance.use24HourFormat,
      'temperatureUnit': _$TemperatureUnitEnumMap[instance.temperatureUnit]!,
      'distanceUnit': _$DistanceUnitEnumMap[instance.distanceUnit]!,
      'defaultChartRange': _$ChartTimeRangeEnumMap[instance.defaultChartRange]!,
      'showAdvancedMetrics': instance.showAdvancedMetrics,
      'showConfidenceScores': instance.showConfidenceScores,
      'enableAdaptivePacing': instance.enableAdaptivePacing,
      'pemRiskThreshold': _$PemRiskLevelEnumMap[instance.pemRiskThreshold]!,
      'showPemWarnings': instance.showPemWarnings,
      'restDayThresholdScore': instance.restDayThresholdScore,
      'autoBackupFrequency':
          _$BackupFrequencyEnumMap[instance.autoBackupFrequency]!,
      'enableAutomaticBackup': instance.enableAutomaticBackup,
      'lastBackupDate': instance.lastBackupDate?.toIso8601String(),
      'enableDeveloperMode': instance.enableDeveloperMode,
      'enableDebugLogging': instance.enableDebugLogging,
      'syncFrequency': _$SyncFrequencyEnumMap[instance.syncFrequency]!,
      'enableDataValidation': instance.enableDataValidation,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'version': instance.version,
    };

const _$UserGenderEnumMap = {
  UserGender.male: 'male',
  UserGender.female: 'female',
  UserGender.other: 'other',
  UserGender.notSpecified: 'not_specified',
};

const _$ActivityLevelEnumMap = {
  ActivityLevel.sedentary: 'sedentary',
  ActivityLevel.light: 'light',
  ActivityLevel.moderate: 'moderate',
  ActivityLevel.vigorous: 'vigorous',
  ActivityLevel.athlete: 'athlete',
};

const _$CaptureMethodEnumMap = {
  CaptureMethod.camera: 'camera',
  CaptureMethod.ble: 'ble',
  CaptureMethod.auto: 'auto',
};

const _$DataRetentionPeriodEnumMap = {
  DataRetentionPeriod.threeMonths: '3_months',
  DataRetentionPeriod.sixMonths: '6_months',
  DataRetentionPeriod.oneYear: '1_year',
  DataRetentionPeriod.twoYears: '2_years',
  DataRetentionPeriod.forever: 'forever',
};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$TemperatureUnitEnumMap = {
  TemperatureUnit.celsius: 'celsius',
  TemperatureUnit.fahrenheit: 'fahrenheit',
};

const _$DistanceUnitEnumMap = {
  DistanceUnit.metric: 'metric',
  DistanceUnit.imperial: 'imperial',
};

const _$ChartTimeRangeEnumMap = {
  ChartTimeRange.threeDays: '3_days',
  ChartTimeRange.sevenDays: '7_days',
  ChartTimeRange.fourteenDays: '14_days',
  ChartTimeRange.thirtyDays: '30_days',
  ChartTimeRange.ninetyDays: '90_days',
};

const _$PemRiskLevelEnumMap = {
  PemRiskLevel.low: 'low',
  PemRiskLevel.moderate: 'moderate',
  PemRiskLevel.high: 'high',
  PemRiskLevel.critical: 'critical',
};

const _$BackupFrequencyEnumMap = {
  BackupFrequency.never: 'never',
  BackupFrequency.daily: 'daily',
  BackupFrequency.weekly: 'weekly',
  BackupFrequency.monthly: 'monthly',
};

const _$SyncFrequencyEnumMap = {
  SyncFrequency.realTime: 'real_time',
  SyncFrequency.hourly: 'hourly',
  SyncFrequency.daily: 'daily',
  SyncFrequency.manual: 'manual',
};

_$TimeOfDayImpl _$$TimeOfDayImplFromJson(Map<String, dynamic> json) =>
    _$TimeOfDayImpl(
      hour: (json['hour'] as num).toInt(),
      minute: (json['minute'] as num).toInt(),
    );

Map<String, dynamic> _$$TimeOfDayImplToJson(_$TimeOfDayImpl instance) =>
    <String, dynamic>{
      'hour': instance.hour,
      'minute': instance.minute,
    };
