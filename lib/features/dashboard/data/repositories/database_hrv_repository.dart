import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import '../../../../shared/models/hrv_reading.dart' as models;
import '../../../../shared/repositories/database/app_database.dart';
import 'simple_hrv_repository.dart';
import 'hrv_repository_interface.dart';

/// Database-backed HRV repository with encrypted persistence
/// 
/// Uses SQLCipher on mobile/desktop and IndexedDB on web
/// Implements the same interface as SimpleHrvRepository for drop-in replacement
class DatabaseHrvRepository implements HrvRepositoryInterface {
  final AppDatabase _database;

  DatabaseHrvRepository(this._database);

  /// Add a new reading to the database
  Future<void> saveReading(models.HrvReading reading) async {
    try {
      final companion = HrvReadingsCompanion.insert(
        id: reading.id,
        timestamp: reading.timestamp,
        durationSeconds: reading.durationSeconds,
        rrIntervalsJson: jsonEncode(reading.rrIntervals),
        metricsJson: jsonEncode(reading.metrics.toJson()),
        scoresJson: jsonEncode(reading.scores.toJson()),
        notes: Value(reading.notes),
        tagsJson: Value(reading.tags != null ? jsonEncode(reading.tags) : null),
        isSynced: Value(reading.isSynced),
      );

      await _database.into(_database.hrvReadings).insertOnConflictUpdate(companion);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving HRV reading to database: $e');
      }
      rethrow;
    }
  }

  /// Get the most recent reading
  Future<models.HrvReading?> getLatestReading() async {
    try {
      final query = _database.select(_database.hrvReadings)
        ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
        ..limit(1);

      final result = await query.getSingleOrNull();
      return result != null ? _mapToHrvReading(result) : null;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting latest reading from database: $e');
      }
      return null;
    }
  }

  /// Get readings for the last N days
  Future<List<models.HrvReading>> getTrendReadings({int days = 7}) async {
    try {
      final cutoff = DateTime.now().subtract(Duration(days: days));
      
      final query = _database.select(_database.hrvReadings)
        ..where((t) => t.timestamp.isBiggerThanValue(cutoff))
        ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]);

      final results = await query.get();
      return results.map<models.HrvReading>(_mapToHrvReading).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting trend readings from database: $e');
      }
      return [];
    }
  }

  /// Get basic statistics
  Future<DashboardStatistics> getStatistics({int days = 30}) async {
    try {
      final readings = await getTrendReadings(days: days);
      
      if (readings.isEmpty) {
        return const DashboardStatistics(
          totalReadings: 0,
          averageStress: 0,
          averageRecovery: 0,
          averageEnergy: 0,
          averageRmssd: 0.0,
          averageHeartRate: 0.0,
          streakDays: 0,
        );
      }

      final stressSum = readings.map((r) => r.scores.stress).reduce((a, b) => a + b);
      final recoverySum = readings.map((r) => r.scores.recovery).reduce((a, b) => a + b);
      final energySum = readings.map((r) => r.scores.energy).reduce((a, b) => a + b);
      final rmssdSum = readings.map((r) => r.metrics.rmssd).reduce((a, b) => a + b);
      final meanRrSum = readings.map((r) => r.metrics.meanRr).reduce((a, b) => a + b);

      final count = readings.length;

      return DashboardStatistics(
        totalReadings: count,
        averageStress: (stressSum / count).round(),
        averageRecovery: (recoverySum / count).round(),
        averageEnergy: (energySum / count).round(),
        averageRmssd: rmssdSum / count,
        averageHeartRate: 60000 / (meanRrSum / count),
        streakDays: _calculateStreakDays(readings),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error getting statistics from database: $e');
      }
      return const DashboardStatistics(
        totalReadings: 0,
        averageStress: 0,
        averageRecovery: 0,
        averageEnergy: 0,
        averageRmssd: 0.0,
        averageHeartRate: 0.0,
        streakDays: 0,
      );
    }
  }

  /// Calculate consecutive days with readings
  int _calculateStreakDays(List<models.HrvReading> readings) {
    if (readings.isEmpty) return 0;
    
    final dates = <DateTime>{};
    for (final reading in readings) {
      final date = DateTime(
        reading.timestamp.year,
        reading.timestamp.month,
        reading.timestamp.day,
      );
      dates.add(date);
    }
    
    final sortedDates = dates.toList()..sort((a, b) => b.compareTo(a));
    
    int streak = 0;
    DateTime expectedDate = DateTime.now();
    expectedDate = DateTime(expectedDate.year, expectedDate.month, expectedDate.day);
    
    for (final date in sortedDates) {
      if (date.isAtSameMomentAs(expectedDate) || 
          date.isAtSameMomentAs(expectedDate.subtract(const Duration(days: 1)))) {
        streak++;
        expectedDate = date.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    
    return streak;
  }

  /// Add sample data for demo (only if database is empty)
  Future<void> addSampleData() async {
    try {
      // Check if we already have data
      final countQuery = _database.selectOnly(_database.hrvReadings)
        ..addColumns([_database.hrvReadings.id.count()]);
      
      final result = await countQuery.getSingle();
      final existingCount = result.read(_database.hrvReadings.id.count()) ?? 0;
      
      if (existingCount > 0) {
        // Database already has data, don't add sample data
        return;
      }

      final now = DateTime.now();
      
      for (int i = 0; i < 7; i++) {
        final timestamp = now.subtract(Duration(days: i));
        final baseStress = 20 + (i * 5);
        final baseRecovery = 80 - (i * 3);
        final baseEnergy = 70 + (i * 2);
        
        final reading = models.HrvReading(
          id: 'sample_$i',
          timestamp: timestamp,
          durationSeconds: 180,
          metrics: models.HrvMetrics(
            rmssd: 35.0 + (i * 2),
            meanRr: 850.0 + (i * 10),
            sdnn: 45.0 + (i * 1.5),
            lowFrequency: 120.0,
            highFrequency: 180.0,
            lfHfRatio: 0.67,
            baevsky: 85.0,
            coefficientOfVariance: 5.2,
            mxdmn: 180.0,
            moda: 850.0,
            amo50: 42.0,
            pnn50: 25.0,
            pnn20: 45.0,
            totalPower: 1500.0,
            dfaAlpha1: 1.1,
          ),
          rrIntervals: List.generate(100, (index) => 800.0 + (index % 20) * 5),
          scores: models.HrvScores(
            stress: baseStress.clamp(0, 100),
            recovery: baseRecovery.clamp(0, 100),
            energy: baseEnergy.clamp(0, 100),
            confidence: 0.85,
          ),
          notes: 'Sample reading $i',
          tags: ['demo', 'sample'],
        );
        
        await saveReading(reading);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding sample data to database: $e');
      }
      // Don't rethrow - sample data is not critical
    }
  }

  /// Get total number of readings
  Future<int> getTotalReadingsCount() async {
    try {
      final countQuery = _database.selectOnly(_database.hrvReadings)
        ..addColumns([_database.hrvReadings.id.count()]);
      
      final result = await countQuery.getSingle();
      return result.read(_database.hrvReadings.id.count()) ?? 0;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting total readings count: $e');
      }
      return 0;
    }
  }

  /// Delete a reading by ID
  Future<bool> deleteReading(String id) async {
    try {
      final deletedCount = await (_database.delete(_database.hrvReadings)
            ..where((t) => t.id.equals(id)))
          .go();
      return deletedCount > 0;
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting reading from database: $e');
      }
      return false;
    }
  }

  /// Get readings within a date range
  Future<List<models.HrvReading>> getReadingsInRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final query = _database.select(_database.hrvReadings)
        ..where((t) => 
            t.timestamp.isBiggerOrEqualValue(startDate) &
            t.timestamp.isSmallerOrEqualValue(endDate),)
        ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]);

      final results = await query.get();
      return results.map<models.HrvReading>(_mapToHrvReading).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting readings in range from database: $e');
      }
      return [];
    }
  }

  /// Clear all readings (for testing/reset purposes)
  Future<void> clearAllReadings() async {
    try {
      await _database.delete(_database.hrvReadings).go();
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing all readings from database: $e');
      }
      rethrow;
    }
  }

  /// Convert database row to HrvReading model
  models.HrvReading _mapToHrvReading(HrvReading row) {
    try {
      return models.HrvReading(
        id: row.id,
        timestamp: row.timestamp,
        durationSeconds: row.durationSeconds,
        metrics: models.HrvMetrics.fromJson(
          jsonDecode(row.metricsJson) as Map<String, dynamic>,
        ),
        rrIntervals: List<double>.from(
          jsonDecode(row.rrIntervalsJson) as List<dynamic>,
        ),
        scores: models.HrvScores.fromJson(
          jsonDecode(row.scoresJson) as Map<String, dynamic>,
        ),
        notes: row.notes,
        tags: row.tagsJson != null 
            ? List<String>.from(jsonDecode(row.tagsJson!) as List<dynamic>)
            : null,
        isSynced: row.isSynced,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error mapping database row to HrvReading: $e');
        print('Row data: ${row.toString()}');
      }
      rethrow;
    }
  }

  /// Close database connection
  Future<void> dispose() async {
    await _database.close();
  }
}