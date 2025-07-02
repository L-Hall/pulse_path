import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/models/user_preferences.dart';
import '../../../../core/exceptions/app_exceptions.dart';

/// Repository for managing user preferences and settings
class SettingsRepository {
  static const String _settingsBoxName = 'settings';
  static const String _preferencesKey = 'user_preferences';
  static const String _securePreferencesKey = 'secure_preferences';
  
  final FlutterSecureStorage _secureStorage;
  late final Box<dynamic> _settingsBox;
  
  SettingsRepository(this._secureStorage);
  
  /// Initialize the settings repository
  Future<void> initialize() async {
    try {
      // Initialize Hive box for non-sensitive settings
      _settingsBox = await Hive.openBox(_settingsBoxName);
    } catch (e) {
      throw SecureStorageException('Failed to initialize settings storage: $e');
    }
  }
  
  /// Get user preferences with fallback to defaults
  Future<UserPreferences> getUserPreferences() async {
    try {
      // Try to load from secure storage first (for sensitive data)
      final secureData = await _secureStorage.read(key: _securePreferencesKey);
      if (secureData != null) {
        final json = jsonDecode(secureData) as Map<String, dynamic>;
        return UserPreferences.fromJson(json);
      }
      
      // Fallback to regular storage
      final data = _settingsBox.get(_preferencesKey);
      if (data != null && data is Map) {
        return UserPreferences.fromJson(Map<String, dynamic>.from(data));
      }
      
      // Return default preferences
      return _createDefaultPreferences();
    } catch (e) {
      throw SecureStorageException('Failed to load user preferences: $e');
    }
  }
  
  /// Save user preferences
  Future<void> saveUserPreferences(UserPreferences preferences) async {
    try {
      final updatedPreferences = preferences.copyWith(
        updatedAt: DateTime.now(),
        version: preferences.version + 1,
      );
      
      final json = updatedPreferences.toJson();
      
      // Save to secure storage for sensitive data
      final secureJson = _filterSensitiveData(json);
      if (secureJson.isNotEmpty) {
        await _secureStorage.write(
          key: _securePreferencesKey,
          value: jsonEncode(secureJson),
        );
      }
      
      // Save non-sensitive data to regular storage
      final regularJson = _filterNonSensitiveData(json);
      await _settingsBox.put(_preferencesKey, regularJson);
      
    } catch (e) {
      throw SecureStorageException('Failed to save user preferences: $e');
    }
  }
  
  /// Update specific preference field
  Future<void> updatePreference<T>(
    String key,
    T value,
  ) async {
    try {
      final currentPreferences = await getUserPreferences();
      final json = currentPreferences.toJson();
      json[key] = value;
      
      final updatedPreferences = UserPreferences.fromJson(json);
      await saveUserPreferences(updatedPreferences);
    } catch (e) {
      throw SecureStorageException('Failed to update preference $key: $e');
    }
  }
  
  /// Reset preferences to defaults
  Future<void> resetToDefaults() async {
    try {
      await _secureStorage.delete(key: _securePreferencesKey);
      await _settingsBox.delete(_preferencesKey);
    } catch (e) {
      throw SecureStorageException('Failed to reset preferences: $e');
    }
  }
  
  /// Export preferences as JSON
  Future<String> exportPreferences() async {
    try {
      final preferences = await getUserPreferences();
      return jsonEncode(preferences.toJson());
    } catch (e) {
      throw SecureStorageException('Failed to export preferences: $e');
    }
  }
  
  /// Import preferences from JSON
  Future<void> importPreferences(String jsonString) async {
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final preferences = UserPreferences.fromJson(json);
      await saveUserPreferences(preferences);
    } catch (e) {
      throw SecureStorageException('Failed to import preferences: $e');
    }
  }
  
  /// Check if onboarding is complete
  Future<bool> isOnboardingComplete() async {
    try {
      final preferences = await getUserPreferences();
      return preferences.userName.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
  
  /// Get app version for migration purposes
  Future<int> getPreferencesVersion() async {
    try {
      final preferences = await getUserPreferences();
      return preferences.version;
    } catch (e) {
      return 1;
    }
  }
  
  /// Create default preferences for new users
  UserPreferences _createDefaultPreferences() {
    return UserPreferences(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
  
  /// Filter sensitive data for secure storage
  Map<String, dynamic> _filterSensitiveData(Map<String, dynamic> json) {
    const sensitiveKeys = [
      'userEmail',
      'medications',
      'hasChronicConditions',
      'shareAnonymousData',
      'enableCrashReporting',
    ];
    
    return Map.fromEntries(
      json.entries.where((entry) => sensitiveKeys.contains(entry.key)),
    );
  }
  
  /// Filter non-sensitive data for regular storage
  Map<String, dynamic> _filterNonSensitiveData(Map<String, dynamic> json) {
    const sensitiveKeys = [
      'userEmail',
      'medications',
      'hasChronicConditions',
      'shareAnonymousData',
      'enableCrashReporting',
    ];
    
    return Map.fromEntries(
      json.entries.where((entry) => !sensitiveKeys.contains(entry.key)),
    );
  }
  
  /// Dispose resources
  Future<void> dispose() async {
    try {
      await _settingsBox.close();
    } catch (e) {
      // Ignore disposal errors
    }
  }
}