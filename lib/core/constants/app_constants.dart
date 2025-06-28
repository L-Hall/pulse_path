class AppConstants {
  // App Info
  static const String appName = 'PulsePath';
  static const String appVersion = '1.0.0';
  
  // HRV Constants
  static const int hrvReadingDurationMinutes = 3;
  static const int hrvReadingDurationSeconds = hrvReadingDurationMinutes * 60;
  static const int minHeartRateForValidReading = 40;
  static const int maxHeartRateForValidReading = 200;
  static const double hrvAccuracyThresholdMs = 10.0; // ±10ms vs Polar H10
  
  // Performance Targets
  static const int maxColdStartMs = 2000;
  static const int maxWidgetBuildMs = 16;
  static const int maxDashboardLoadMs = 400;
  static const double minPpgSuccessRate = 0.95; // 95%
  
  // Scoring
  static const int minScore = 0;
  static const int maxScore = 100;
  
  // BLE Constants
  static const String heartRateServiceUuid = '0000180d-0000-1000-8000-00805f9b34fb';
  static const String heartRateCharacteristicUuid = '00002a37-0000-1000-8000-00805f9b34fb';
  static const int bleSamplingRateHz = 100;
  
  // Database
  static const String databaseName = 'pulse_path.db';
  static const int databaseVersion = 1;
  
  // Encryption
  static const String encryptionKeyAlias = 'pulse_path_master_key';
  static const int aesKeyLengthBits = 256;
  
  // Cloud Sync
  static const String firestoreCollectionUsers = 'users';
  static const String firestoreCollectionReadings = 'hrv_readings';
  
  // Subscription
  static const String subscriptionMonthlyId = 'pulse_path_monthly';
  static const String subscriptionYearlyId = 'pulse_path_yearly';
  static const String subscriptionLifetimeId = 'pulse_path_lifetime';
  
  // Analytics
  static const String analyticsRetentionDay7 = 'retention_day_7';
  static const String analyticsHrvReadsWeekly = 'hrv_reads_weekly';
  static const String analyticsConversion30d = 'conversion_30d';
  
  // Notification IDs
  static const int notificationIdDailyReminder = 1;
  static const int notificationIdTrendSummary = 2;
}