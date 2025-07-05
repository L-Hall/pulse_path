import 'package:flutter/foundation.dart';
import '../../features/dashboard/data/repositories/hrv_repository_interface.dart';
import '../../features/dashboard/data/repositories/simple_hrv_repository.dart';
import '../../features/dashboard/data/repositories/database_hrv_repository.dart';

/// Service to handle data migration between different HRV repository implementations
class DataMigrationService {
  /// Migrate data from SimpleHrvRepository to DatabaseHrvRepository
  /// 
  /// This is useful when switching from in-memory storage to persistent database storage
  Future<bool> migrateFromSimpleToDatabase({
    required SimpleHrvRepository sourceRepository,
    required DatabaseHrvRepository targetRepository,
    bool clearTargetFirst = false,
  }) async {
    try {
      if (kDebugMode) {
        print('Starting data migration from SimpleHrvRepository to DatabaseHrvRepository');
      }

      // Clear target database if requested
      if (clearTargetFirst) {
        await targetRepository.clearAllReadings();
        if (kDebugMode) {
          print('Cleared target database');
        }
      }

      // Get all readings from source repository (last 365 days to ensure we get everything)
      final sourceReadings = await sourceRepository.getTrendReadings(days: 365);
      
      if (sourceReadings.isEmpty) {
        if (kDebugMode) {
          print('No data to migrate from source repository');
        }
        
        // Add sample data to target if it's empty
        await targetRepository.addSampleData();
        return true;
      }

      if (kDebugMode) {
        print('Found ${sourceReadings.length} readings to migrate');
      }

      // Migrate each reading
      int migratedCount = 0;
      for (final reading in sourceReadings) {
        try {
          await targetRepository.saveReading(reading);
          migratedCount++;
        } catch (e) {
          if (kDebugMode) {
            print('Error migrating reading ${reading.id}: $e');
          }
          // Continue with other readings
        }
      }

      if (kDebugMode) {
        print('Successfully migrated $migratedCount out of ${sourceReadings.length} readings');
      }

      return migratedCount > 0;
    } catch (e) {
      if (kDebugMode) {
        print('Error during data migration: $e');
      }
      return false;
    }
  }

  /// Check if migration is needed by comparing data between repositories
  Future<bool> isMigrationNeeded({
    required HrvRepositoryInterface sourceRepository,
    required HrvRepositoryInterface targetRepository,
  }) async {
    try {
      final sourceStats = await sourceRepository.getStatistics(days: 365);
      final targetStats = await targetRepository.getStatistics(days: 365);
      
      // Migration is needed if source has data but target doesn't
      return sourceStats.totalReadings > 0 && targetStats.totalReadings == 0;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking migration need: $e');
      }
      return false;
    }
  }

  /// Initialize repository with sample data if empty
  Future<void> initializeWithSampleDataIfEmpty(HrvRepositoryInterface repository) async {
    try {
      final stats = await repository.getStatistics(days: 1);
      if (stats.totalReadings == 0) {
        await repository.addSampleData();
        if (kDebugMode) {
          print('Added sample data to empty repository');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing repository with sample data: $e');
      }
    }
  }

  /// Get repository statistics for debugging
  Future<Map<String, dynamic>> getRepositoryStats(HrvRepositoryInterface repository) async {
    try {
      final stats = await repository.getStatistics(days: 365);
      final latestReading = await repository.getLatestReading();
      
      return {
        'totalReadings': stats.totalReadings,
        'averageStress': stats.averageStress,
        'averageRecovery': stats.averageRecovery,
        'averageEnergy': stats.averageEnergy,
        'streakDays': stats.streakDays,
        'hasLatestReading': latestReading != null,
        'latestReadingDate': latestReading?.timestamp.toIso8601String(),
      };
    } catch (e) {
      if (kDebugMode) {
        print('Error getting repository stats: $e');
      }
      return {'error': e.toString()};
    }
  }
}