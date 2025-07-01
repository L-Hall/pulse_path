// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) {
  return _UserPreferences.fromJson(json);
}

/// @nodoc
mixin _$UserPreferences {
// Profile Information
  String get userName => throw _privateConstructorUsedError;
  String? get userEmail => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  UserGender get gender => throw _privateConstructorUsedError;
  double get heightCm => throw _privateConstructorUsedError;
  double get weightKg => throw _privateConstructorUsedError;
  ActivityLevel get activityLevel => throw _privateConstructorUsedError;
  bool get hasChronicConditions => throw _privateConstructorUsedError;
  List<String> get medications =>
      throw _privateConstructorUsedError; // HRV Capture Preferences
  CaptureMethod get preferredCaptureMethod =>
      throw _privateConstructorUsedError;
  int get captureTimeSeconds =>
      throw _privateConstructorUsedError; // 3 minutes default
  bool get enableCaptureSound => throw _privateConstructorUsedError;
  bool get enableHapticFeedback => throw _privateConstructorUsedError;
  bool get enableFlashlight => throw _privateConstructorUsedError;
  bool get autoStartCapture =>
      throw _privateConstructorUsedError; // Data & Privacy
  bool get enableCloudSync => throw _privateConstructorUsedError;
  bool get enableDataExport => throw _privateConstructorUsedError;
  bool get shareAnonymousData => throw _privateConstructorUsedError;
  bool get enableCrashReporting => throw _privateConstructorUsedError;
  DataRetentionPeriod get dataRetention =>
      throw _privateConstructorUsedError; // Notifications
  bool get enableDailyReminders => throw _privateConstructorUsedError;
  TimeOfDay get dailyReminderTime => throw _privateConstructorUsedError;
  bool get enableWeeklyReports => throw _privateConstructorUsedError;
  bool get enableTrendAlerts => throw _privateConstructorUsedError;
  bool get enableOvertrainingAlerts =>
      throw _privateConstructorUsedError; // Display Preferences
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  bool get use24HourFormat => throw _privateConstructorUsedError;
  TemperatureUnit get temperatureUnit => throw _privateConstructorUsedError;
  DistanceUnit get distanceUnit => throw _privateConstructorUsedError;
  ChartTimeRange get defaultChartRange => throw _privateConstructorUsedError;
  bool get showAdvancedMetrics => throw _privateConstructorUsedError;
  bool get showConfidenceScores =>
      throw _privateConstructorUsedError; // Adaptive Pacing (Chronic Illness)
  bool get enableAdaptivePacing => throw _privateConstructorUsedError;
  PemRiskLevel get pemRiskThreshold => throw _privateConstructorUsedError;
  bool get showPemWarnings => throw _privateConstructorUsedError;
  int get restDayThresholdScore =>
      throw _privateConstructorUsedError; // Data Backup
  BackupFrequency get autoBackupFrequency => throw _privateConstructorUsedError;
  bool get enableAutomaticBackup => throw _privateConstructorUsedError;
  DateTime? get lastBackupDate =>
      throw _privateConstructorUsedError; // Advanced Settings
  bool get enableDeveloperMode => throw _privateConstructorUsedError;
  bool get enableDebugLogging => throw _privateConstructorUsedError;
  SyncFrequency get syncFrequency => throw _privateConstructorUsedError;
  bool get enableDataValidation =>
      throw _privateConstructorUsedError; // Metadata
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;

  /// Serializes this UserPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPreferencesCopyWith<UserPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPreferencesCopyWith<$Res> {
  factory $UserPreferencesCopyWith(
          UserPreferences value, $Res Function(UserPreferences) then) =
      _$UserPreferencesCopyWithImpl<$Res, UserPreferences>;
  @useResult
  $Res call(
      {String userName,
      String? userEmail,
      int age,
      UserGender gender,
      double heightCm,
      double weightKg,
      ActivityLevel activityLevel,
      bool hasChronicConditions,
      List<String> medications,
      CaptureMethod preferredCaptureMethod,
      int captureTimeSeconds,
      bool enableCaptureSound,
      bool enableHapticFeedback,
      bool enableFlashlight,
      bool autoStartCapture,
      bool enableCloudSync,
      bool enableDataExport,
      bool shareAnonymousData,
      bool enableCrashReporting,
      DataRetentionPeriod dataRetention,
      bool enableDailyReminders,
      TimeOfDay dailyReminderTime,
      bool enableWeeklyReports,
      bool enableTrendAlerts,
      bool enableOvertrainingAlerts,
      ThemeMode themeMode,
      bool use24HourFormat,
      TemperatureUnit temperatureUnit,
      DistanceUnit distanceUnit,
      ChartTimeRange defaultChartRange,
      bool showAdvancedMetrics,
      bool showConfidenceScores,
      bool enableAdaptivePacing,
      PemRiskLevel pemRiskThreshold,
      bool showPemWarnings,
      int restDayThresholdScore,
      BackupFrequency autoBackupFrequency,
      bool enableAutomaticBackup,
      DateTime? lastBackupDate,
      bool enableDeveloperMode,
      bool enableDebugLogging,
      SyncFrequency syncFrequency,
      bool enableDataValidation,
      DateTime? createdAt,
      DateTime? updatedAt,
      int version});

  $TimeOfDayCopyWith<$Res> get dailyReminderTime;
}

/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res, $Val extends UserPreferences>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? userEmail = freezed,
    Object? age = null,
    Object? gender = null,
    Object? heightCm = null,
    Object? weightKg = null,
    Object? activityLevel = null,
    Object? hasChronicConditions = null,
    Object? medications = null,
    Object? preferredCaptureMethod = null,
    Object? captureTimeSeconds = null,
    Object? enableCaptureSound = null,
    Object? enableHapticFeedback = null,
    Object? enableFlashlight = null,
    Object? autoStartCapture = null,
    Object? enableCloudSync = null,
    Object? enableDataExport = null,
    Object? shareAnonymousData = null,
    Object? enableCrashReporting = null,
    Object? dataRetention = null,
    Object? enableDailyReminders = null,
    Object? dailyReminderTime = null,
    Object? enableWeeklyReports = null,
    Object? enableTrendAlerts = null,
    Object? enableOvertrainingAlerts = null,
    Object? themeMode = null,
    Object? use24HourFormat = null,
    Object? temperatureUnit = null,
    Object? distanceUnit = null,
    Object? defaultChartRange = null,
    Object? showAdvancedMetrics = null,
    Object? showConfidenceScores = null,
    Object? enableAdaptivePacing = null,
    Object? pemRiskThreshold = null,
    Object? showPemWarnings = null,
    Object? restDayThresholdScore = null,
    Object? autoBackupFrequency = null,
    Object? enableAutomaticBackup = null,
    Object? lastBackupDate = freezed,
    Object? enableDeveloperMode = null,
    Object? enableDebugLogging = null,
    Object? syncFrequency = null,
    Object? enableDataValidation = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as UserGender,
      heightCm: null == heightCm
          ? _value.heightCm
          : heightCm // ignore: cast_nullable_to_non_nullable
              as double,
      weightKg: null == weightKg
          ? _value.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double,
      activityLevel: null == activityLevel
          ? _value.activityLevel
          : activityLevel // ignore: cast_nullable_to_non_nullable
              as ActivityLevel,
      hasChronicConditions: null == hasChronicConditions
          ? _value.hasChronicConditions
          : hasChronicConditions // ignore: cast_nullable_to_non_nullable
              as bool,
      medications: null == medications
          ? _value.medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredCaptureMethod: null == preferredCaptureMethod
          ? _value.preferredCaptureMethod
          : preferredCaptureMethod // ignore: cast_nullable_to_non_nullable
              as CaptureMethod,
      captureTimeSeconds: null == captureTimeSeconds
          ? _value.captureTimeSeconds
          : captureTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      enableCaptureSound: null == enableCaptureSound
          ? _value.enableCaptureSound
          : enableCaptureSound // ignore: cast_nullable_to_non_nullable
              as bool,
      enableHapticFeedback: null == enableHapticFeedback
          ? _value.enableHapticFeedback
          : enableHapticFeedback // ignore: cast_nullable_to_non_nullable
              as bool,
      enableFlashlight: null == enableFlashlight
          ? _value.enableFlashlight
          : enableFlashlight // ignore: cast_nullable_to_non_nullable
              as bool,
      autoStartCapture: null == autoStartCapture
          ? _value.autoStartCapture
          : autoStartCapture // ignore: cast_nullable_to_non_nullable
              as bool,
      enableCloudSync: null == enableCloudSync
          ? _value.enableCloudSync
          : enableCloudSync // ignore: cast_nullable_to_non_nullable
              as bool,
      enableDataExport: null == enableDataExport
          ? _value.enableDataExport
          : enableDataExport // ignore: cast_nullable_to_non_nullable
              as bool,
      shareAnonymousData: null == shareAnonymousData
          ? _value.shareAnonymousData
          : shareAnonymousData // ignore: cast_nullable_to_non_nullable
              as bool,
      enableCrashReporting: null == enableCrashReporting
          ? _value.enableCrashReporting
          : enableCrashReporting // ignore: cast_nullable_to_non_nullable
              as bool,
      dataRetention: null == dataRetention
          ? _value.dataRetention
          : dataRetention // ignore: cast_nullable_to_non_nullable
              as DataRetentionPeriod,
      enableDailyReminders: null == enableDailyReminders
          ? _value.enableDailyReminders
          : enableDailyReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyReminderTime: null == dailyReminderTime
          ? _value.dailyReminderTime
          : dailyReminderTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      enableWeeklyReports: null == enableWeeklyReports
          ? _value.enableWeeklyReports
          : enableWeeklyReports // ignore: cast_nullable_to_non_nullable
              as bool,
      enableTrendAlerts: null == enableTrendAlerts
          ? _value.enableTrendAlerts
          : enableTrendAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      enableOvertrainingAlerts: null == enableOvertrainingAlerts
          ? _value.enableOvertrainingAlerts
          : enableOvertrainingAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      use24HourFormat: null == use24HourFormat
          ? _value.use24HourFormat
          : use24HourFormat // ignore: cast_nullable_to_non_nullable
              as bool,
      temperatureUnit: null == temperatureUnit
          ? _value.temperatureUnit
          : temperatureUnit // ignore: cast_nullable_to_non_nullable
              as TemperatureUnit,
      distanceUnit: null == distanceUnit
          ? _value.distanceUnit
          : distanceUnit // ignore: cast_nullable_to_non_nullable
              as DistanceUnit,
      defaultChartRange: null == defaultChartRange
          ? _value.defaultChartRange
          : defaultChartRange // ignore: cast_nullable_to_non_nullable
              as ChartTimeRange,
      showAdvancedMetrics: null == showAdvancedMetrics
          ? _value.showAdvancedMetrics
          : showAdvancedMetrics // ignore: cast_nullable_to_non_nullable
              as bool,
      showConfidenceScores: null == showConfidenceScores
          ? _value.showConfidenceScores
          : showConfidenceScores // ignore: cast_nullable_to_non_nullable
              as bool,
      enableAdaptivePacing: null == enableAdaptivePacing
          ? _value.enableAdaptivePacing
          : enableAdaptivePacing // ignore: cast_nullable_to_non_nullable
              as bool,
      pemRiskThreshold: null == pemRiskThreshold
          ? _value.pemRiskThreshold
          : pemRiskThreshold // ignore: cast_nullable_to_non_nullable
              as PemRiskLevel,
      showPemWarnings: null == showPemWarnings
          ? _value.showPemWarnings
          : showPemWarnings // ignore: cast_nullable_to_non_nullable
              as bool,
      restDayThresholdScore: null == restDayThresholdScore
          ? _value.restDayThresholdScore
          : restDayThresholdScore // ignore: cast_nullable_to_non_nullable
              as int,
      autoBackupFrequency: null == autoBackupFrequency
          ? _value.autoBackupFrequency
          : autoBackupFrequency // ignore: cast_nullable_to_non_nullable
              as BackupFrequency,
      enableAutomaticBackup: null == enableAutomaticBackup
          ? _value.enableAutomaticBackup
          : enableAutomaticBackup // ignore: cast_nullable_to_non_nullable
              as bool,
      lastBackupDate: freezed == lastBackupDate
          ? _value.lastBackupDate
          : lastBackupDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      enableDeveloperMode: null == enableDeveloperMode
          ? _value.enableDeveloperMode
          : enableDeveloperMode // ignore: cast_nullable_to_non_nullable
              as bool,
      enableDebugLogging: null == enableDebugLogging
          ? _value.enableDebugLogging
          : enableDebugLogging // ignore: cast_nullable_to_non_nullable
              as bool,
      syncFrequency: null == syncFrequency
          ? _value.syncFrequency
          : syncFrequency // ignore: cast_nullable_to_non_nullable
              as SyncFrequency,
      enableDataValidation: null == enableDataValidation
          ? _value.enableDataValidation
          : enableDataValidation // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeOfDayCopyWith<$Res> get dailyReminderTime {
    return $TimeOfDayCopyWith<$Res>(_value.dailyReminderTime, (value) {
      return _then(_value.copyWith(dailyReminderTime: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserPreferencesImplCopyWith<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  factory _$$UserPreferencesImplCopyWith(_$UserPreferencesImpl value,
          $Res Function(_$UserPreferencesImpl) then) =
      __$$UserPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userName,
      String? userEmail,
      int age,
      UserGender gender,
      double heightCm,
      double weightKg,
      ActivityLevel activityLevel,
      bool hasChronicConditions,
      List<String> medications,
      CaptureMethod preferredCaptureMethod,
      int captureTimeSeconds,
      bool enableCaptureSound,
      bool enableHapticFeedback,
      bool enableFlashlight,
      bool autoStartCapture,
      bool enableCloudSync,
      bool enableDataExport,
      bool shareAnonymousData,
      bool enableCrashReporting,
      DataRetentionPeriod dataRetention,
      bool enableDailyReminders,
      TimeOfDay dailyReminderTime,
      bool enableWeeklyReports,
      bool enableTrendAlerts,
      bool enableOvertrainingAlerts,
      ThemeMode themeMode,
      bool use24HourFormat,
      TemperatureUnit temperatureUnit,
      DistanceUnit distanceUnit,
      ChartTimeRange defaultChartRange,
      bool showAdvancedMetrics,
      bool showConfidenceScores,
      bool enableAdaptivePacing,
      PemRiskLevel pemRiskThreshold,
      bool showPemWarnings,
      int restDayThresholdScore,
      BackupFrequency autoBackupFrequency,
      bool enableAutomaticBackup,
      DateTime? lastBackupDate,
      bool enableDeveloperMode,
      bool enableDebugLogging,
      SyncFrequency syncFrequency,
      bool enableDataValidation,
      DateTime? createdAt,
      DateTime? updatedAt,
      int version});

  @override
  $TimeOfDayCopyWith<$Res> get dailyReminderTime;
}

/// @nodoc
class __$$UserPreferencesImplCopyWithImpl<$Res>
    extends _$UserPreferencesCopyWithImpl<$Res, _$UserPreferencesImpl>
    implements _$$UserPreferencesImplCopyWith<$Res> {
  __$$UserPreferencesImplCopyWithImpl(
      _$UserPreferencesImpl _value, $Res Function(_$UserPreferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? userEmail = freezed,
    Object? age = null,
    Object? gender = null,
    Object? heightCm = null,
    Object? weightKg = null,
    Object? activityLevel = null,
    Object? hasChronicConditions = null,
    Object? medications = null,
    Object? preferredCaptureMethod = null,
    Object? captureTimeSeconds = null,
    Object? enableCaptureSound = null,
    Object? enableHapticFeedback = null,
    Object? enableFlashlight = null,
    Object? autoStartCapture = null,
    Object? enableCloudSync = null,
    Object? enableDataExport = null,
    Object? shareAnonymousData = null,
    Object? enableCrashReporting = null,
    Object? dataRetention = null,
    Object? enableDailyReminders = null,
    Object? dailyReminderTime = null,
    Object? enableWeeklyReports = null,
    Object? enableTrendAlerts = null,
    Object? enableOvertrainingAlerts = null,
    Object? themeMode = null,
    Object? use24HourFormat = null,
    Object? temperatureUnit = null,
    Object? distanceUnit = null,
    Object? defaultChartRange = null,
    Object? showAdvancedMetrics = null,
    Object? showConfidenceScores = null,
    Object? enableAdaptivePacing = null,
    Object? pemRiskThreshold = null,
    Object? showPemWarnings = null,
    Object? restDayThresholdScore = null,
    Object? autoBackupFrequency = null,
    Object? enableAutomaticBackup = null,
    Object? lastBackupDate = freezed,
    Object? enableDeveloperMode = null,
    Object? enableDebugLogging = null,
    Object? syncFrequency = null,
    Object? enableDataValidation = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? version = null,
  }) {
    return _then(_$UserPreferencesImpl(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as UserGender,
      heightCm: null == heightCm
          ? _value.heightCm
          : heightCm // ignore: cast_nullable_to_non_nullable
              as double,
      weightKg: null == weightKg
          ? _value.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double,
      activityLevel: null == activityLevel
          ? _value.activityLevel
          : activityLevel // ignore: cast_nullable_to_non_nullable
              as ActivityLevel,
      hasChronicConditions: null == hasChronicConditions
          ? _value.hasChronicConditions
          : hasChronicConditions // ignore: cast_nullable_to_non_nullable
              as bool,
      medications: null == medications
          ? _value._medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredCaptureMethod: null == preferredCaptureMethod
          ? _value.preferredCaptureMethod
          : preferredCaptureMethod // ignore: cast_nullable_to_non_nullable
              as CaptureMethod,
      captureTimeSeconds: null == captureTimeSeconds
          ? _value.captureTimeSeconds
          : captureTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      enableCaptureSound: null == enableCaptureSound
          ? _value.enableCaptureSound
          : enableCaptureSound // ignore: cast_nullable_to_non_nullable
              as bool,
      enableHapticFeedback: null == enableHapticFeedback
          ? _value.enableHapticFeedback
          : enableHapticFeedback // ignore: cast_nullable_to_non_nullable
              as bool,
      enableFlashlight: null == enableFlashlight
          ? _value.enableFlashlight
          : enableFlashlight // ignore: cast_nullable_to_non_nullable
              as bool,
      autoStartCapture: null == autoStartCapture
          ? _value.autoStartCapture
          : autoStartCapture // ignore: cast_nullable_to_non_nullable
              as bool,
      enableCloudSync: null == enableCloudSync
          ? _value.enableCloudSync
          : enableCloudSync // ignore: cast_nullable_to_non_nullable
              as bool,
      enableDataExport: null == enableDataExport
          ? _value.enableDataExport
          : enableDataExport // ignore: cast_nullable_to_non_nullable
              as bool,
      shareAnonymousData: null == shareAnonymousData
          ? _value.shareAnonymousData
          : shareAnonymousData // ignore: cast_nullable_to_non_nullable
              as bool,
      enableCrashReporting: null == enableCrashReporting
          ? _value.enableCrashReporting
          : enableCrashReporting // ignore: cast_nullable_to_non_nullable
              as bool,
      dataRetention: null == dataRetention
          ? _value.dataRetention
          : dataRetention // ignore: cast_nullable_to_non_nullable
              as DataRetentionPeriod,
      enableDailyReminders: null == enableDailyReminders
          ? _value.enableDailyReminders
          : enableDailyReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyReminderTime: null == dailyReminderTime
          ? _value.dailyReminderTime
          : dailyReminderTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      enableWeeklyReports: null == enableWeeklyReports
          ? _value.enableWeeklyReports
          : enableWeeklyReports // ignore: cast_nullable_to_non_nullable
              as bool,
      enableTrendAlerts: null == enableTrendAlerts
          ? _value.enableTrendAlerts
          : enableTrendAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      enableOvertrainingAlerts: null == enableOvertrainingAlerts
          ? _value.enableOvertrainingAlerts
          : enableOvertrainingAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      use24HourFormat: null == use24HourFormat
          ? _value.use24HourFormat
          : use24HourFormat // ignore: cast_nullable_to_non_nullable
              as bool,
      temperatureUnit: null == temperatureUnit
          ? _value.temperatureUnit
          : temperatureUnit // ignore: cast_nullable_to_non_nullable
              as TemperatureUnit,
      distanceUnit: null == distanceUnit
          ? _value.distanceUnit
          : distanceUnit // ignore: cast_nullable_to_non_nullable
              as DistanceUnit,
      defaultChartRange: null == defaultChartRange
          ? _value.defaultChartRange
          : defaultChartRange // ignore: cast_nullable_to_non_nullable
              as ChartTimeRange,
      showAdvancedMetrics: null == showAdvancedMetrics
          ? _value.showAdvancedMetrics
          : showAdvancedMetrics // ignore: cast_nullable_to_non_nullable
              as bool,
      showConfidenceScores: null == showConfidenceScores
          ? _value.showConfidenceScores
          : showConfidenceScores // ignore: cast_nullable_to_non_nullable
              as bool,
      enableAdaptivePacing: null == enableAdaptivePacing
          ? _value.enableAdaptivePacing
          : enableAdaptivePacing // ignore: cast_nullable_to_non_nullable
              as bool,
      pemRiskThreshold: null == pemRiskThreshold
          ? _value.pemRiskThreshold
          : pemRiskThreshold // ignore: cast_nullable_to_non_nullable
              as PemRiskLevel,
      showPemWarnings: null == showPemWarnings
          ? _value.showPemWarnings
          : showPemWarnings // ignore: cast_nullable_to_non_nullable
              as bool,
      restDayThresholdScore: null == restDayThresholdScore
          ? _value.restDayThresholdScore
          : restDayThresholdScore // ignore: cast_nullable_to_non_nullable
              as int,
      autoBackupFrequency: null == autoBackupFrequency
          ? _value.autoBackupFrequency
          : autoBackupFrequency // ignore: cast_nullable_to_non_nullable
              as BackupFrequency,
      enableAutomaticBackup: null == enableAutomaticBackup
          ? _value.enableAutomaticBackup
          : enableAutomaticBackup // ignore: cast_nullable_to_non_nullable
              as bool,
      lastBackupDate: freezed == lastBackupDate
          ? _value.lastBackupDate
          : lastBackupDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      enableDeveloperMode: null == enableDeveloperMode
          ? _value.enableDeveloperMode
          : enableDeveloperMode // ignore: cast_nullable_to_non_nullable
              as bool,
      enableDebugLogging: null == enableDebugLogging
          ? _value.enableDebugLogging
          : enableDebugLogging // ignore: cast_nullable_to_non_nullable
              as bool,
      syncFrequency: null == syncFrequency
          ? _value.syncFrequency
          : syncFrequency // ignore: cast_nullable_to_non_nullable
              as SyncFrequency,
      enableDataValidation: null == enableDataValidation
          ? _value.enableDataValidation
          : enableDataValidation // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPreferencesImpl implements _UserPreferences {
  const _$UserPreferencesImpl(
      {this.userName = '',
      this.userEmail = null,
      this.age = 25,
      this.gender = UserGender.notSpecified,
      this.heightCm = 170.0,
      this.weightKg = 70.0,
      this.activityLevel = ActivityLevel.moderate,
      this.hasChronicConditions = false,
      final List<String> medications = const [],
      this.preferredCaptureMethod = CaptureMethod.camera,
      this.captureTimeSeconds = 180,
      this.enableCaptureSound = true,
      this.enableHapticFeedback = true,
      this.enableFlashlight = true,
      this.autoStartCapture = false,
      this.enableCloudSync = true,
      this.enableDataExport = true,
      this.shareAnonymousData = false,
      this.enableCrashReporting = true,
      this.dataRetention = DataRetentionPeriod.oneYear,
      this.enableDailyReminders = true,
      this.dailyReminderTime = const TimeOfDay(hour: 9, minute: 0),
      this.enableWeeklyReports = true,
      this.enableTrendAlerts = true,
      this.enableOvertrainingAlerts = false,
      this.themeMode = ThemeMode.system,
      this.use24HourFormat = true,
      this.temperatureUnit = TemperatureUnit.celsius,
      this.distanceUnit = DistanceUnit.metric,
      this.defaultChartRange = ChartTimeRange.sevenDays,
      this.showAdvancedMetrics = true,
      this.showConfidenceScores = true,
      this.enableAdaptivePacing = true,
      this.pemRiskThreshold = PemRiskLevel.moderate,
      this.showPemWarnings = true,
      this.restDayThresholdScore = 60,
      this.autoBackupFrequency = BackupFrequency.daily,
      this.enableAutomaticBackup = true,
      this.lastBackupDate = null,
      this.enableDeveloperMode = false,
      this.enableDebugLogging = false,
      this.syncFrequency = SyncFrequency.realTime,
      this.enableDataValidation = true,
      this.createdAt = null,
      this.updatedAt = null,
      this.version = 1})
      : _medications = medications;

  factory _$UserPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPreferencesImplFromJson(json);

// Profile Information
  @override
  @JsonKey()
  final String userName;
  @override
  @JsonKey()
  final String? userEmail;
  @override
  @JsonKey()
  final int age;
  @override
  @JsonKey()
  final UserGender gender;
  @override
  @JsonKey()
  final double heightCm;
  @override
  @JsonKey()
  final double weightKg;
  @override
  @JsonKey()
  final ActivityLevel activityLevel;
  @override
  @JsonKey()
  final bool hasChronicConditions;
  final List<String> _medications;
  @override
  @JsonKey()
  List<String> get medications {
    if (_medications is EqualUnmodifiableListView) return _medications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_medications);
  }

// HRV Capture Preferences
  @override
  @JsonKey()
  final CaptureMethod preferredCaptureMethod;
  @override
  @JsonKey()
  final int captureTimeSeconds;
// 3 minutes default
  @override
  @JsonKey()
  final bool enableCaptureSound;
  @override
  @JsonKey()
  final bool enableHapticFeedback;
  @override
  @JsonKey()
  final bool enableFlashlight;
  @override
  @JsonKey()
  final bool autoStartCapture;
// Data & Privacy
  @override
  @JsonKey()
  final bool enableCloudSync;
  @override
  @JsonKey()
  final bool enableDataExport;
  @override
  @JsonKey()
  final bool shareAnonymousData;
  @override
  @JsonKey()
  final bool enableCrashReporting;
  @override
  @JsonKey()
  final DataRetentionPeriod dataRetention;
// Notifications
  @override
  @JsonKey()
  final bool enableDailyReminders;
  @override
  @JsonKey()
  final TimeOfDay dailyReminderTime;
  @override
  @JsonKey()
  final bool enableWeeklyReports;
  @override
  @JsonKey()
  final bool enableTrendAlerts;
  @override
  @JsonKey()
  final bool enableOvertrainingAlerts;
// Display Preferences
  @override
  @JsonKey()
  final ThemeMode themeMode;
  @override
  @JsonKey()
  final bool use24HourFormat;
  @override
  @JsonKey()
  final TemperatureUnit temperatureUnit;
  @override
  @JsonKey()
  final DistanceUnit distanceUnit;
  @override
  @JsonKey()
  final ChartTimeRange defaultChartRange;
  @override
  @JsonKey()
  final bool showAdvancedMetrics;
  @override
  @JsonKey()
  final bool showConfidenceScores;
// Adaptive Pacing (Chronic Illness)
  @override
  @JsonKey()
  final bool enableAdaptivePacing;
  @override
  @JsonKey()
  final PemRiskLevel pemRiskThreshold;
  @override
  @JsonKey()
  final bool showPemWarnings;
  @override
  @JsonKey()
  final int restDayThresholdScore;
// Data Backup
  @override
  @JsonKey()
  final BackupFrequency autoBackupFrequency;
  @override
  @JsonKey()
  final bool enableAutomaticBackup;
  @override
  @JsonKey()
  final DateTime? lastBackupDate;
// Advanced Settings
  @override
  @JsonKey()
  final bool enableDeveloperMode;
  @override
  @JsonKey()
  final bool enableDebugLogging;
  @override
  @JsonKey()
  final SyncFrequency syncFrequency;
  @override
  @JsonKey()
  final bool enableDataValidation;
// Metadata
  @override
  @JsonKey()
  final DateTime? createdAt;
  @override
  @JsonKey()
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final int version;

  @override
  String toString() {
    return 'UserPreferences(userName: $userName, userEmail: $userEmail, age: $age, gender: $gender, heightCm: $heightCm, weightKg: $weightKg, activityLevel: $activityLevel, hasChronicConditions: $hasChronicConditions, medications: $medications, preferredCaptureMethod: $preferredCaptureMethod, captureTimeSeconds: $captureTimeSeconds, enableCaptureSound: $enableCaptureSound, enableHapticFeedback: $enableHapticFeedback, enableFlashlight: $enableFlashlight, autoStartCapture: $autoStartCapture, enableCloudSync: $enableCloudSync, enableDataExport: $enableDataExport, shareAnonymousData: $shareAnonymousData, enableCrashReporting: $enableCrashReporting, dataRetention: $dataRetention, enableDailyReminders: $enableDailyReminders, dailyReminderTime: $dailyReminderTime, enableWeeklyReports: $enableWeeklyReports, enableTrendAlerts: $enableTrendAlerts, enableOvertrainingAlerts: $enableOvertrainingAlerts, themeMode: $themeMode, use24HourFormat: $use24HourFormat, temperatureUnit: $temperatureUnit, distanceUnit: $distanceUnit, defaultChartRange: $defaultChartRange, showAdvancedMetrics: $showAdvancedMetrics, showConfidenceScores: $showConfidenceScores, enableAdaptivePacing: $enableAdaptivePacing, pemRiskThreshold: $pemRiskThreshold, showPemWarnings: $showPemWarnings, restDayThresholdScore: $restDayThresholdScore, autoBackupFrequency: $autoBackupFrequency, enableAutomaticBackup: $enableAutomaticBackup, lastBackupDate: $lastBackupDate, enableDeveloperMode: $enableDeveloperMode, enableDebugLogging: $enableDebugLogging, syncFrequency: $syncFrequency, enableDataValidation: $enableDataValidation, createdAt: $createdAt, updatedAt: $updatedAt, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPreferencesImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.heightCm, heightCm) ||
                other.heightCm == heightCm) &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.activityLevel, activityLevel) ||
                other.activityLevel == activityLevel) &&
            (identical(other.hasChronicConditions, hasChronicConditions) ||
                other.hasChronicConditions == hasChronicConditions) &&
            const DeepCollectionEquality()
                .equals(other._medications, _medications) &&
            (identical(other.preferredCaptureMethod, preferredCaptureMethod) ||
                other.preferredCaptureMethod == preferredCaptureMethod) &&
            (identical(other.captureTimeSeconds, captureTimeSeconds) ||
                other.captureTimeSeconds == captureTimeSeconds) &&
            (identical(other.enableCaptureSound, enableCaptureSound) ||
                other.enableCaptureSound == enableCaptureSound) &&
            (identical(other.enableHapticFeedback, enableHapticFeedback) ||
                other.enableHapticFeedback == enableHapticFeedback) &&
            (identical(other.enableFlashlight, enableFlashlight) ||
                other.enableFlashlight == enableFlashlight) &&
            (identical(other.autoStartCapture, autoStartCapture) ||
                other.autoStartCapture == autoStartCapture) &&
            (identical(other.enableCloudSync, enableCloudSync) ||
                other.enableCloudSync == enableCloudSync) &&
            (identical(other.enableDataExport, enableDataExport) ||
                other.enableDataExport == enableDataExport) &&
            (identical(other.shareAnonymousData, shareAnonymousData) ||
                other.shareAnonymousData == shareAnonymousData) &&
            (identical(other.enableCrashReporting, enableCrashReporting) ||
                other.enableCrashReporting == enableCrashReporting) &&
            (identical(other.dataRetention, dataRetention) ||
                other.dataRetention == dataRetention) &&
            (identical(other.enableDailyReminders, enableDailyReminders) ||
                other.enableDailyReminders == enableDailyReminders) &&
            (identical(other.dailyReminderTime, dailyReminderTime) ||
                other.dailyReminderTime == dailyReminderTime) &&
            (identical(other.enableWeeklyReports, enableWeeklyReports) ||
                other.enableWeeklyReports == enableWeeklyReports) &&
            (identical(other.enableTrendAlerts, enableTrendAlerts) ||
                other.enableTrendAlerts == enableTrendAlerts) &&
            (identical(other.enableOvertrainingAlerts, enableOvertrainingAlerts) ||
                other.enableOvertrainingAlerts == enableOvertrainingAlerts) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.use24HourFormat, use24HourFormat) ||
                other.use24HourFormat == use24HourFormat) &&
            (identical(other.temperatureUnit, temperatureUnit) ||
                other.temperatureUnit == temperatureUnit) &&
            (identical(other.distanceUnit, distanceUnit) ||
                other.distanceUnit == distanceUnit) &&
            (identical(other.defaultChartRange, defaultChartRange) ||
                other.defaultChartRange == defaultChartRange) &&
            (identical(other.showAdvancedMetrics, showAdvancedMetrics) ||
                other.showAdvancedMetrics == showAdvancedMetrics) &&
            (identical(other.showConfidenceScores, showConfidenceScores) ||
                other.showConfidenceScores == showConfidenceScores) &&
            (identical(other.enableAdaptivePacing, enableAdaptivePacing) ||
                other.enableAdaptivePacing == enableAdaptivePacing) &&
            (identical(other.pemRiskThreshold, pemRiskThreshold) ||
                other.pemRiskThreshold == pemRiskThreshold) &&
            (identical(other.showPemWarnings, showPemWarnings) ||
                other.showPemWarnings == showPemWarnings) &&
            (identical(other.restDayThresholdScore, restDayThresholdScore) ||
                other.restDayThresholdScore == restDayThresholdScore) &&
            (identical(other.autoBackupFrequency, autoBackupFrequency) ||
                other.autoBackupFrequency == autoBackupFrequency) &&
            (identical(other.enableAutomaticBackup, enableAutomaticBackup) ||
                other.enableAutomaticBackup == enableAutomaticBackup) &&
            (identical(other.lastBackupDate, lastBackupDate) ||
                other.lastBackupDate == lastBackupDate) &&
            (identical(other.enableDeveloperMode, enableDeveloperMode) ||
                other.enableDeveloperMode == enableDeveloperMode) &&
            (identical(other.enableDebugLogging, enableDebugLogging) ||
                other.enableDebugLogging == enableDebugLogging) &&
            (identical(other.syncFrequency, syncFrequency) || other.syncFrequency == syncFrequency) &&
            (identical(other.enableDataValidation, enableDataValidation) || other.enableDataValidation == enableDataValidation) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        userName,
        userEmail,
        age,
        gender,
        heightCm,
        weightKg,
        activityLevel,
        hasChronicConditions,
        const DeepCollectionEquality().hash(_medications),
        preferredCaptureMethod,
        captureTimeSeconds,
        enableCaptureSound,
        enableHapticFeedback,
        enableFlashlight,
        autoStartCapture,
        enableCloudSync,
        enableDataExport,
        shareAnonymousData,
        enableCrashReporting,
        dataRetention,
        enableDailyReminders,
        dailyReminderTime,
        enableWeeklyReports,
        enableTrendAlerts,
        enableOvertrainingAlerts,
        themeMode,
        use24HourFormat,
        temperatureUnit,
        distanceUnit,
        defaultChartRange,
        showAdvancedMetrics,
        showConfidenceScores,
        enableAdaptivePacing,
        pemRiskThreshold,
        showPemWarnings,
        restDayThresholdScore,
        autoBackupFrequency,
        enableAutomaticBackup,
        lastBackupDate,
        enableDeveloperMode,
        enableDebugLogging,
        syncFrequency,
        enableDataValidation,
        createdAt,
        updatedAt,
        version
      ]);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      __$$UserPreferencesImplCopyWithImpl<_$UserPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPreferencesImplToJson(
      this,
    );
  }
}

abstract class _UserPreferences implements UserPreferences {
  const factory _UserPreferences(
      {final String userName,
      final String? userEmail,
      final int age,
      final UserGender gender,
      final double heightCm,
      final double weightKg,
      final ActivityLevel activityLevel,
      final bool hasChronicConditions,
      final List<String> medications,
      final CaptureMethod preferredCaptureMethod,
      final int captureTimeSeconds,
      final bool enableCaptureSound,
      final bool enableHapticFeedback,
      final bool enableFlashlight,
      final bool autoStartCapture,
      final bool enableCloudSync,
      final bool enableDataExport,
      final bool shareAnonymousData,
      final bool enableCrashReporting,
      final DataRetentionPeriod dataRetention,
      final bool enableDailyReminders,
      final TimeOfDay dailyReminderTime,
      final bool enableWeeklyReports,
      final bool enableTrendAlerts,
      final bool enableOvertrainingAlerts,
      final ThemeMode themeMode,
      final bool use24HourFormat,
      final TemperatureUnit temperatureUnit,
      final DistanceUnit distanceUnit,
      final ChartTimeRange defaultChartRange,
      final bool showAdvancedMetrics,
      final bool showConfidenceScores,
      final bool enableAdaptivePacing,
      final PemRiskLevel pemRiskThreshold,
      final bool showPemWarnings,
      final int restDayThresholdScore,
      final BackupFrequency autoBackupFrequency,
      final bool enableAutomaticBackup,
      final DateTime? lastBackupDate,
      final bool enableDeveloperMode,
      final bool enableDebugLogging,
      final SyncFrequency syncFrequency,
      final bool enableDataValidation,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final int version}) = _$UserPreferencesImpl;

  factory _UserPreferences.fromJson(Map<String, dynamic> json) =
      _$UserPreferencesImpl.fromJson;

// Profile Information
  @override
  String get userName;
  @override
  String? get userEmail;
  @override
  int get age;
  @override
  UserGender get gender;
  @override
  double get heightCm;
  @override
  double get weightKg;
  @override
  ActivityLevel get activityLevel;
  @override
  bool get hasChronicConditions;
  @override
  List<String> get medications; // HRV Capture Preferences
  @override
  CaptureMethod get preferredCaptureMethod;
  @override
  int get captureTimeSeconds; // 3 minutes default
  @override
  bool get enableCaptureSound;
  @override
  bool get enableHapticFeedback;
  @override
  bool get enableFlashlight;
  @override
  bool get autoStartCapture; // Data & Privacy
  @override
  bool get enableCloudSync;
  @override
  bool get enableDataExport;
  @override
  bool get shareAnonymousData;
  @override
  bool get enableCrashReporting;
  @override
  DataRetentionPeriod get dataRetention; // Notifications
  @override
  bool get enableDailyReminders;
  @override
  TimeOfDay get dailyReminderTime;
  @override
  bool get enableWeeklyReports;
  @override
  bool get enableTrendAlerts;
  @override
  bool get enableOvertrainingAlerts; // Display Preferences
  @override
  ThemeMode get themeMode;
  @override
  bool get use24HourFormat;
  @override
  TemperatureUnit get temperatureUnit;
  @override
  DistanceUnit get distanceUnit;
  @override
  ChartTimeRange get defaultChartRange;
  @override
  bool get showAdvancedMetrics;
  @override
  bool get showConfidenceScores; // Adaptive Pacing (Chronic Illness)
  @override
  bool get enableAdaptivePacing;
  @override
  PemRiskLevel get pemRiskThreshold;
  @override
  bool get showPemWarnings;
  @override
  int get restDayThresholdScore; // Data Backup
  @override
  BackupFrequency get autoBackupFrequency;
  @override
  bool get enableAutomaticBackup;
  @override
  DateTime? get lastBackupDate; // Advanced Settings
  @override
  bool get enableDeveloperMode;
  @override
  bool get enableDebugLogging;
  @override
  SyncFrequency get syncFrequency;
  @override
  bool get enableDataValidation; // Metadata
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  int get version;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimeOfDay _$TimeOfDayFromJson(Map<String, dynamic> json) {
  return _TimeOfDay.fromJson(json);
}

/// @nodoc
mixin _$TimeOfDay {
  int get hour => throw _privateConstructorUsedError;
  int get minute => throw _privateConstructorUsedError;

  /// Serializes this TimeOfDay to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeOfDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeOfDayCopyWith<TimeOfDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeOfDayCopyWith<$Res> {
  factory $TimeOfDayCopyWith(TimeOfDay value, $Res Function(TimeOfDay) then) =
      _$TimeOfDayCopyWithImpl<$Res, TimeOfDay>;
  @useResult
  $Res call({int hour, int minute});
}

/// @nodoc
class _$TimeOfDayCopyWithImpl<$Res, $Val extends TimeOfDay>
    implements $TimeOfDayCopyWith<$Res> {
  _$TimeOfDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeOfDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? minute = null,
  }) {
    return _then(_value.copyWith(
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeOfDayImplCopyWith<$Res>
    implements $TimeOfDayCopyWith<$Res> {
  factory _$$TimeOfDayImplCopyWith(
          _$TimeOfDayImpl value, $Res Function(_$TimeOfDayImpl) then) =
      __$$TimeOfDayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int hour, int minute});
}

/// @nodoc
class __$$TimeOfDayImplCopyWithImpl<$Res>
    extends _$TimeOfDayCopyWithImpl<$Res, _$TimeOfDayImpl>
    implements _$$TimeOfDayImplCopyWith<$Res> {
  __$$TimeOfDayImplCopyWithImpl(
      _$TimeOfDayImpl _value, $Res Function(_$TimeOfDayImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimeOfDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? minute = null,
  }) {
    return _then(_$TimeOfDayImpl(
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeOfDayImpl implements _TimeOfDay {
  const _$TimeOfDayImpl({required this.hour, required this.minute});

  factory _$TimeOfDayImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeOfDayImplFromJson(json);

  @override
  final int hour;
  @override
  final int minute;

  @override
  String toString() {
    return 'TimeOfDay(hour: $hour, minute: $minute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeOfDayImpl &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.minute, minute) || other.minute == minute));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, hour, minute);

  /// Create a copy of TimeOfDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeOfDayImplCopyWith<_$TimeOfDayImpl> get copyWith =>
      __$$TimeOfDayImplCopyWithImpl<_$TimeOfDayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeOfDayImplToJson(
      this,
    );
  }
}

abstract class _TimeOfDay implements TimeOfDay {
  const factory _TimeOfDay(
      {required final int hour, required final int minute}) = _$TimeOfDayImpl;

  factory _TimeOfDay.fromJson(Map<String, dynamic> json) =
      _$TimeOfDayImpl.fromJson;

  @override
  int get hour;
  @override
  int get minute;

  /// Create a copy of TimeOfDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeOfDayImplCopyWith<_$TimeOfDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
