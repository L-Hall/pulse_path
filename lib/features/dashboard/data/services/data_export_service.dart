import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../repositories/simple_hrv_repository.dart';

/// Service for exporting HRV data in various formats
class DataExportService {
  final SimpleHrvRepository _repository;

  DataExportService(this._repository);

  /// Export all data to JSON format
  Future<String> exportToJson() async {
    final readings = await _repository.getTrendReadings(days: 365); // Get all readings
    final stats = await _repository.getStatistics(days: 365);
    
    final data = {
      'exported_at': DateTime.now().toIso8601String(),
      'app_version': '1.0.0',
      'export_format': 'PulsePath JSON v1',
      'summary': {
        'total_readings': stats.totalReadings,
        'date_range': {
          'start': readings.isNotEmpty ? readings.first.timestamp.toIso8601String() : null,
          'end': readings.isNotEmpty ? readings.last.timestamp.toIso8601String() : null,
        },
        'averages': {
          'stress': stats.averageStress,
          'recovery': stats.averageRecovery,
          'energy': stats.averageEnergy,
          'rmssd': stats.averageRmssd,
          'heart_rate': stats.averageHeartRate,
        },
        'streak_days': stats.streakDays,
      },
      'readings': readings.map((reading) => {
        'id': reading.id,
        'timestamp': reading.timestamp.toIso8601String(),
        'duration_seconds': reading.durationSeconds,
        'scores': {
          'stress': reading.scores.stress,
          'recovery': reading.scores.recovery,
          'energy': reading.scores.energy,
          'confidence': reading.scores.confidence,
        },
        'metrics': {
          'rmssd': reading.metrics.rmssd,
          'mean_rr': reading.metrics.meanRr,
          'sdnn': reading.metrics.sdnn,
          'low_frequency': reading.metrics.lowFrequency,
          'high_frequency': reading.metrics.highFrequency,
          'lf_hf_ratio': reading.metrics.lfHfRatio,
          'baevsky': reading.metrics.baevsky,
          'coefficient_of_variance': reading.metrics.coefficientOfVariance,
          'mxdmn': reading.metrics.mxdmn,
          'moda': reading.metrics.moda,
          'amo50': reading.metrics.amo50,
          'pnn50': reading.metrics.pnn50,
          'pnn20': reading.metrics.pnn20,
          'total_power': reading.metrics.totalPower,
          'dfa_alpha1': reading.metrics.dfaAlpha1,
        },
        'notes': reading.notes,
        'tags': reading.tags,
        'rr_intervals_count': reading.rrIntervals.length,
        // Note: RR intervals excluded to reduce file size
        // Include full RR intervals in research export if needed
      }).toList(),
    };
    
    return jsonEncode(data);
  }

  /// Export data to CSV format (simplified)
  Future<String> exportToCsv() async {
    final readings = await _repository.getTrendReadings(days: 365);
    
    final buffer = StringBuffer();
    
    // CSV Header
    buffer.writeln([
      'Date',
      'Time',
      'Stress Score',
      'Recovery Score',
      'Energy Score',
      'Confidence',
      'RMSSD',
      'Mean RR',
      'SDNN',
      'Heart Rate (BPM)',
      'Duration (min)',
      'Notes',
    ].join(','));
    
    // CSV Data
    for (final reading in readings) {
      final heartRate = (60000 / reading.metrics.meanRr).round();
      final duration = (reading.durationSeconds / 60).toStringAsFixed(1);
      
      buffer.writeln([
        reading.timestamp.toIso8601String().split('T')[0], // Date
        reading.timestamp.toIso8601String().split('T')[1].split('.')[0], // Time
        reading.scores.stress,
        reading.scores.recovery,
        reading.scores.energy,
        reading.scores.confidence.toStringAsFixed(2),
        reading.metrics.rmssd.toStringAsFixed(1),
        reading.metrics.meanRr.toStringAsFixed(1),
        reading.metrics.sdnn.toStringAsFixed(1),
        heartRate,
        duration,
        '"${reading.notes ?? ''}"', // Quoted to handle commas in notes
      ].join(','));
    }
    
    return buffer.toString();
  }

  /// Save data export to Downloads directory
  Future<String> saveToFile({bool asJson = true}) async {
    try {
      final data = asJson ? await exportToJson() : await exportToCsv();
      final extension = asJson ? 'json' : 'csv';
      
      final fileName = 'pulsepath_data_${DateTime.now().toIso8601String().split('T')[0]}.$extension';
      
      // Get downloads directory (or documents if downloads not available)
      Directory? directory;
      try {
        directory = await getDownloadsDirectory();
      } catch (e) {
        directory = await getApplicationDocumentsDirectory();
      }
      
      final file = File('${directory!.path}/$fileName');
      
      // Write data to file
      await file.writeAsString(data);
      
      return file.path;
      
    } catch (e) {
      throw Exception('Failed to save data to file: $e');
    }
  }

  /// Copy data to clipboard
  Future<void> copyToClipboard({bool asJson = true}) async {
    try {
      final data = asJson ? await exportToJson() : await exportToCsv();
      await Clipboard.setData(ClipboardData(text: data));
    } catch (e) {
      throw Exception('Failed to copy data to clipboard: $e');
    }
  }

  /// Get export statistics
  Future<Map<String, dynamic>> getExportInfo() async {
    final readings = await _repository.getTrendReadings(days: 365);
    final stats = await _repository.getStatistics(days: 365);
    
    return {
      'total_readings': stats.totalReadings,
      'date_range': readings.isNotEmpty ? {
        'start': readings.first.timestamp,
        'end': readings.last.timestamp,
        'days': readings.last.timestamp.difference(readings.first.timestamp).inDays,
      } : null,
      'estimated_file_sizes': {
        'json_kb': (await exportToJson()).length ~/ 1024,
        'csv_kb': (await exportToCsv()).length ~/ 1024,
      },
    };
  }
}