import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../features/dashboard/data/repositories/hrv_repository_interface.dart';

/// Service to handle first-time app launch experience and data choices
class FirstLaunchService {
  static const String _firstLaunchKey = 'first_launch_completed';
  static const String _dataChoiceKey = 'user_data_choice';
  
  final FlutterSecureStorage _secureStorage;
  
  FirstLaunchService(this._secureStorage);

  /// Check if this is the user's first time launching the app
  Future<bool> isFirstLaunch() async {
    try {
      final value = await _secureStorage.read(key: _firstLaunchKey);
      return value == null;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking first launch: $e');
      }
      return true; // Default to first launch if we can't read storage
    }
  }

  /// Mark first launch as completed
  Future<void> markFirstLaunchCompleted() async {
    try {
      await _secureStorage.write(key: _firstLaunchKey, value: 'true');
    } catch (e) {
      if (kDebugMode) {
        print('Error marking first launch completed: $e');
      }
    }
  }

  /// Save user's data choice preference
  Future<void> saveDataChoice(UserDataChoice choice) async {
    try {
      await _secureStorage.write(key: _dataChoiceKey, value: choice.name);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving data choice: $e');
      }
    }
  }

  /// Get user's previous data choice
  Future<UserDataChoice?> getDataChoice() async {
    try {
      final value = await _secureStorage.read(key: _dataChoiceKey);
      if (value == null) return null;
      
      return UserDataChoice.values.firstWhere(
        (choice) => choice.name == value,
        orElse: () => UserDataChoice.sampleData,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error getting data choice: $e');
      }
      return null;
    }
  }

  /// Initialize repository based on user choice
  Future<void> initializeBasedOnChoice(
    UserDataChoice choice,
    HrvRepositoryInterface repository,
  ) async {
    try {
      switch (choice) {
        case UserDataChoice.sampleData:
          // Add sample data for demonstration
          await repository.addSampleData();
          if (kDebugMode) {
            print('✅ Sample data added for demonstration');
          }
          break;
        case UserDataChoice.startFresh:
          // Clear any existing data and start fresh
          await repository.clearSampleData();
          if (kDebugMode) {
            print('✅ Starting fresh - no sample data added');
          }
          break;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error initializing repository: $e');
      }
      rethrow;
    }
  }

  /// Reset first launch status (for testing/debugging)
  Future<void> resetFirstLaunch() async {
    try {
      await _secureStorage.delete(key: _firstLaunchKey);
      await _secureStorage.delete(key: _dataChoiceKey);
      if (kDebugMode) {
        print('🔄 First launch status reset');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error resetting first launch: $e');
      }
    }
  }
}

/// User's choice for initial data setup
enum UserDataChoice {
  /// Show sample data for demonstration and learning
  sampleData,
  /// Start fresh with no data, user will capture their own
  startFresh,
}

extension UserDataChoiceExtension on UserDataChoice {
  String get displayName {
    switch (this) {
      case UserDataChoice.sampleData:
        return 'Show Sample Data';
      case UserDataChoice.startFresh:
        return 'Start Fresh';
    }
  }

  String get description {
    switch (this) {
      case UserDataChoice.sampleData:
        return 'Pre-load realistic demo data to explore app features. '
               'You can clear this later and add your own readings.';
      case UserDataChoice.startFresh:
        return 'Start with a clean slate. Your dashboard will be empty '
               'until you capture your first HRV reading.';
    }
  }

  String get icon {
    switch (this) {
      case UserDataChoice.sampleData:
        return '📊';
      case UserDataChoice.startFresh:
        return '🚀';
    }
  }
}