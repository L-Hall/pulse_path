// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hrv_reading.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HrvReadingImpl _$$HrvReadingImplFromJson(Map<String, dynamic> json) =>
    _$HrvReadingImpl(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      durationSeconds: (json['durationSeconds'] as num).toInt(),
      metrics: HrvMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
      rrIntervals: (json['rrIntervals'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      scores: HrvScores.fromJson(json['scores'] as Map<String, dynamic>),
      notes: json['notes'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isSynced: json['isSynced'] as bool? ?? false,
    );

Map<String, dynamic> _$$HrvReadingImplToJson(_$HrvReadingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'durationSeconds': instance.durationSeconds,
      'metrics': instance.metrics,
      'rrIntervals': instance.rrIntervals,
      'scores': instance.scores,
      'notes': instance.notes,
      'tags': instance.tags,
      'isSynced': instance.isSynced,
    };

_$HrvMetricsImpl _$$HrvMetricsImplFromJson(Map<String, dynamic> json) =>
    _$HrvMetricsImpl(
      rmssd: (json['rmssd'] as num).toDouble(),
      meanRr: (json['meanRr'] as num).toDouble(),
      sdnn: (json['sdnn'] as num).toDouble(),
      lowFrequency: (json['lowFrequency'] as num).toDouble(),
      highFrequency: (json['highFrequency'] as num).toDouble(),
      lfHfRatio: (json['lfHfRatio'] as num).toDouble(),
      baevsky: (json['baevsky'] as num).toDouble(),
      coefficientOfVariance: (json['coefficientOfVariance'] as num).toDouble(),
      mxdmn: (json['mxdmn'] as num).toDouble(),
      moda: (json['moda'] as num).toDouble(),
      amo50: (json['amo50'] as num).toDouble(),
      pnn50: (json['pnn50'] as num).toDouble(),
      pnn20: (json['pnn20'] as num).toDouble(),
      totalPower: (json['totalPower'] as num).toDouble(),
      dfaAlpha1: (json['dfaAlpha1'] as num).toDouble(),
    );

Map<String, dynamic> _$$HrvMetricsImplToJson(_$HrvMetricsImpl instance) =>
    <String, dynamic>{
      'rmssd': instance.rmssd,
      'meanRr': instance.meanRr,
      'sdnn': instance.sdnn,
      'lowFrequency': instance.lowFrequency,
      'highFrequency': instance.highFrequency,
      'lfHfRatio': instance.lfHfRatio,
      'baevsky': instance.baevsky,
      'coefficientOfVariance': instance.coefficientOfVariance,
      'mxdmn': instance.mxdmn,
      'moda': instance.moda,
      'amo50': instance.amo50,
      'pnn50': instance.pnn50,
      'pnn20': instance.pnn20,
      'totalPower': instance.totalPower,
      'dfaAlpha1': instance.dfaAlpha1,
    };

_$HrvScoresImpl _$$HrvScoresImplFromJson(Map<String, dynamic> json) =>
    _$HrvScoresImpl(
      stress: (json['stress'] as num).toInt(),
      recovery: (json['recovery'] as num).toInt(),
      energy: (json['energy'] as num).toInt(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$HrvScoresImplToJson(_$HrvScoresImpl instance) =>
    <String, dynamic>{
      'stress': instance.stress,
      'recovery': instance.recovery,
      'energy': instance.energy,
      'confidence': instance.confidence,
    };
