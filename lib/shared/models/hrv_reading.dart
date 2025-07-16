import 'package:freezed_annotation/freezed_annotation.dart';

part 'hrv_reading.freezed.dart';
part 'hrv_reading.g.dart';

@freezed
class HrvReading with _$HrvReading {
  const factory HrvReading({
    required String id,
    required DateTime timestamp,
    required int durationSeconds,
    required HrvMetrics metrics,
    required List<double> rrIntervals,
    required HrvScores scores,
    String? notes,
    List<String>? tags,
    @Default(false) bool isSynced,
    @Default(true) bool isRealData,
  }) = _HrvReading;

  factory HrvReading.fromJson(Map<String, dynamic> json) =>
      _$HrvReadingFromJson(json);
}

@freezed
class HrvMetrics with _$HrvMetrics {
  const factory HrvMetrics({
    required double rmssd,
    required double meanRr,
    required double sdnn,
    required double lowFrequency,
    required double highFrequency,
    required double lfHfRatio,
    required double baevsky,
    required double coefficientOfVariance,
    required double mxdmn,
    required double moda,
    required double amo50,
    required double pnn50,
    required double pnn20,
    required double totalPower,
    required double dfaAlpha1,
  }) = _HrvMetrics;

  factory HrvMetrics.fromJson(Map<String, dynamic> json) =>
      _$HrvMetricsFromJson(json);
}

@freezed
class HrvScores with _$HrvScores {
  const factory HrvScores({
    required int stress,
    required int recovery,
    required int energy,
    required double confidence,
    @Default(0) int health,
    @Default(0) int focus,
  }) = _HrvScores;

  factory HrvScores.fromJson(Map<String, dynamic> json) =>
      _$HrvScoresFromJson(json);
}