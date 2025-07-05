// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HrvReadingsTable extends HrvReadings
    with TableInfo<$HrvReadingsTable, HrvReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HrvReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _rrIntervalsJsonMeta =
      const VerificationMeta('rrIntervalsJson');
  @override
  late final GeneratedColumn<String> rrIntervalsJson = GeneratedColumn<String>(
      'rr_intervals_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _metricsJsonMeta =
      const VerificationMeta('metricsJson');
  @override
  late final GeneratedColumn<String> metricsJson = GeneratedColumn<String>(
      'metrics_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scoresJsonMeta =
      const VerificationMeta('scoresJson');
  @override
  late final GeneratedColumn<String> scoresJson = GeneratedColumn<String>(
      'scores_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsJsonMeta =
      const VerificationMeta('tagsJson');
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
      'tags_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        timestamp,
        durationSeconds,
        rrIntervalsJson,
        metricsJson,
        scoresJson,
        notes,
        tagsJson,
        isSynced,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hrv_readings';
  @override
  VerificationContext validateIntegrity(Insertable<HrvReading> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('rr_intervals_json')) {
      context.handle(
          _rrIntervalsJsonMeta,
          rrIntervalsJson.isAcceptableOrUnknown(
              data['rr_intervals_json']!, _rrIntervalsJsonMeta));
    } else if (isInserting) {
      context.missing(_rrIntervalsJsonMeta);
    }
    if (data.containsKey('metrics_json')) {
      context.handle(
          _metricsJsonMeta,
          metricsJson.isAcceptableOrUnknown(
              data['metrics_json']!, _metricsJsonMeta));
    } else if (isInserting) {
      context.missing(_metricsJsonMeta);
    }
    if (data.containsKey('scores_json')) {
      context.handle(
          _scoresJsonMeta,
          scoresJson.isAcceptableOrUnknown(
              data['scores_json']!, _scoresJsonMeta));
    } else if (isInserting) {
      context.missing(_scoresJsonMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('tags_json')) {
      context.handle(_tagsJsonMeta,
          tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HrvReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HrvReading(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds'])!,
      rrIntervalsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}rr_intervals_json'])!,
      metricsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metrics_json'])!,
      scoresJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}scores_json'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      tagsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags_json']),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $HrvReadingsTable createAlias(String alias) {
    return $HrvReadingsTable(attachedDatabase, alias);
  }
}

class HrvReading extends DataClass implements Insertable<HrvReading> {
  final String id;
  final DateTime timestamp;
  final int durationSeconds;
  final String rrIntervalsJson;
  final String metricsJson;
  final String scoresJson;
  final String? notes;
  final String? tagsJson;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime updatedAt;
  const HrvReading(
      {required this.id,
      required this.timestamp,
      required this.durationSeconds,
      required this.rrIntervalsJson,
      required this.metricsJson,
      required this.scoresJson,
      this.notes,
      this.tagsJson,
      required this.isSynced,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['rr_intervals_json'] = Variable<String>(rrIntervalsJson);
    map['metrics_json'] = Variable<String>(metricsJson);
    map['scores_json'] = Variable<String>(scoresJson);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || tagsJson != null) {
      map['tags_json'] = Variable<String>(tagsJson);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HrvReadingsCompanion toCompanion(bool nullToAbsent) {
    return HrvReadingsCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      durationSeconds: Value(durationSeconds),
      rrIntervalsJson: Value(rrIntervalsJson),
      metricsJson: Value(metricsJson),
      scoresJson: Value(scoresJson),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      tagsJson: tagsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(tagsJson),
      isSynced: Value(isSynced),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory HrvReading.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HrvReading(
      id: serializer.fromJson<String>(json['id']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      rrIntervalsJson: serializer.fromJson<String>(json['rrIntervalsJson']),
      metricsJson: serializer.fromJson<String>(json['metricsJson']),
      scoresJson: serializer.fromJson<String>(json['scoresJson']),
      notes: serializer.fromJson<String?>(json['notes']),
      tagsJson: serializer.fromJson<String?>(json['tagsJson']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'rrIntervalsJson': serializer.toJson<String>(rrIntervalsJson),
      'metricsJson': serializer.toJson<String>(metricsJson),
      'scoresJson': serializer.toJson<String>(scoresJson),
      'notes': serializer.toJson<String?>(notes),
      'tagsJson': serializer.toJson<String?>(tagsJson),
      'isSynced': serializer.toJson<bool>(isSynced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  HrvReading copyWith(
          {String? id,
          DateTime? timestamp,
          int? durationSeconds,
          String? rrIntervalsJson,
          String? metricsJson,
          String? scoresJson,
          Value<String?> notes = const Value.absent(),
          Value<String?> tagsJson = const Value.absent(),
          bool? isSynced,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      HrvReading(
        id: id ?? this.id,
        timestamp: timestamp ?? this.timestamp,
        durationSeconds: durationSeconds ?? this.durationSeconds,
        rrIntervalsJson: rrIntervalsJson ?? this.rrIntervalsJson,
        metricsJson: metricsJson ?? this.metricsJson,
        scoresJson: scoresJson ?? this.scoresJson,
        notes: notes.present ? notes.value : this.notes,
        tagsJson: tagsJson.present ? tagsJson.value : this.tagsJson,
        isSynced: isSynced ?? this.isSynced,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  HrvReading copyWithCompanion(HrvReadingsCompanion data) {
    return HrvReading(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      rrIntervalsJson: data.rrIntervalsJson.present
          ? data.rrIntervalsJson.value
          : this.rrIntervalsJson,
      metricsJson:
          data.metricsJson.present ? data.metricsJson.value : this.metricsJson,
      scoresJson:
          data.scoresJson.present ? data.scoresJson.value : this.scoresJson,
      notes: data.notes.present ? data.notes.value : this.notes,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HrvReading(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('rrIntervalsJson: $rrIntervalsJson, ')
          ..write('metricsJson: $metricsJson, ')
          ..write('scoresJson: $scoresJson, ')
          ..write('notes: $notes, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      timestamp,
      durationSeconds,
      rrIntervalsJson,
      metricsJson,
      scoresJson,
      notes,
      tagsJson,
      isSynced,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HrvReading &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.durationSeconds == this.durationSeconds &&
          other.rrIntervalsJson == this.rrIntervalsJson &&
          other.metricsJson == this.metricsJson &&
          other.scoresJson == this.scoresJson &&
          other.notes == this.notes &&
          other.tagsJson == this.tagsJson &&
          other.isSynced == this.isSynced &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HrvReadingsCompanion extends UpdateCompanion<HrvReading> {
  final Value<String> id;
  final Value<DateTime> timestamp;
  final Value<int> durationSeconds;
  final Value<String> rrIntervalsJson;
  final Value<String> metricsJson;
  final Value<String> scoresJson;
  final Value<String?> notes;
  final Value<String?> tagsJson;
  final Value<bool> isSynced;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const HrvReadingsCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.rrIntervalsJson = const Value.absent(),
    this.metricsJson = const Value.absent(),
    this.scoresJson = const Value.absent(),
    this.notes = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HrvReadingsCompanion.insert({
    required String id,
    required DateTime timestamp,
    required int durationSeconds,
    required String rrIntervalsJson,
    required String metricsJson,
    required String scoresJson,
    this.notes = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        timestamp = Value(timestamp),
        durationSeconds = Value(durationSeconds),
        rrIntervalsJson = Value(rrIntervalsJson),
        metricsJson = Value(metricsJson),
        scoresJson = Value(scoresJson);
  static Insertable<HrvReading> custom({
    Expression<String>? id,
    Expression<DateTime>? timestamp,
    Expression<int>? durationSeconds,
    Expression<String>? rrIntervalsJson,
    Expression<String>? metricsJson,
    Expression<String>? scoresJson,
    Expression<String>? notes,
    Expression<String>? tagsJson,
    Expression<bool>? isSynced,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (rrIntervalsJson != null) 'rr_intervals_json': rrIntervalsJson,
      if (metricsJson != null) 'metrics_json': metricsJson,
      if (scoresJson != null) 'scores_json': scoresJson,
      if (notes != null) 'notes': notes,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (isSynced != null) 'is_synced': isSynced,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HrvReadingsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? timestamp,
      Value<int>? durationSeconds,
      Value<String>? rrIntervalsJson,
      Value<String>? metricsJson,
      Value<String>? scoresJson,
      Value<String?>? notes,
      Value<String?>? tagsJson,
      Value<bool>? isSynced,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return HrvReadingsCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      rrIntervalsJson: rrIntervalsJson ?? this.rrIntervalsJson,
      metricsJson: metricsJson ?? this.metricsJson,
      scoresJson: scoresJson ?? this.scoresJson,
      notes: notes ?? this.notes,
      tagsJson: tagsJson ?? this.tagsJson,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (rrIntervalsJson.present) {
      map['rr_intervals_json'] = Variable<String>(rrIntervalsJson.value);
    }
    if (metricsJson.present) {
      map['metrics_json'] = Variable<String>(metricsJson.value);
    }
    if (scoresJson.present) {
      map['scores_json'] = Variable<String>(scoresJson.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HrvReadingsCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('rrIntervalsJson: $rrIntervalsJson, ')
          ..write('metricsJson: $metricsJson, ')
          ..write('scoresJson: $scoresJson, ')
          ..write('notes: $notes, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<Setting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const Setting(
      {required this.key, required this.value, required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Setting copyWith({String? key, String? value, DateTime? updatedAt}) =>
      Setting(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<Setting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith(
      {Value<String>? key,
      Value<String>? value,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
      'action', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dataJsonMeta =
      const VerificationMeta('dataJson');
  @override
  late final GeneratedColumn<String> dataJson = GeneratedColumn<String>(
      'data_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, entityType, entityId, action, dataJson, createdAt, retryCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('action')) {
      context.handle(_actionMeta,
          action.isAcceptableOrUnknown(data['action']!, _actionMeta));
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('data_json')) {
      context.handle(_dataJsonMeta,
          dataJson.isAcceptableOrUnknown(data['data_json']!, _dataJsonMeta));
    } else if (isInserting) {
      context.missing(_dataJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      action: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action'])!,
      dataJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String entityType;
  final String entityId;
  final String action;
  final String dataJson;
  final DateTime createdAt;
  final int retryCount;
  const SyncQueueData(
      {required this.id,
      required this.entityType,
      required this.entityId,
      required this.action,
      required this.dataJson,
      required this.createdAt,
      required this.retryCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['action'] = Variable<String>(action);
    map['data_json'] = Variable<String>(dataJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['retry_count'] = Variable<int>(retryCount);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      action: Value(action),
      dataJson: Value(dataJson),
      createdAt: Value(createdAt),
      retryCount: Value(retryCount),
    );
  }

  factory SyncQueueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      action: serializer.fromJson<String>(json['action']),
      dataJson: serializer.fromJson<String>(json['dataJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'action': serializer.toJson<String>(action),
      'dataJson': serializer.toJson<String>(dataJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'retryCount': serializer.toJson<int>(retryCount),
    };
  }

  SyncQueueData copyWith(
          {int? id,
          String? entityType,
          String? entityId,
          String? action,
          String? dataJson,
          DateTime? createdAt,
          int? retryCount}) =>
      SyncQueueData(
        id: id ?? this.id,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        action: action ?? this.action,
        dataJson: dataJson ?? this.dataJson,
        createdAt: createdAt ?? this.createdAt,
        retryCount: retryCount ?? this.retryCount,
      );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      action: data.action.present ? data.action.value : this.action,
      dataJson: data.dataJson.present ? data.dataJson.value : this.dataJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('action: $action, ')
          ..write('dataJson: $dataJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, entityType, entityId, action, dataJson, createdAt, retryCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.action == this.action &&
          other.dataJson == this.dataJson &&
          other.createdAt == this.createdAt &&
          other.retryCount == this.retryCount);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> action;
  final Value<String> dataJson;
  final Value<DateTime> createdAt;
  final Value<int> retryCount;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.action = const Value.absent(),
    this.dataJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.retryCount = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required String entityId,
    required String action,
    required String dataJson,
    this.createdAt = const Value.absent(),
    this.retryCount = const Value.absent(),
  })  : entityType = Value(entityType),
        entityId = Value(entityId),
        action = Value(action),
        dataJson = Value(dataJson);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? action,
    Expression<String>? dataJson,
    Expression<DateTime>? createdAt,
    Expression<int>? retryCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (action != null) 'action': action,
      if (dataJson != null) 'data_json': dataJson,
      if (createdAt != null) 'created_at': createdAt,
      if (retryCount != null) 'retry_count': retryCount,
    });
  }

  SyncQueueCompanion copyWith(
      {Value<int>? id,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String>? action,
      Value<String>? dataJson,
      Value<DateTime>? createdAt,
      Value<int>? retryCount}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      action: action ?? this.action,
      dataJson: dataJson ?? this.dataJson,
      createdAt: createdAt ?? this.createdAt,
      retryCount: retryCount ?? this.retryCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (dataJson.present) {
      map['data_json'] = Variable<String>(dataJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('action: $action, ')
          ..write('dataJson: $dataJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount')
          ..write(')'))
        .toString();
  }
}

class $DailyHealthMetricsTableTable extends DailyHealthMetricsTable
    with TableInfo<$DailyHealthMetricsTableTable, DailyHealthMetricsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyHealthMetricsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _stepCountMeta =
      const VerificationMeta('stepCount');
  @override
  late final GeneratedColumn<int> stepCount = GeneratedColumn<int>(
      'step_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _distanceKmMeta =
      const VerificationMeta('distanceKm');
  @override
  late final GeneratedColumn<double> distanceKm = GeneratedColumn<double>(
      'distance_km', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _activeMinutesMeta =
      const VerificationMeta('activeMinutes');
  @override
  late final GeneratedColumn<int> activeMinutes = GeneratedColumn<int>(
      'active_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _flightsClimbedMeta =
      const VerificationMeta('flightsClimbed');
  @override
  late final GeneratedColumn<int> flightsClimbed = GeneratedColumn<int>(
      'flights_climbed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _sleepDataJsonMeta =
      const VerificationMeta('sleepDataJson');
  @override
  late final GeneratedColumn<String> sleepDataJson = GeneratedColumn<String>(
      'sleep_data_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _workoutsJsonMeta =
      const VerificationMeta('workoutsJson');
  @override
  late final GeneratedColumn<String> workoutsJson = GeneratedColumn<String>(
      'workouts_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _menstrualDataJsonMeta =
      const VerificationMeta('menstrualDataJson');
  @override
  late final GeneratedColumn<String> menstrualDataJson =
      GeneratedColumn<String>('menstrual_data_json', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _energyLevelMeta =
      const VerificationMeta('energyLevel');
  @override
  late final GeneratedColumn<int> energyLevel = GeneratedColumn<int>(
      'energy_level', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _stressLevelMeta =
      const VerificationMeta('stressLevel');
  @override
  late final GeneratedColumn<int> stressLevel = GeneratedColumn<int>(
      'stress_level', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _symptomsJsonMeta =
      const VerificationMeta('symptomsJson');
  @override
  late final GeneratedColumn<String> symptomsJson = GeneratedColumn<String>(
      'symptoms_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _isCompleteMeta =
      const VerificationMeta('isComplete');
  @override
  late final GeneratedColumn<bool> isComplete = GeneratedColumn<bool>(
      'is_complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_complete" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _dataSourcesJsonMeta =
      const VerificationMeta('dataSourcesJson');
  @override
  late final GeneratedColumn<String> dataSourcesJson = GeneratedColumn<String>(
      'data_sources_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        stepCount,
        distanceKm,
        activeMinutes,
        flightsClimbed,
        sleepDataJson,
        workoutsJson,
        menstrualDataJson,
        energyLevel,
        stressLevel,
        symptomsJson,
        notes,
        isComplete,
        dataSourcesJson,
        createdAt,
        updatedAt,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_health_metrics';
  @override
  VerificationContext validateIntegrity(
      Insertable<DailyHealthMetricsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('step_count')) {
      context.handle(_stepCountMeta,
          stepCount.isAcceptableOrUnknown(data['step_count']!, _stepCountMeta));
    }
    if (data.containsKey('distance_km')) {
      context.handle(
          _distanceKmMeta,
          distanceKm.isAcceptableOrUnknown(
              data['distance_km']!, _distanceKmMeta));
    }
    if (data.containsKey('active_minutes')) {
      context.handle(
          _activeMinutesMeta,
          activeMinutes.isAcceptableOrUnknown(
              data['active_minutes']!, _activeMinutesMeta));
    }
    if (data.containsKey('flights_climbed')) {
      context.handle(
          _flightsClimbedMeta,
          flightsClimbed.isAcceptableOrUnknown(
              data['flights_climbed']!, _flightsClimbedMeta));
    }
    if (data.containsKey('sleep_data_json')) {
      context.handle(
          _sleepDataJsonMeta,
          sleepDataJson.isAcceptableOrUnknown(
              data['sleep_data_json']!, _sleepDataJsonMeta));
    }
    if (data.containsKey('workouts_json')) {
      context.handle(
          _workoutsJsonMeta,
          workoutsJson.isAcceptableOrUnknown(
              data['workouts_json']!, _workoutsJsonMeta));
    }
    if (data.containsKey('menstrual_data_json')) {
      context.handle(
          _menstrualDataJsonMeta,
          menstrualDataJson.isAcceptableOrUnknown(
              data['menstrual_data_json']!, _menstrualDataJsonMeta));
    }
    if (data.containsKey('energy_level')) {
      context.handle(
          _energyLevelMeta,
          energyLevel.isAcceptableOrUnknown(
              data['energy_level']!, _energyLevelMeta));
    }
    if (data.containsKey('stress_level')) {
      context.handle(
          _stressLevelMeta,
          stressLevel.isAcceptableOrUnknown(
              data['stress_level']!, _stressLevelMeta));
    }
    if (data.containsKey('symptoms_json')) {
      context.handle(
          _symptomsJsonMeta,
          symptomsJson.isAcceptableOrUnknown(
              data['symptoms_json']!, _symptomsJsonMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('is_complete')) {
      context.handle(
          _isCompleteMeta,
          isComplete.isAcceptableOrUnknown(
              data['is_complete']!, _isCompleteMeta));
    }
    if (data.containsKey('data_sources_json')) {
      context.handle(
          _dataSourcesJsonMeta,
          dataSourcesJson.isAcceptableOrUnknown(
              data['data_sources_json']!, _dataSourcesJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyHealthMetricsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyHealthMetricsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      stepCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}step_count'])!,
      distanceKm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}distance_km'])!,
      activeMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}active_minutes'])!,
      flightsClimbed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}flights_climbed'])!,
      sleepDataJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sleep_data_json']),
      workoutsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workouts_json'])!,
      menstrualDataJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}menstrual_data_json']),
      energyLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}energy_level']),
      stressLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stress_level']),
      symptomsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symptoms_json'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      isComplete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_complete'])!,
      dataSourcesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}data_sources_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $DailyHealthMetricsTableTable createAlias(String alias) {
    return $DailyHealthMetricsTableTable(attachedDatabase, alias);
  }
}

class DailyHealthMetricsTableData extends DataClass
    implements Insertable<DailyHealthMetricsTableData> {
  final String id;
  final DateTime date;
  final int stepCount;
  final double distanceKm;
  final int activeMinutes;
  final int flightsClimbed;
  final String? sleepDataJson;
  final String workoutsJson;
  final String? menstrualDataJson;
  final int? energyLevel;
  final int? stressLevel;
  final String symptomsJson;
  final String notes;
  final bool isComplete;
  final String dataSourcesJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  const DailyHealthMetricsTableData(
      {required this.id,
      required this.date,
      required this.stepCount,
      required this.distanceKm,
      required this.activeMinutes,
      required this.flightsClimbed,
      this.sleepDataJson,
      required this.workoutsJson,
      this.menstrualDataJson,
      this.energyLevel,
      this.stressLevel,
      required this.symptomsJson,
      required this.notes,
      required this.isComplete,
      required this.dataSourcesJson,
      required this.createdAt,
      required this.updatedAt,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['step_count'] = Variable<int>(stepCount);
    map['distance_km'] = Variable<double>(distanceKm);
    map['active_minutes'] = Variable<int>(activeMinutes);
    map['flights_climbed'] = Variable<int>(flightsClimbed);
    if (!nullToAbsent || sleepDataJson != null) {
      map['sleep_data_json'] = Variable<String>(sleepDataJson);
    }
    map['workouts_json'] = Variable<String>(workoutsJson);
    if (!nullToAbsent || menstrualDataJson != null) {
      map['menstrual_data_json'] = Variable<String>(menstrualDataJson);
    }
    if (!nullToAbsent || energyLevel != null) {
      map['energy_level'] = Variable<int>(energyLevel);
    }
    if (!nullToAbsent || stressLevel != null) {
      map['stress_level'] = Variable<int>(stressLevel);
    }
    map['symptoms_json'] = Variable<String>(symptomsJson);
    map['notes'] = Variable<String>(notes);
    map['is_complete'] = Variable<bool>(isComplete);
    map['data_sources_json'] = Variable<String>(dataSourcesJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  DailyHealthMetricsTableCompanion toCompanion(bool nullToAbsent) {
    return DailyHealthMetricsTableCompanion(
      id: Value(id),
      date: Value(date),
      stepCount: Value(stepCount),
      distanceKm: Value(distanceKm),
      activeMinutes: Value(activeMinutes),
      flightsClimbed: Value(flightsClimbed),
      sleepDataJson: sleepDataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepDataJson),
      workoutsJson: Value(workoutsJson),
      menstrualDataJson: menstrualDataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(menstrualDataJson),
      energyLevel: energyLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(energyLevel),
      stressLevel: stressLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(stressLevel),
      symptomsJson: Value(symptomsJson),
      notes: Value(notes),
      isComplete: Value(isComplete),
      dataSourcesJson: Value(dataSourcesJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory DailyHealthMetricsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyHealthMetricsTableData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      stepCount: serializer.fromJson<int>(json['stepCount']),
      distanceKm: serializer.fromJson<double>(json['distanceKm']),
      activeMinutes: serializer.fromJson<int>(json['activeMinutes']),
      flightsClimbed: serializer.fromJson<int>(json['flightsClimbed']),
      sleepDataJson: serializer.fromJson<String?>(json['sleepDataJson']),
      workoutsJson: serializer.fromJson<String>(json['workoutsJson']),
      menstrualDataJson:
          serializer.fromJson<String?>(json['menstrualDataJson']),
      energyLevel: serializer.fromJson<int?>(json['energyLevel']),
      stressLevel: serializer.fromJson<int?>(json['stressLevel']),
      symptomsJson: serializer.fromJson<String>(json['symptomsJson']),
      notes: serializer.fromJson<String>(json['notes']),
      isComplete: serializer.fromJson<bool>(json['isComplete']),
      dataSourcesJson: serializer.fromJson<String>(json['dataSourcesJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'stepCount': serializer.toJson<int>(stepCount),
      'distanceKm': serializer.toJson<double>(distanceKm),
      'activeMinutes': serializer.toJson<int>(activeMinutes),
      'flightsClimbed': serializer.toJson<int>(flightsClimbed),
      'sleepDataJson': serializer.toJson<String?>(sleepDataJson),
      'workoutsJson': serializer.toJson<String>(workoutsJson),
      'menstrualDataJson': serializer.toJson<String?>(menstrualDataJson),
      'energyLevel': serializer.toJson<int?>(energyLevel),
      'stressLevel': serializer.toJson<int?>(stressLevel),
      'symptomsJson': serializer.toJson<String>(symptomsJson),
      'notes': serializer.toJson<String>(notes),
      'isComplete': serializer.toJson<bool>(isComplete),
      'dataSourcesJson': serializer.toJson<String>(dataSourcesJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  DailyHealthMetricsTableData copyWith(
          {String? id,
          DateTime? date,
          int? stepCount,
          double? distanceKm,
          int? activeMinutes,
          int? flightsClimbed,
          Value<String?> sleepDataJson = const Value.absent(),
          String? workoutsJson,
          Value<String?> menstrualDataJson = const Value.absent(),
          Value<int?> energyLevel = const Value.absent(),
          Value<int?> stressLevel = const Value.absent(),
          String? symptomsJson,
          String? notes,
          bool? isComplete,
          String? dataSourcesJson,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? isSynced}) =>
      DailyHealthMetricsTableData(
        id: id ?? this.id,
        date: date ?? this.date,
        stepCount: stepCount ?? this.stepCount,
        distanceKm: distanceKm ?? this.distanceKm,
        activeMinutes: activeMinutes ?? this.activeMinutes,
        flightsClimbed: flightsClimbed ?? this.flightsClimbed,
        sleepDataJson:
            sleepDataJson.present ? sleepDataJson.value : this.sleepDataJson,
        workoutsJson: workoutsJson ?? this.workoutsJson,
        menstrualDataJson: menstrualDataJson.present
            ? menstrualDataJson.value
            : this.menstrualDataJson,
        energyLevel: energyLevel.present ? energyLevel.value : this.energyLevel,
        stressLevel: stressLevel.present ? stressLevel.value : this.stressLevel,
        symptomsJson: symptomsJson ?? this.symptomsJson,
        notes: notes ?? this.notes,
        isComplete: isComplete ?? this.isComplete,
        dataSourcesJson: dataSourcesJson ?? this.dataSourcesJson,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isSynced: isSynced ?? this.isSynced,
      );
  DailyHealthMetricsTableData copyWithCompanion(
      DailyHealthMetricsTableCompanion data) {
    return DailyHealthMetricsTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      stepCount: data.stepCount.present ? data.stepCount.value : this.stepCount,
      distanceKm:
          data.distanceKm.present ? data.distanceKm.value : this.distanceKm,
      activeMinutes: data.activeMinutes.present
          ? data.activeMinutes.value
          : this.activeMinutes,
      flightsClimbed: data.flightsClimbed.present
          ? data.flightsClimbed.value
          : this.flightsClimbed,
      sleepDataJson: data.sleepDataJson.present
          ? data.sleepDataJson.value
          : this.sleepDataJson,
      workoutsJson: data.workoutsJson.present
          ? data.workoutsJson.value
          : this.workoutsJson,
      menstrualDataJson: data.menstrualDataJson.present
          ? data.menstrualDataJson.value
          : this.menstrualDataJson,
      energyLevel:
          data.energyLevel.present ? data.energyLevel.value : this.energyLevel,
      stressLevel:
          data.stressLevel.present ? data.stressLevel.value : this.stressLevel,
      symptomsJson: data.symptomsJson.present
          ? data.symptomsJson.value
          : this.symptomsJson,
      notes: data.notes.present ? data.notes.value : this.notes,
      isComplete:
          data.isComplete.present ? data.isComplete.value : this.isComplete,
      dataSourcesJson: data.dataSourcesJson.present
          ? data.dataSourcesJson.value
          : this.dataSourcesJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyHealthMetricsTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('stepCount: $stepCount, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('activeMinutes: $activeMinutes, ')
          ..write('flightsClimbed: $flightsClimbed, ')
          ..write('sleepDataJson: $sleepDataJson, ')
          ..write('workoutsJson: $workoutsJson, ')
          ..write('menstrualDataJson: $menstrualDataJson, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('stressLevel: $stressLevel, ')
          ..write('symptomsJson: $symptomsJson, ')
          ..write('notes: $notes, ')
          ..write('isComplete: $isComplete, ')
          ..write('dataSourcesJson: $dataSourcesJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      date,
      stepCount,
      distanceKm,
      activeMinutes,
      flightsClimbed,
      sleepDataJson,
      workoutsJson,
      menstrualDataJson,
      energyLevel,
      stressLevel,
      symptomsJson,
      notes,
      isComplete,
      dataSourcesJson,
      createdAt,
      updatedAt,
      isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyHealthMetricsTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.stepCount == this.stepCount &&
          other.distanceKm == this.distanceKm &&
          other.activeMinutes == this.activeMinutes &&
          other.flightsClimbed == this.flightsClimbed &&
          other.sleepDataJson == this.sleepDataJson &&
          other.workoutsJson == this.workoutsJson &&
          other.menstrualDataJson == this.menstrualDataJson &&
          other.energyLevel == this.energyLevel &&
          other.stressLevel == this.stressLevel &&
          other.symptomsJson == this.symptomsJson &&
          other.notes == this.notes &&
          other.isComplete == this.isComplete &&
          other.dataSourcesJson == this.dataSourcesJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class DailyHealthMetricsTableCompanion
    extends UpdateCompanion<DailyHealthMetricsTableData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<int> stepCount;
  final Value<double> distanceKm;
  final Value<int> activeMinutes;
  final Value<int> flightsClimbed;
  final Value<String?> sleepDataJson;
  final Value<String> workoutsJson;
  final Value<String?> menstrualDataJson;
  final Value<int?> energyLevel;
  final Value<int?> stressLevel;
  final Value<String> symptomsJson;
  final Value<String> notes;
  final Value<bool> isComplete;
  final Value<String> dataSourcesJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const DailyHealthMetricsTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.stepCount = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.activeMinutes = const Value.absent(),
    this.flightsClimbed = const Value.absent(),
    this.sleepDataJson = const Value.absent(),
    this.workoutsJson = const Value.absent(),
    this.menstrualDataJson = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.stressLevel = const Value.absent(),
    this.symptomsJson = const Value.absent(),
    this.notes = const Value.absent(),
    this.isComplete = const Value.absent(),
    this.dataSourcesJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyHealthMetricsTableCompanion.insert({
    required String id,
    required DateTime date,
    this.stepCount = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.activeMinutes = const Value.absent(),
    this.flightsClimbed = const Value.absent(),
    this.sleepDataJson = const Value.absent(),
    this.workoutsJson = const Value.absent(),
    this.menstrualDataJson = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.stressLevel = const Value.absent(),
    this.symptomsJson = const Value.absent(),
    this.notes = const Value.absent(),
    this.isComplete = const Value.absent(),
    this.dataSourcesJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date);
  static Insertable<DailyHealthMetricsTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<int>? stepCount,
    Expression<double>? distanceKm,
    Expression<int>? activeMinutes,
    Expression<int>? flightsClimbed,
    Expression<String>? sleepDataJson,
    Expression<String>? workoutsJson,
    Expression<String>? menstrualDataJson,
    Expression<int>? energyLevel,
    Expression<int>? stressLevel,
    Expression<String>? symptomsJson,
    Expression<String>? notes,
    Expression<bool>? isComplete,
    Expression<String>? dataSourcesJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (stepCount != null) 'step_count': stepCount,
      if (distanceKm != null) 'distance_km': distanceKm,
      if (activeMinutes != null) 'active_minutes': activeMinutes,
      if (flightsClimbed != null) 'flights_climbed': flightsClimbed,
      if (sleepDataJson != null) 'sleep_data_json': sleepDataJson,
      if (workoutsJson != null) 'workouts_json': workoutsJson,
      if (menstrualDataJson != null) 'menstrual_data_json': menstrualDataJson,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (stressLevel != null) 'stress_level': stressLevel,
      if (symptomsJson != null) 'symptoms_json': symptomsJson,
      if (notes != null) 'notes': notes,
      if (isComplete != null) 'is_complete': isComplete,
      if (dataSourcesJson != null) 'data_sources_json': dataSourcesJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyHealthMetricsTableCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? date,
      Value<int>? stepCount,
      Value<double>? distanceKm,
      Value<int>? activeMinutes,
      Value<int>? flightsClimbed,
      Value<String?>? sleepDataJson,
      Value<String>? workoutsJson,
      Value<String?>? menstrualDataJson,
      Value<int?>? energyLevel,
      Value<int?>? stressLevel,
      Value<String>? symptomsJson,
      Value<String>? notes,
      Value<bool>? isComplete,
      Value<String>? dataSourcesJson,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return DailyHealthMetricsTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      stepCount: stepCount ?? this.stepCount,
      distanceKm: distanceKm ?? this.distanceKm,
      activeMinutes: activeMinutes ?? this.activeMinutes,
      flightsClimbed: flightsClimbed ?? this.flightsClimbed,
      sleepDataJson: sleepDataJson ?? this.sleepDataJson,
      workoutsJson: workoutsJson ?? this.workoutsJson,
      menstrualDataJson: menstrualDataJson ?? this.menstrualDataJson,
      energyLevel: energyLevel ?? this.energyLevel,
      stressLevel: stressLevel ?? this.stressLevel,
      symptomsJson: symptomsJson ?? this.symptomsJson,
      notes: notes ?? this.notes,
      isComplete: isComplete ?? this.isComplete,
      dataSourcesJson: dataSourcesJson ?? this.dataSourcesJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (stepCount.present) {
      map['step_count'] = Variable<int>(stepCount.value);
    }
    if (distanceKm.present) {
      map['distance_km'] = Variable<double>(distanceKm.value);
    }
    if (activeMinutes.present) {
      map['active_minutes'] = Variable<int>(activeMinutes.value);
    }
    if (flightsClimbed.present) {
      map['flights_climbed'] = Variable<int>(flightsClimbed.value);
    }
    if (sleepDataJson.present) {
      map['sleep_data_json'] = Variable<String>(sleepDataJson.value);
    }
    if (workoutsJson.present) {
      map['workouts_json'] = Variable<String>(workoutsJson.value);
    }
    if (menstrualDataJson.present) {
      map['menstrual_data_json'] = Variable<String>(menstrualDataJson.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<int>(energyLevel.value);
    }
    if (stressLevel.present) {
      map['stress_level'] = Variable<int>(stressLevel.value);
    }
    if (symptomsJson.present) {
      map['symptoms_json'] = Variable<String>(symptomsJson.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isComplete.present) {
      map['is_complete'] = Variable<bool>(isComplete.value);
    }
    if (dataSourcesJson.present) {
      map['data_sources_json'] = Variable<String>(dataSourcesJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyHealthMetricsTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('stepCount: $stepCount, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('activeMinutes: $activeMinutes, ')
          ..write('flightsClimbed: $flightsClimbed, ')
          ..write('sleepDataJson: $sleepDataJson, ')
          ..write('workoutsJson: $workoutsJson, ')
          ..write('menstrualDataJson: $menstrualDataJson, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('stressLevel: $stressLevel, ')
          ..write('symptomsJson: $symptomsJson, ')
          ..write('notes: $notes, ')
          ..write('isComplete: $isComplete, ')
          ..write('dataSourcesJson: $dataSourcesJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AdaptivePacingAssessmentsTableTable
    extends AdaptivePacingAssessmentsTable
    with
        TableInfo<$AdaptivePacingAssessmentsTableTable,
            AdaptivePacingAssessmentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AdaptivePacingAssessmentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _currentStateJsonMeta =
      const VerificationMeta('currentStateJson');
  @override
  late final GeneratedColumn<String> currentStateJson = GeneratedColumn<String>(
      'current_state_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pemRiskMeta =
      const VerificationMeta('pemRisk');
  @override
  late final GeneratedColumn<String> pemRisk = GeneratedColumn<String>(
      'pem_risk', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _energyEnvelopePercentageMeta =
      const VerificationMeta('energyEnvelopePercentage');
  @override
  late final GeneratedColumn<int> energyEnvelopePercentage =
      GeneratedColumn<int>('energy_envelope_percentage', aliasedName, false,
          type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _hrvContributionJsonMeta =
      const VerificationMeta('hrvContributionJson');
  @override
  late final GeneratedColumn<String> hrvContributionJson =
      GeneratedColumn<String>('hrv_contribution_json', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _activityContributionJsonMeta =
      const VerificationMeta('activityContributionJson');
  @override
  late final GeneratedColumn<String> activityContributionJson =
      GeneratedColumn<String>('activity_contribution_json', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sleepContributionJsonMeta =
      const VerificationMeta('sleepContributionJson');
  @override
  late final GeneratedColumn<String> sleepContributionJson =
      GeneratedColumn<String>('sleep_contribution_json', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _menstrualContributionJsonMeta =
      const VerificationMeta('menstrualContributionJson');
  @override
  late final GeneratedColumn<String> menstrualContributionJson =
      GeneratedColumn<String>('menstrual_contribution_json', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _recommendationsJsonMeta =
      const VerificationMeta('recommendationsJson');
  @override
  late final GeneratedColumn<String> recommendationsJson =
      GeneratedColumn<String>('recommendations_json', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _activityGuidanceJsonMeta =
      const VerificationMeta('activityGuidanceJson');
  @override
  late final GeneratedColumn<String> activityGuidanceJson =
      GeneratedColumn<String>('activity_guidance_json', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _trendWarningsJsonMeta =
      const VerificationMeta('trendWarningsJson');
  @override
  late final GeneratedColumn<String> trendWarningsJson =
      GeneratedColumn<String>('trend_warnings_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _consecutiveHighRiskDaysMeta =
      const VerificationMeta('consecutiveHighRiskDays');
  @override
  late final GeneratedColumn<int> consecutiveHighRiskDays =
      GeneratedColumn<int>('consecutive_high_risk_days', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _sevenDayEnergyTrendMeta =
      const VerificationMeta('sevenDayEnergyTrend');
  @override
  late final GeneratedColumn<double> sevenDayEnergyTrend =
      GeneratedColumn<double>('seven_day_energy_trend', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  static const VerificationMeta _conditionProfileJsonMeta =
      const VerificationMeta('conditionProfileJson');
  @override
  late final GeneratedColumn<String> conditionProfileJson =
      GeneratedColumn<String>('condition_profile_json', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _personalSensitivityMeta =
      const VerificationMeta('personalSensitivity');
  @override
  late final GeneratedColumn<double> personalSensitivity =
      GeneratedColumn<double>('personal_sensitivity', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(1.0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        currentStateJson,
        pemRisk,
        energyEnvelopePercentage,
        hrvContributionJson,
        activityContributionJson,
        sleepContributionJson,
        menstrualContributionJson,
        recommendationsJson,
        activityGuidanceJson,
        trendWarningsJson,
        consecutiveHighRiskDays,
        sevenDayEnergyTrend,
        conditionProfileJson,
        personalSensitivity,
        createdAt,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'adaptive_pacing_assessments';
  @override
  VerificationContext validateIntegrity(
      Insertable<AdaptivePacingAssessmentsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('current_state_json')) {
      context.handle(
          _currentStateJsonMeta,
          currentStateJson.isAcceptableOrUnknown(
              data['current_state_json']!, _currentStateJsonMeta));
    } else if (isInserting) {
      context.missing(_currentStateJsonMeta);
    }
    if (data.containsKey('pem_risk')) {
      context.handle(_pemRiskMeta,
          pemRisk.isAcceptableOrUnknown(data['pem_risk']!, _pemRiskMeta));
    } else if (isInserting) {
      context.missing(_pemRiskMeta);
    }
    if (data.containsKey('energy_envelope_percentage')) {
      context.handle(
          _energyEnvelopePercentageMeta,
          energyEnvelopePercentage.isAcceptableOrUnknown(
              data['energy_envelope_percentage']!,
              _energyEnvelopePercentageMeta));
    } else if (isInserting) {
      context.missing(_energyEnvelopePercentageMeta);
    }
    if (data.containsKey('hrv_contribution_json')) {
      context.handle(
          _hrvContributionJsonMeta,
          hrvContributionJson.isAcceptableOrUnknown(
              data['hrv_contribution_json']!, _hrvContributionJsonMeta));
    } else if (isInserting) {
      context.missing(_hrvContributionJsonMeta);
    }
    if (data.containsKey('activity_contribution_json')) {
      context.handle(
          _activityContributionJsonMeta,
          activityContributionJson.isAcceptableOrUnknown(
              data['activity_contribution_json']!,
              _activityContributionJsonMeta));
    } else if (isInserting) {
      context.missing(_activityContributionJsonMeta);
    }
    if (data.containsKey('sleep_contribution_json')) {
      context.handle(
          _sleepContributionJsonMeta,
          sleepContributionJson.isAcceptableOrUnknown(
              data['sleep_contribution_json']!, _sleepContributionJsonMeta));
    } else if (isInserting) {
      context.missing(_sleepContributionJsonMeta);
    }
    if (data.containsKey('menstrual_contribution_json')) {
      context.handle(
          _menstrualContributionJsonMeta,
          menstrualContributionJson.isAcceptableOrUnknown(
              data['menstrual_contribution_json']!,
              _menstrualContributionJsonMeta));
    }
    if (data.containsKey('recommendations_json')) {
      context.handle(
          _recommendationsJsonMeta,
          recommendationsJson.isAcceptableOrUnknown(
              data['recommendations_json']!, _recommendationsJsonMeta));
    } else if (isInserting) {
      context.missing(_recommendationsJsonMeta);
    }
    if (data.containsKey('activity_guidance_json')) {
      context.handle(
          _activityGuidanceJsonMeta,
          activityGuidanceJson.isAcceptableOrUnknown(
              data['activity_guidance_json']!, _activityGuidanceJsonMeta));
    } else if (isInserting) {
      context.missing(_activityGuidanceJsonMeta);
    }
    if (data.containsKey('trend_warnings_json')) {
      context.handle(
          _trendWarningsJsonMeta,
          trendWarningsJson.isAcceptableOrUnknown(
              data['trend_warnings_json']!, _trendWarningsJsonMeta));
    }
    if (data.containsKey('consecutive_high_risk_days')) {
      context.handle(
          _consecutiveHighRiskDaysMeta,
          consecutiveHighRiskDays.isAcceptableOrUnknown(
              data['consecutive_high_risk_days']!,
              _consecutiveHighRiskDaysMeta));
    }
    if (data.containsKey('seven_day_energy_trend')) {
      context.handle(
          _sevenDayEnergyTrendMeta,
          sevenDayEnergyTrend.isAcceptableOrUnknown(
              data['seven_day_energy_trend']!, _sevenDayEnergyTrendMeta));
    }
    if (data.containsKey('condition_profile_json')) {
      context.handle(
          _conditionProfileJsonMeta,
          conditionProfileJson.isAcceptableOrUnknown(
              data['condition_profile_json']!, _conditionProfileJsonMeta));
    } else if (isInserting) {
      context.missing(_conditionProfileJsonMeta);
    }
    if (data.containsKey('personal_sensitivity')) {
      context.handle(
          _personalSensitivityMeta,
          personalSensitivity.isAcceptableOrUnknown(
              data['personal_sensitivity']!, _personalSensitivityMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AdaptivePacingAssessmentsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AdaptivePacingAssessmentsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      currentStateJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}current_state_json'])!,
      pemRisk: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pem_risk'])!,
      energyEnvelopePercentage: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}energy_envelope_percentage'])!,
      hrvContributionJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}hrv_contribution_json'])!,
      activityContributionJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}activity_contribution_json'])!,
      sleepContributionJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sleep_contribution_json'])!,
      menstrualContributionJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}menstrual_contribution_json']),
      recommendationsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}recommendations_json'])!,
      activityGuidanceJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}activity_guidance_json'])!,
      trendWarningsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}trend_warnings_json'])!,
      consecutiveHighRiskDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}consecutive_high_risk_days'])!,
      sevenDayEnergyTrend: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}seven_day_energy_trend'])!,
      conditionProfileJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}condition_profile_json'])!,
      personalSensitivity: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}personal_sensitivity'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $AdaptivePacingAssessmentsTableTable createAlias(String alias) {
    return $AdaptivePacingAssessmentsTableTable(attachedDatabase, alias);
  }
}

class AdaptivePacingAssessmentsTableData extends DataClass
    implements Insertable<AdaptivePacingAssessmentsTableData> {
  final String id;
  final DateTime date;
  final String currentStateJson;
  final String pemRisk;
  final int energyEnvelopePercentage;
  final String hrvContributionJson;
  final String activityContributionJson;
  final String sleepContributionJson;
  final String? menstrualContributionJson;
  final String recommendationsJson;
  final String activityGuidanceJson;
  final String trendWarningsJson;
  final int consecutiveHighRiskDays;
  final double sevenDayEnergyTrend;
  final String conditionProfileJson;
  final double personalSensitivity;
  final DateTime createdAt;
  final bool isSynced;
  const AdaptivePacingAssessmentsTableData(
      {required this.id,
      required this.date,
      required this.currentStateJson,
      required this.pemRisk,
      required this.energyEnvelopePercentage,
      required this.hrvContributionJson,
      required this.activityContributionJson,
      required this.sleepContributionJson,
      this.menstrualContributionJson,
      required this.recommendationsJson,
      required this.activityGuidanceJson,
      required this.trendWarningsJson,
      required this.consecutiveHighRiskDays,
      required this.sevenDayEnergyTrend,
      required this.conditionProfileJson,
      required this.personalSensitivity,
      required this.createdAt,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['current_state_json'] = Variable<String>(currentStateJson);
    map['pem_risk'] = Variable<String>(pemRisk);
    map['energy_envelope_percentage'] = Variable<int>(energyEnvelopePercentage);
    map['hrv_contribution_json'] = Variable<String>(hrvContributionJson);
    map['activity_contribution_json'] =
        Variable<String>(activityContributionJson);
    map['sleep_contribution_json'] = Variable<String>(sleepContributionJson);
    if (!nullToAbsent || menstrualContributionJson != null) {
      map['menstrual_contribution_json'] =
          Variable<String>(menstrualContributionJson);
    }
    map['recommendations_json'] = Variable<String>(recommendationsJson);
    map['activity_guidance_json'] = Variable<String>(activityGuidanceJson);
    map['trend_warnings_json'] = Variable<String>(trendWarningsJson);
    map['consecutive_high_risk_days'] = Variable<int>(consecutiveHighRiskDays);
    map['seven_day_energy_trend'] = Variable<double>(sevenDayEnergyTrend);
    map['condition_profile_json'] = Variable<String>(conditionProfileJson);
    map['personal_sensitivity'] = Variable<double>(personalSensitivity);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  AdaptivePacingAssessmentsTableCompanion toCompanion(bool nullToAbsent) {
    return AdaptivePacingAssessmentsTableCompanion(
      id: Value(id),
      date: Value(date),
      currentStateJson: Value(currentStateJson),
      pemRisk: Value(pemRisk),
      energyEnvelopePercentage: Value(energyEnvelopePercentage),
      hrvContributionJson: Value(hrvContributionJson),
      activityContributionJson: Value(activityContributionJson),
      sleepContributionJson: Value(sleepContributionJson),
      menstrualContributionJson:
          menstrualContributionJson == null && nullToAbsent
              ? const Value.absent()
              : Value(menstrualContributionJson),
      recommendationsJson: Value(recommendationsJson),
      activityGuidanceJson: Value(activityGuidanceJson),
      trendWarningsJson: Value(trendWarningsJson),
      consecutiveHighRiskDays: Value(consecutiveHighRiskDays),
      sevenDayEnergyTrend: Value(sevenDayEnergyTrend),
      conditionProfileJson: Value(conditionProfileJson),
      personalSensitivity: Value(personalSensitivity),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory AdaptivePacingAssessmentsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AdaptivePacingAssessmentsTableData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      currentStateJson: serializer.fromJson<String>(json['currentStateJson']),
      pemRisk: serializer.fromJson<String>(json['pemRisk']),
      energyEnvelopePercentage:
          serializer.fromJson<int>(json['energyEnvelopePercentage']),
      hrvContributionJson:
          serializer.fromJson<String>(json['hrvContributionJson']),
      activityContributionJson:
          serializer.fromJson<String>(json['activityContributionJson']),
      sleepContributionJson:
          serializer.fromJson<String>(json['sleepContributionJson']),
      menstrualContributionJson:
          serializer.fromJson<String?>(json['menstrualContributionJson']),
      recommendationsJson:
          serializer.fromJson<String>(json['recommendationsJson']),
      activityGuidanceJson:
          serializer.fromJson<String>(json['activityGuidanceJson']),
      trendWarningsJson: serializer.fromJson<String>(json['trendWarningsJson']),
      consecutiveHighRiskDays:
          serializer.fromJson<int>(json['consecutiveHighRiskDays']),
      sevenDayEnergyTrend:
          serializer.fromJson<double>(json['sevenDayEnergyTrend']),
      conditionProfileJson:
          serializer.fromJson<String>(json['conditionProfileJson']),
      personalSensitivity:
          serializer.fromJson<double>(json['personalSensitivity']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'currentStateJson': serializer.toJson<String>(currentStateJson),
      'pemRisk': serializer.toJson<String>(pemRisk),
      'energyEnvelopePercentage':
          serializer.toJson<int>(energyEnvelopePercentage),
      'hrvContributionJson': serializer.toJson<String>(hrvContributionJson),
      'activityContributionJson':
          serializer.toJson<String>(activityContributionJson),
      'sleepContributionJson': serializer.toJson<String>(sleepContributionJson),
      'menstrualContributionJson':
          serializer.toJson<String?>(menstrualContributionJson),
      'recommendationsJson': serializer.toJson<String>(recommendationsJson),
      'activityGuidanceJson': serializer.toJson<String>(activityGuidanceJson),
      'trendWarningsJson': serializer.toJson<String>(trendWarningsJson),
      'consecutiveHighRiskDays':
          serializer.toJson<int>(consecutiveHighRiskDays),
      'sevenDayEnergyTrend': serializer.toJson<double>(sevenDayEnergyTrend),
      'conditionProfileJson': serializer.toJson<String>(conditionProfileJson),
      'personalSensitivity': serializer.toJson<double>(personalSensitivity),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  AdaptivePacingAssessmentsTableData copyWith(
          {String? id,
          DateTime? date,
          String? currentStateJson,
          String? pemRisk,
          int? energyEnvelopePercentage,
          String? hrvContributionJson,
          String? activityContributionJson,
          String? sleepContributionJson,
          Value<String?> menstrualContributionJson = const Value.absent(),
          String? recommendationsJson,
          String? activityGuidanceJson,
          String? trendWarningsJson,
          int? consecutiveHighRiskDays,
          double? sevenDayEnergyTrend,
          String? conditionProfileJson,
          double? personalSensitivity,
          DateTime? createdAt,
          bool? isSynced}) =>
      AdaptivePacingAssessmentsTableData(
        id: id ?? this.id,
        date: date ?? this.date,
        currentStateJson: currentStateJson ?? this.currentStateJson,
        pemRisk: pemRisk ?? this.pemRisk,
        energyEnvelopePercentage:
            energyEnvelopePercentage ?? this.energyEnvelopePercentage,
        hrvContributionJson: hrvContributionJson ?? this.hrvContributionJson,
        activityContributionJson:
            activityContributionJson ?? this.activityContributionJson,
        sleepContributionJson:
            sleepContributionJson ?? this.sleepContributionJson,
        menstrualContributionJson: menstrualContributionJson.present
            ? menstrualContributionJson.value
            : this.menstrualContributionJson,
        recommendationsJson: recommendationsJson ?? this.recommendationsJson,
        activityGuidanceJson: activityGuidanceJson ?? this.activityGuidanceJson,
        trendWarningsJson: trendWarningsJson ?? this.trendWarningsJson,
        consecutiveHighRiskDays:
            consecutiveHighRiskDays ?? this.consecutiveHighRiskDays,
        sevenDayEnergyTrend: sevenDayEnergyTrend ?? this.sevenDayEnergyTrend,
        conditionProfileJson: conditionProfileJson ?? this.conditionProfileJson,
        personalSensitivity: personalSensitivity ?? this.personalSensitivity,
        createdAt: createdAt ?? this.createdAt,
        isSynced: isSynced ?? this.isSynced,
      );
  AdaptivePacingAssessmentsTableData copyWithCompanion(
      AdaptivePacingAssessmentsTableCompanion data) {
    return AdaptivePacingAssessmentsTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      currentStateJson: data.currentStateJson.present
          ? data.currentStateJson.value
          : this.currentStateJson,
      pemRisk: data.pemRisk.present ? data.pemRisk.value : this.pemRisk,
      energyEnvelopePercentage: data.energyEnvelopePercentage.present
          ? data.energyEnvelopePercentage.value
          : this.energyEnvelopePercentage,
      hrvContributionJson: data.hrvContributionJson.present
          ? data.hrvContributionJson.value
          : this.hrvContributionJson,
      activityContributionJson: data.activityContributionJson.present
          ? data.activityContributionJson.value
          : this.activityContributionJson,
      sleepContributionJson: data.sleepContributionJson.present
          ? data.sleepContributionJson.value
          : this.sleepContributionJson,
      menstrualContributionJson: data.menstrualContributionJson.present
          ? data.menstrualContributionJson.value
          : this.menstrualContributionJson,
      recommendationsJson: data.recommendationsJson.present
          ? data.recommendationsJson.value
          : this.recommendationsJson,
      activityGuidanceJson: data.activityGuidanceJson.present
          ? data.activityGuidanceJson.value
          : this.activityGuidanceJson,
      trendWarningsJson: data.trendWarningsJson.present
          ? data.trendWarningsJson.value
          : this.trendWarningsJson,
      consecutiveHighRiskDays: data.consecutiveHighRiskDays.present
          ? data.consecutiveHighRiskDays.value
          : this.consecutiveHighRiskDays,
      sevenDayEnergyTrend: data.sevenDayEnergyTrend.present
          ? data.sevenDayEnergyTrend.value
          : this.sevenDayEnergyTrend,
      conditionProfileJson: data.conditionProfileJson.present
          ? data.conditionProfileJson.value
          : this.conditionProfileJson,
      personalSensitivity: data.personalSensitivity.present
          ? data.personalSensitivity.value
          : this.personalSensitivity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AdaptivePacingAssessmentsTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('currentStateJson: $currentStateJson, ')
          ..write('pemRisk: $pemRisk, ')
          ..write('energyEnvelopePercentage: $energyEnvelopePercentage, ')
          ..write('hrvContributionJson: $hrvContributionJson, ')
          ..write('activityContributionJson: $activityContributionJson, ')
          ..write('sleepContributionJson: $sleepContributionJson, ')
          ..write('menstrualContributionJson: $menstrualContributionJson, ')
          ..write('recommendationsJson: $recommendationsJson, ')
          ..write('activityGuidanceJson: $activityGuidanceJson, ')
          ..write('trendWarningsJson: $trendWarningsJson, ')
          ..write('consecutiveHighRiskDays: $consecutiveHighRiskDays, ')
          ..write('sevenDayEnergyTrend: $sevenDayEnergyTrend, ')
          ..write('conditionProfileJson: $conditionProfileJson, ')
          ..write('personalSensitivity: $personalSensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      date,
      currentStateJson,
      pemRisk,
      energyEnvelopePercentage,
      hrvContributionJson,
      activityContributionJson,
      sleepContributionJson,
      menstrualContributionJson,
      recommendationsJson,
      activityGuidanceJson,
      trendWarningsJson,
      consecutiveHighRiskDays,
      sevenDayEnergyTrend,
      conditionProfileJson,
      personalSensitivity,
      createdAt,
      isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdaptivePacingAssessmentsTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.currentStateJson == this.currentStateJson &&
          other.pemRisk == this.pemRisk &&
          other.energyEnvelopePercentage == this.energyEnvelopePercentage &&
          other.hrvContributionJson == this.hrvContributionJson &&
          other.activityContributionJson == this.activityContributionJson &&
          other.sleepContributionJson == this.sleepContributionJson &&
          other.menstrualContributionJson == this.menstrualContributionJson &&
          other.recommendationsJson == this.recommendationsJson &&
          other.activityGuidanceJson == this.activityGuidanceJson &&
          other.trendWarningsJson == this.trendWarningsJson &&
          other.consecutiveHighRiskDays == this.consecutiveHighRiskDays &&
          other.sevenDayEnergyTrend == this.sevenDayEnergyTrend &&
          other.conditionProfileJson == this.conditionProfileJson &&
          other.personalSensitivity == this.personalSensitivity &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class AdaptivePacingAssessmentsTableCompanion
    extends UpdateCompanion<AdaptivePacingAssessmentsTableData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String> currentStateJson;
  final Value<String> pemRisk;
  final Value<int> energyEnvelopePercentage;
  final Value<String> hrvContributionJson;
  final Value<String> activityContributionJson;
  final Value<String> sleepContributionJson;
  final Value<String?> menstrualContributionJson;
  final Value<String> recommendationsJson;
  final Value<String> activityGuidanceJson;
  final Value<String> trendWarningsJson;
  final Value<int> consecutiveHighRiskDays;
  final Value<double> sevenDayEnergyTrend;
  final Value<String> conditionProfileJson;
  final Value<double> personalSensitivity;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const AdaptivePacingAssessmentsTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.currentStateJson = const Value.absent(),
    this.pemRisk = const Value.absent(),
    this.energyEnvelopePercentage = const Value.absent(),
    this.hrvContributionJson = const Value.absent(),
    this.activityContributionJson = const Value.absent(),
    this.sleepContributionJson = const Value.absent(),
    this.menstrualContributionJson = const Value.absent(),
    this.recommendationsJson = const Value.absent(),
    this.activityGuidanceJson = const Value.absent(),
    this.trendWarningsJson = const Value.absent(),
    this.consecutiveHighRiskDays = const Value.absent(),
    this.sevenDayEnergyTrend = const Value.absent(),
    this.conditionProfileJson = const Value.absent(),
    this.personalSensitivity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AdaptivePacingAssessmentsTableCompanion.insert({
    required String id,
    required DateTime date,
    required String currentStateJson,
    required String pemRisk,
    required int energyEnvelopePercentage,
    required String hrvContributionJson,
    required String activityContributionJson,
    required String sleepContributionJson,
    this.menstrualContributionJson = const Value.absent(),
    required String recommendationsJson,
    required String activityGuidanceJson,
    this.trendWarningsJson = const Value.absent(),
    this.consecutiveHighRiskDays = const Value.absent(),
    this.sevenDayEnergyTrend = const Value.absent(),
    required String conditionProfileJson,
    this.personalSensitivity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        currentStateJson = Value(currentStateJson),
        pemRisk = Value(pemRisk),
        energyEnvelopePercentage = Value(energyEnvelopePercentage),
        hrvContributionJson = Value(hrvContributionJson),
        activityContributionJson = Value(activityContributionJson),
        sleepContributionJson = Value(sleepContributionJson),
        recommendationsJson = Value(recommendationsJson),
        activityGuidanceJson = Value(activityGuidanceJson),
        conditionProfileJson = Value(conditionProfileJson);
  static Insertable<AdaptivePacingAssessmentsTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? currentStateJson,
    Expression<String>? pemRisk,
    Expression<int>? energyEnvelopePercentage,
    Expression<String>? hrvContributionJson,
    Expression<String>? activityContributionJson,
    Expression<String>? sleepContributionJson,
    Expression<String>? menstrualContributionJson,
    Expression<String>? recommendationsJson,
    Expression<String>? activityGuidanceJson,
    Expression<String>? trendWarningsJson,
    Expression<int>? consecutiveHighRiskDays,
    Expression<double>? sevenDayEnergyTrend,
    Expression<String>? conditionProfileJson,
    Expression<double>? personalSensitivity,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (currentStateJson != null) 'current_state_json': currentStateJson,
      if (pemRisk != null) 'pem_risk': pemRisk,
      if (energyEnvelopePercentage != null)
        'energy_envelope_percentage': energyEnvelopePercentage,
      if (hrvContributionJson != null)
        'hrv_contribution_json': hrvContributionJson,
      if (activityContributionJson != null)
        'activity_contribution_json': activityContributionJson,
      if (sleepContributionJson != null)
        'sleep_contribution_json': sleepContributionJson,
      if (menstrualContributionJson != null)
        'menstrual_contribution_json': menstrualContributionJson,
      if (recommendationsJson != null)
        'recommendations_json': recommendationsJson,
      if (activityGuidanceJson != null)
        'activity_guidance_json': activityGuidanceJson,
      if (trendWarningsJson != null) 'trend_warnings_json': trendWarningsJson,
      if (consecutiveHighRiskDays != null)
        'consecutive_high_risk_days': consecutiveHighRiskDays,
      if (sevenDayEnergyTrend != null)
        'seven_day_energy_trend': sevenDayEnergyTrend,
      if (conditionProfileJson != null)
        'condition_profile_json': conditionProfileJson,
      if (personalSensitivity != null)
        'personal_sensitivity': personalSensitivity,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AdaptivePacingAssessmentsTableCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? date,
      Value<String>? currentStateJson,
      Value<String>? pemRisk,
      Value<int>? energyEnvelopePercentage,
      Value<String>? hrvContributionJson,
      Value<String>? activityContributionJson,
      Value<String>? sleepContributionJson,
      Value<String?>? menstrualContributionJson,
      Value<String>? recommendationsJson,
      Value<String>? activityGuidanceJson,
      Value<String>? trendWarningsJson,
      Value<int>? consecutiveHighRiskDays,
      Value<double>? sevenDayEnergyTrend,
      Value<String>? conditionProfileJson,
      Value<double>? personalSensitivity,
      Value<DateTime>? createdAt,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return AdaptivePacingAssessmentsTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      currentStateJson: currentStateJson ?? this.currentStateJson,
      pemRisk: pemRisk ?? this.pemRisk,
      energyEnvelopePercentage:
          energyEnvelopePercentage ?? this.energyEnvelopePercentage,
      hrvContributionJson: hrvContributionJson ?? this.hrvContributionJson,
      activityContributionJson:
          activityContributionJson ?? this.activityContributionJson,
      sleepContributionJson:
          sleepContributionJson ?? this.sleepContributionJson,
      menstrualContributionJson:
          menstrualContributionJson ?? this.menstrualContributionJson,
      recommendationsJson: recommendationsJson ?? this.recommendationsJson,
      activityGuidanceJson: activityGuidanceJson ?? this.activityGuidanceJson,
      trendWarningsJson: trendWarningsJson ?? this.trendWarningsJson,
      consecutiveHighRiskDays:
          consecutiveHighRiskDays ?? this.consecutiveHighRiskDays,
      sevenDayEnergyTrend: sevenDayEnergyTrend ?? this.sevenDayEnergyTrend,
      conditionProfileJson: conditionProfileJson ?? this.conditionProfileJson,
      personalSensitivity: personalSensitivity ?? this.personalSensitivity,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (currentStateJson.present) {
      map['current_state_json'] = Variable<String>(currentStateJson.value);
    }
    if (pemRisk.present) {
      map['pem_risk'] = Variable<String>(pemRisk.value);
    }
    if (energyEnvelopePercentage.present) {
      map['energy_envelope_percentage'] =
          Variable<int>(energyEnvelopePercentage.value);
    }
    if (hrvContributionJson.present) {
      map['hrv_contribution_json'] =
          Variable<String>(hrvContributionJson.value);
    }
    if (activityContributionJson.present) {
      map['activity_contribution_json'] =
          Variable<String>(activityContributionJson.value);
    }
    if (sleepContributionJson.present) {
      map['sleep_contribution_json'] =
          Variable<String>(sleepContributionJson.value);
    }
    if (menstrualContributionJson.present) {
      map['menstrual_contribution_json'] =
          Variable<String>(menstrualContributionJson.value);
    }
    if (recommendationsJson.present) {
      map['recommendations_json'] = Variable<String>(recommendationsJson.value);
    }
    if (activityGuidanceJson.present) {
      map['activity_guidance_json'] =
          Variable<String>(activityGuidanceJson.value);
    }
    if (trendWarningsJson.present) {
      map['trend_warnings_json'] = Variable<String>(trendWarningsJson.value);
    }
    if (consecutiveHighRiskDays.present) {
      map['consecutive_high_risk_days'] =
          Variable<int>(consecutiveHighRiskDays.value);
    }
    if (sevenDayEnergyTrend.present) {
      map['seven_day_energy_trend'] =
          Variable<double>(sevenDayEnergyTrend.value);
    }
    if (conditionProfileJson.present) {
      map['condition_profile_json'] =
          Variable<String>(conditionProfileJson.value);
    }
    if (personalSensitivity.present) {
      map['personal_sensitivity'] = Variable<double>(personalSensitivity.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AdaptivePacingAssessmentsTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('currentStateJson: $currentStateJson, ')
          ..write('pemRisk: $pemRisk, ')
          ..write('energyEnvelopePercentage: $energyEnvelopePercentage, ')
          ..write('hrvContributionJson: $hrvContributionJson, ')
          ..write('activityContributionJson: $activityContributionJson, ')
          ..write('sleepContributionJson: $sleepContributionJson, ')
          ..write('menstrualContributionJson: $menstrualContributionJson, ')
          ..write('recommendationsJson: $recommendationsJson, ')
          ..write('activityGuidanceJson: $activityGuidanceJson, ')
          ..write('trendWarningsJson: $trendWarningsJson, ')
          ..write('consecutiveHighRiskDays: $consecutiveHighRiskDays, ')
          ..write('sevenDayEnergyTrend: $sevenDayEnergyTrend, ')
          ..write('conditionProfileJson: $conditionProfileJson, ')
          ..write('personalSensitivity: $personalSensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSessionsTableTable extends WorkoutSessionsTable
    with TableInfo<$WorkoutSessionsTableTable, WorkoutSessionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSessionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _workoutTypeMeta =
      const VerificationMeta('workoutType');
  @override
  late final GeneratedColumn<String> workoutType = GeneratedColumn<String>(
      'workout_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _perceivedExertionMeta =
      const VerificationMeta('perceivedExertion');
  @override
  late final GeneratedColumn<int> perceivedExertion = GeneratedColumn<int>(
      'perceived_exertion', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _averageHeartRateMeta =
      const VerificationMeta('averageHeartRate');
  @override
  late final GeneratedColumn<double> averageHeartRate = GeneratedColumn<double>(
      'average_heart_rate', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _maxHeartRateMeta =
      const VerificationMeta('maxHeartRate');
  @override
  late final GeneratedColumn<double> maxHeartRate = GeneratedColumn<double>(
      'max_heart_rate', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _caloriesBurnedMeta =
      const VerificationMeta('caloriesBurned');
  @override
  late final GeneratedColumn<int> caloriesBurned = GeneratedColumn<int>(
      'calories_burned', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _distanceKmMeta =
      const VerificationMeta('distanceKm');
  @override
  late final GeneratedColumn<double> distanceKm = GeneratedColumn<double>(
      'distance_km', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
      'steps', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _avgSpeedMeta =
      const VerificationMeta('avgSpeed');
  @override
  late final GeneratedColumn<double> avgSpeed = GeneratedColumn<double>(
      'avg_speed', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _elevationGainMeta =
      const VerificationMeta('elevationGain');
  @override
  late final GeneratedColumn<double> elevationGain = GeneratedColumn<double>(
      'elevation_gain', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _recoveryHeartRateMeta =
      const VerificationMeta('recoveryHeartRate');
  @override
  late final GeneratedColumn<int> recoveryHeartRate = GeneratedColumn<int>(
      'recovery_heart_rate', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _recoveryTimeMinutesMeta =
      const VerificationMeta('recoveryTimeMinutes');
  @override
  late final GeneratedColumn<int> recoveryTimeMinutes = GeneratedColumn<int>(
      'recovery_time_minutes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('unknown'));
  static const VerificationMeta _dailyMetricsIdMeta =
      const VerificationMeta('dailyMetricsId');
  @override
  late final GeneratedColumn<String> dailyMetricsId = GeneratedColumn<String>(
      'daily_metrics_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        startTime,
        endTime,
        workoutType,
        durationMinutes,
        perceivedExertion,
        averageHeartRate,
        maxHeartRate,
        caloriesBurned,
        distanceKm,
        steps,
        avgSpeed,
        elevationGain,
        recoveryHeartRate,
        recoveryTimeMinutes,
        notes,
        source,
        dailyMetricsId,
        createdAt,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions';
  @override
  VerificationContext validateIntegrity(
      Insertable<WorkoutSessionsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('workout_type')) {
      context.handle(
          _workoutTypeMeta,
          workoutType.isAcceptableOrUnknown(
              data['workout_type']!, _workoutTypeMeta));
    } else if (isInserting) {
      context.missing(_workoutTypeMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('perceived_exertion')) {
      context.handle(
          _perceivedExertionMeta,
          perceivedExertion.isAcceptableOrUnknown(
              data['perceived_exertion']!, _perceivedExertionMeta));
    }
    if (data.containsKey('average_heart_rate')) {
      context.handle(
          _averageHeartRateMeta,
          averageHeartRate.isAcceptableOrUnknown(
              data['average_heart_rate']!, _averageHeartRateMeta));
    }
    if (data.containsKey('max_heart_rate')) {
      context.handle(
          _maxHeartRateMeta,
          maxHeartRate.isAcceptableOrUnknown(
              data['max_heart_rate']!, _maxHeartRateMeta));
    }
    if (data.containsKey('calories_burned')) {
      context.handle(
          _caloriesBurnedMeta,
          caloriesBurned.isAcceptableOrUnknown(
              data['calories_burned']!, _caloriesBurnedMeta));
    }
    if (data.containsKey('distance_km')) {
      context.handle(
          _distanceKmMeta,
          distanceKm.isAcceptableOrUnknown(
              data['distance_km']!, _distanceKmMeta));
    }
    if (data.containsKey('steps')) {
      context.handle(
          _stepsMeta, steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta));
    }
    if (data.containsKey('avg_speed')) {
      context.handle(_avgSpeedMeta,
          avgSpeed.isAcceptableOrUnknown(data['avg_speed']!, _avgSpeedMeta));
    }
    if (data.containsKey('elevation_gain')) {
      context.handle(
          _elevationGainMeta,
          elevationGain.isAcceptableOrUnknown(
              data['elevation_gain']!, _elevationGainMeta));
    }
    if (data.containsKey('recovery_heart_rate')) {
      context.handle(
          _recoveryHeartRateMeta,
          recoveryHeartRate.isAcceptableOrUnknown(
              data['recovery_heart_rate']!, _recoveryHeartRateMeta));
    }
    if (data.containsKey('recovery_time_minutes')) {
      context.handle(
          _recoveryTimeMinutesMeta,
          recoveryTimeMinutes.isAcceptableOrUnknown(
              data['recovery_time_minutes']!, _recoveryTimeMinutesMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('daily_metrics_id')) {
      context.handle(
          _dailyMetricsIdMeta,
          dailyMetricsId.isAcceptableOrUnknown(
              data['daily_metrics_id']!, _dailyMetricsIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSessionsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSessionsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time'])!,
      workoutType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workout_type'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes'])!,
      perceivedExertion: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}perceived_exertion']),
      averageHeartRate: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}average_heart_rate']),
      maxHeartRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}max_heart_rate']),
      caloriesBurned: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}calories_burned']),
      distanceKm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}distance_km']),
      steps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}steps']),
      avgSpeed: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}avg_speed']),
      elevationGain: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}elevation_gain']),
      recoveryHeartRate: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}recovery_heart_rate']),
      recoveryTimeMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}recovery_time_minutes']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      dailyMetricsId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}daily_metrics_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $WorkoutSessionsTableTable createAlias(String alias) {
    return $WorkoutSessionsTableTable(attachedDatabase, alias);
  }
}

class WorkoutSessionsTableData extends DataClass
    implements Insertable<WorkoutSessionsTableData> {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String workoutType;
  final int durationMinutes;
  final int? perceivedExertion;
  final double? averageHeartRate;
  final double? maxHeartRate;
  final int? caloriesBurned;
  final double? distanceKm;
  final int? steps;
  final double? avgSpeed;
  final double? elevationGain;
  final int? recoveryHeartRate;
  final int? recoveryTimeMinutes;
  final String notes;
  final String source;
  final String? dailyMetricsId;
  final DateTime createdAt;
  final bool isSynced;
  const WorkoutSessionsTableData(
      {required this.id,
      required this.startTime,
      required this.endTime,
      required this.workoutType,
      required this.durationMinutes,
      this.perceivedExertion,
      this.averageHeartRate,
      this.maxHeartRate,
      this.caloriesBurned,
      this.distanceKm,
      this.steps,
      this.avgSpeed,
      this.elevationGain,
      this.recoveryHeartRate,
      this.recoveryTimeMinutes,
      required this.notes,
      required this.source,
      this.dailyMetricsId,
      required this.createdAt,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['workout_type'] = Variable<String>(workoutType);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || perceivedExertion != null) {
      map['perceived_exertion'] = Variable<int>(perceivedExertion);
    }
    if (!nullToAbsent || averageHeartRate != null) {
      map['average_heart_rate'] = Variable<double>(averageHeartRate);
    }
    if (!nullToAbsent || maxHeartRate != null) {
      map['max_heart_rate'] = Variable<double>(maxHeartRate);
    }
    if (!nullToAbsent || caloriesBurned != null) {
      map['calories_burned'] = Variable<int>(caloriesBurned);
    }
    if (!nullToAbsent || distanceKm != null) {
      map['distance_km'] = Variable<double>(distanceKm);
    }
    if (!nullToAbsent || steps != null) {
      map['steps'] = Variable<int>(steps);
    }
    if (!nullToAbsent || avgSpeed != null) {
      map['avg_speed'] = Variable<double>(avgSpeed);
    }
    if (!nullToAbsent || elevationGain != null) {
      map['elevation_gain'] = Variable<double>(elevationGain);
    }
    if (!nullToAbsent || recoveryHeartRate != null) {
      map['recovery_heart_rate'] = Variable<int>(recoveryHeartRate);
    }
    if (!nullToAbsent || recoveryTimeMinutes != null) {
      map['recovery_time_minutes'] = Variable<int>(recoveryTimeMinutes);
    }
    map['notes'] = Variable<String>(notes);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || dailyMetricsId != null) {
      map['daily_metrics_id'] = Variable<String>(dailyMetricsId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  WorkoutSessionsTableCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsTableCompanion(
      id: Value(id),
      startTime: Value(startTime),
      endTime: Value(endTime),
      workoutType: Value(workoutType),
      durationMinutes: Value(durationMinutes),
      perceivedExertion: perceivedExertion == null && nullToAbsent
          ? const Value.absent()
          : Value(perceivedExertion),
      averageHeartRate: averageHeartRate == null && nullToAbsent
          ? const Value.absent()
          : Value(averageHeartRate),
      maxHeartRate: maxHeartRate == null && nullToAbsent
          ? const Value.absent()
          : Value(maxHeartRate),
      caloriesBurned: caloriesBurned == null && nullToAbsent
          ? const Value.absent()
          : Value(caloriesBurned),
      distanceKm: distanceKm == null && nullToAbsent
          ? const Value.absent()
          : Value(distanceKm),
      steps:
          steps == null && nullToAbsent ? const Value.absent() : Value(steps),
      avgSpeed: avgSpeed == null && nullToAbsent
          ? const Value.absent()
          : Value(avgSpeed),
      elevationGain: elevationGain == null && nullToAbsent
          ? const Value.absent()
          : Value(elevationGain),
      recoveryHeartRate: recoveryHeartRate == null && nullToAbsent
          ? const Value.absent()
          : Value(recoveryHeartRate),
      recoveryTimeMinutes: recoveryTimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(recoveryTimeMinutes),
      notes: Value(notes),
      source: Value(source),
      dailyMetricsId: dailyMetricsId == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyMetricsId),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory WorkoutSessionsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSessionsTableData(
      id: serializer.fromJson<String>(json['id']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      workoutType: serializer.fromJson<String>(json['workoutType']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      perceivedExertion: serializer.fromJson<int?>(json['perceivedExertion']),
      averageHeartRate: serializer.fromJson<double?>(json['averageHeartRate']),
      maxHeartRate: serializer.fromJson<double?>(json['maxHeartRate']),
      caloriesBurned: serializer.fromJson<int?>(json['caloriesBurned']),
      distanceKm: serializer.fromJson<double?>(json['distanceKm']),
      steps: serializer.fromJson<int?>(json['steps']),
      avgSpeed: serializer.fromJson<double?>(json['avgSpeed']),
      elevationGain: serializer.fromJson<double?>(json['elevationGain']),
      recoveryHeartRate: serializer.fromJson<int?>(json['recoveryHeartRate']),
      recoveryTimeMinutes:
          serializer.fromJson<int?>(json['recoveryTimeMinutes']),
      notes: serializer.fromJson<String>(json['notes']),
      source: serializer.fromJson<String>(json['source']),
      dailyMetricsId: serializer.fromJson<String?>(json['dailyMetricsId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'workoutType': serializer.toJson<String>(workoutType),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'perceivedExertion': serializer.toJson<int?>(perceivedExertion),
      'averageHeartRate': serializer.toJson<double?>(averageHeartRate),
      'maxHeartRate': serializer.toJson<double?>(maxHeartRate),
      'caloriesBurned': serializer.toJson<int?>(caloriesBurned),
      'distanceKm': serializer.toJson<double?>(distanceKm),
      'steps': serializer.toJson<int?>(steps),
      'avgSpeed': serializer.toJson<double?>(avgSpeed),
      'elevationGain': serializer.toJson<double?>(elevationGain),
      'recoveryHeartRate': serializer.toJson<int?>(recoveryHeartRate),
      'recoveryTimeMinutes': serializer.toJson<int?>(recoveryTimeMinutes),
      'notes': serializer.toJson<String>(notes),
      'source': serializer.toJson<String>(source),
      'dailyMetricsId': serializer.toJson<String?>(dailyMetricsId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  WorkoutSessionsTableData copyWith(
          {String? id,
          DateTime? startTime,
          DateTime? endTime,
          String? workoutType,
          int? durationMinutes,
          Value<int?> perceivedExertion = const Value.absent(),
          Value<double?> averageHeartRate = const Value.absent(),
          Value<double?> maxHeartRate = const Value.absent(),
          Value<int?> caloriesBurned = const Value.absent(),
          Value<double?> distanceKm = const Value.absent(),
          Value<int?> steps = const Value.absent(),
          Value<double?> avgSpeed = const Value.absent(),
          Value<double?> elevationGain = const Value.absent(),
          Value<int?> recoveryHeartRate = const Value.absent(),
          Value<int?> recoveryTimeMinutes = const Value.absent(),
          String? notes,
          String? source,
          Value<String?> dailyMetricsId = const Value.absent(),
          DateTime? createdAt,
          bool? isSynced}) =>
      WorkoutSessionsTableData(
        id: id ?? this.id,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        workoutType: workoutType ?? this.workoutType,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        perceivedExertion: perceivedExertion.present
            ? perceivedExertion.value
            : this.perceivedExertion,
        averageHeartRate: averageHeartRate.present
            ? averageHeartRate.value
            : this.averageHeartRate,
        maxHeartRate:
            maxHeartRate.present ? maxHeartRate.value : this.maxHeartRate,
        caloriesBurned:
            caloriesBurned.present ? caloriesBurned.value : this.caloriesBurned,
        distanceKm: distanceKm.present ? distanceKm.value : this.distanceKm,
        steps: steps.present ? steps.value : this.steps,
        avgSpeed: avgSpeed.present ? avgSpeed.value : this.avgSpeed,
        elevationGain:
            elevationGain.present ? elevationGain.value : this.elevationGain,
        recoveryHeartRate: recoveryHeartRate.present
            ? recoveryHeartRate.value
            : this.recoveryHeartRate,
        recoveryTimeMinutes: recoveryTimeMinutes.present
            ? recoveryTimeMinutes.value
            : this.recoveryTimeMinutes,
        notes: notes ?? this.notes,
        source: source ?? this.source,
        dailyMetricsId:
            dailyMetricsId.present ? dailyMetricsId.value : this.dailyMetricsId,
        createdAt: createdAt ?? this.createdAt,
        isSynced: isSynced ?? this.isSynced,
      );
  WorkoutSessionsTableData copyWithCompanion(
      WorkoutSessionsTableCompanion data) {
    return WorkoutSessionsTableData(
      id: data.id.present ? data.id.value : this.id,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      workoutType:
          data.workoutType.present ? data.workoutType.value : this.workoutType,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      perceivedExertion: data.perceivedExertion.present
          ? data.perceivedExertion.value
          : this.perceivedExertion,
      averageHeartRate: data.averageHeartRate.present
          ? data.averageHeartRate.value
          : this.averageHeartRate,
      maxHeartRate: data.maxHeartRate.present
          ? data.maxHeartRate.value
          : this.maxHeartRate,
      caloriesBurned: data.caloriesBurned.present
          ? data.caloriesBurned.value
          : this.caloriesBurned,
      distanceKm:
          data.distanceKm.present ? data.distanceKm.value : this.distanceKm,
      steps: data.steps.present ? data.steps.value : this.steps,
      avgSpeed: data.avgSpeed.present ? data.avgSpeed.value : this.avgSpeed,
      elevationGain: data.elevationGain.present
          ? data.elevationGain.value
          : this.elevationGain,
      recoveryHeartRate: data.recoveryHeartRate.present
          ? data.recoveryHeartRate.value
          : this.recoveryHeartRate,
      recoveryTimeMinutes: data.recoveryTimeMinutes.present
          ? data.recoveryTimeMinutes.value
          : this.recoveryTimeMinutes,
      notes: data.notes.present ? data.notes.value : this.notes,
      source: data.source.present ? data.source.value : this.source,
      dailyMetricsId: data.dailyMetricsId.present
          ? data.dailyMetricsId.value
          : this.dailyMetricsId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsTableData(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('workoutType: $workoutType, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('perceivedExertion: $perceivedExertion, ')
          ..write('averageHeartRate: $averageHeartRate, ')
          ..write('maxHeartRate: $maxHeartRate, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('steps: $steps, ')
          ..write('avgSpeed: $avgSpeed, ')
          ..write('elevationGain: $elevationGain, ')
          ..write('recoveryHeartRate: $recoveryHeartRate, ')
          ..write('recoveryTimeMinutes: $recoveryTimeMinutes, ')
          ..write('notes: $notes, ')
          ..write('source: $source, ')
          ..write('dailyMetricsId: $dailyMetricsId, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      startTime,
      endTime,
      workoutType,
      durationMinutes,
      perceivedExertion,
      averageHeartRate,
      maxHeartRate,
      caloriesBurned,
      distanceKm,
      steps,
      avgSpeed,
      elevationGain,
      recoveryHeartRate,
      recoveryTimeMinutes,
      notes,
      source,
      dailyMetricsId,
      createdAt,
      isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSessionsTableData &&
          other.id == this.id &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.workoutType == this.workoutType &&
          other.durationMinutes == this.durationMinutes &&
          other.perceivedExertion == this.perceivedExertion &&
          other.averageHeartRate == this.averageHeartRate &&
          other.maxHeartRate == this.maxHeartRate &&
          other.caloriesBurned == this.caloriesBurned &&
          other.distanceKm == this.distanceKm &&
          other.steps == this.steps &&
          other.avgSpeed == this.avgSpeed &&
          other.elevationGain == this.elevationGain &&
          other.recoveryHeartRate == this.recoveryHeartRate &&
          other.recoveryTimeMinutes == this.recoveryTimeMinutes &&
          other.notes == this.notes &&
          other.source == this.source &&
          other.dailyMetricsId == this.dailyMetricsId &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class WorkoutSessionsTableCompanion
    extends UpdateCompanion<WorkoutSessionsTableData> {
  final Value<String> id;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<String> workoutType;
  final Value<int> durationMinutes;
  final Value<int?> perceivedExertion;
  final Value<double?> averageHeartRate;
  final Value<double?> maxHeartRate;
  final Value<int?> caloriesBurned;
  final Value<double?> distanceKm;
  final Value<int?> steps;
  final Value<double?> avgSpeed;
  final Value<double?> elevationGain;
  final Value<int?> recoveryHeartRate;
  final Value<int?> recoveryTimeMinutes;
  final Value<String> notes;
  final Value<String> source;
  final Value<String?> dailyMetricsId;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const WorkoutSessionsTableCompanion({
    this.id = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.workoutType = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.perceivedExertion = const Value.absent(),
    this.averageHeartRate = const Value.absent(),
    this.maxHeartRate = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.steps = const Value.absent(),
    this.avgSpeed = const Value.absent(),
    this.elevationGain = const Value.absent(),
    this.recoveryHeartRate = const Value.absent(),
    this.recoveryTimeMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.source = const Value.absent(),
    this.dailyMetricsId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutSessionsTableCompanion.insert({
    required String id,
    required DateTime startTime,
    required DateTime endTime,
    required String workoutType,
    required int durationMinutes,
    this.perceivedExertion = const Value.absent(),
    this.averageHeartRate = const Value.absent(),
    this.maxHeartRate = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.steps = const Value.absent(),
    this.avgSpeed = const Value.absent(),
    this.elevationGain = const Value.absent(),
    this.recoveryHeartRate = const Value.absent(),
    this.recoveryTimeMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.source = const Value.absent(),
    this.dailyMetricsId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        startTime = Value(startTime),
        endTime = Value(endTime),
        workoutType = Value(workoutType),
        durationMinutes = Value(durationMinutes);
  static Insertable<WorkoutSessionsTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? workoutType,
    Expression<int>? durationMinutes,
    Expression<int>? perceivedExertion,
    Expression<double>? averageHeartRate,
    Expression<double>? maxHeartRate,
    Expression<int>? caloriesBurned,
    Expression<double>? distanceKm,
    Expression<int>? steps,
    Expression<double>? avgSpeed,
    Expression<double>? elevationGain,
    Expression<int>? recoveryHeartRate,
    Expression<int>? recoveryTimeMinutes,
    Expression<String>? notes,
    Expression<String>? source,
    Expression<String>? dailyMetricsId,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (workoutType != null) 'workout_type': workoutType,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (perceivedExertion != null) 'perceived_exertion': perceivedExertion,
      if (averageHeartRate != null) 'average_heart_rate': averageHeartRate,
      if (maxHeartRate != null) 'max_heart_rate': maxHeartRate,
      if (caloriesBurned != null) 'calories_burned': caloriesBurned,
      if (distanceKm != null) 'distance_km': distanceKm,
      if (steps != null) 'steps': steps,
      if (avgSpeed != null) 'avg_speed': avgSpeed,
      if (elevationGain != null) 'elevation_gain': elevationGain,
      if (recoveryHeartRate != null) 'recovery_heart_rate': recoveryHeartRate,
      if (recoveryTimeMinutes != null)
        'recovery_time_minutes': recoveryTimeMinutes,
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
      if (dailyMetricsId != null) 'daily_metrics_id': dailyMetricsId,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutSessionsTableCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? startTime,
      Value<DateTime>? endTime,
      Value<String>? workoutType,
      Value<int>? durationMinutes,
      Value<int?>? perceivedExertion,
      Value<double?>? averageHeartRate,
      Value<double?>? maxHeartRate,
      Value<int?>? caloriesBurned,
      Value<double?>? distanceKm,
      Value<int?>? steps,
      Value<double?>? avgSpeed,
      Value<double?>? elevationGain,
      Value<int?>? recoveryHeartRate,
      Value<int?>? recoveryTimeMinutes,
      Value<String>? notes,
      Value<String>? source,
      Value<String?>? dailyMetricsId,
      Value<DateTime>? createdAt,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return WorkoutSessionsTableCompanion(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      workoutType: workoutType ?? this.workoutType,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      perceivedExertion: perceivedExertion ?? this.perceivedExertion,
      averageHeartRate: averageHeartRate ?? this.averageHeartRate,
      maxHeartRate: maxHeartRate ?? this.maxHeartRate,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      distanceKm: distanceKm ?? this.distanceKm,
      steps: steps ?? this.steps,
      avgSpeed: avgSpeed ?? this.avgSpeed,
      elevationGain: elevationGain ?? this.elevationGain,
      recoveryHeartRate: recoveryHeartRate ?? this.recoveryHeartRate,
      recoveryTimeMinutes: recoveryTimeMinutes ?? this.recoveryTimeMinutes,
      notes: notes ?? this.notes,
      source: source ?? this.source,
      dailyMetricsId: dailyMetricsId ?? this.dailyMetricsId,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (workoutType.present) {
      map['workout_type'] = Variable<String>(workoutType.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (perceivedExertion.present) {
      map['perceived_exertion'] = Variable<int>(perceivedExertion.value);
    }
    if (averageHeartRate.present) {
      map['average_heart_rate'] = Variable<double>(averageHeartRate.value);
    }
    if (maxHeartRate.present) {
      map['max_heart_rate'] = Variable<double>(maxHeartRate.value);
    }
    if (caloriesBurned.present) {
      map['calories_burned'] = Variable<int>(caloriesBurned.value);
    }
    if (distanceKm.present) {
      map['distance_km'] = Variable<double>(distanceKm.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (avgSpeed.present) {
      map['avg_speed'] = Variable<double>(avgSpeed.value);
    }
    if (elevationGain.present) {
      map['elevation_gain'] = Variable<double>(elevationGain.value);
    }
    if (recoveryHeartRate.present) {
      map['recovery_heart_rate'] = Variable<int>(recoveryHeartRate.value);
    }
    if (recoveryTimeMinutes.present) {
      map['recovery_time_minutes'] = Variable<int>(recoveryTimeMinutes.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (dailyMetricsId.present) {
      map['daily_metrics_id'] = Variable<String>(dailyMetricsId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('workoutType: $workoutType, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('perceivedExertion: $perceivedExertion, ')
          ..write('averageHeartRate: $averageHeartRate, ')
          ..write('maxHeartRate: $maxHeartRate, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('steps: $steps, ')
          ..write('avgSpeed: $avgSpeed, ')
          ..write('elevationGain: $elevationGain, ')
          ..write('recoveryHeartRate: $recoveryHeartRate, ')
          ..write('recoveryTimeMinutes: $recoveryTimeMinutes, ')
          ..write('notes: $notes, ')
          ..write('source: $source, ')
          ..write('dailyMetricsId: $dailyMetricsId, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HrvReadingsTable hrvReadings = $HrvReadingsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $DailyHealthMetricsTableTable dailyHealthMetricsTable =
      $DailyHealthMetricsTableTable(this);
  late final $AdaptivePacingAssessmentsTableTable
      adaptivePacingAssessmentsTable =
      $AdaptivePacingAssessmentsTableTable(this);
  late final $WorkoutSessionsTableTable workoutSessionsTable =
      $WorkoutSessionsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        hrvReadings,
        settings,
        syncQueue,
        dailyHealthMetricsTable,
        adaptivePacingAssessmentsTable,
        workoutSessionsTable
      ];
}

typedef $$HrvReadingsTableCreateCompanionBuilder = HrvReadingsCompanion
    Function({
  required String id,
  required DateTime timestamp,
  required int durationSeconds,
  required String rrIntervalsJson,
  required String metricsJson,
  required String scoresJson,
  Value<String?> notes,
  Value<String?> tagsJson,
  Value<bool> isSynced,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$HrvReadingsTableUpdateCompanionBuilder = HrvReadingsCompanion
    Function({
  Value<String> id,
  Value<DateTime> timestamp,
  Value<int> durationSeconds,
  Value<String> rrIntervalsJson,
  Value<String> metricsJson,
  Value<String> scoresJson,
  Value<String?> notes,
  Value<String?> tagsJson,
  Value<bool> isSynced,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$HrvReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $HrvReadingsTable> {
  $$HrvReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rrIntervalsJson => $composableBuilder(
      column: $table.rrIntervalsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metricsJson => $composableBuilder(
      column: $table.metricsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scoresJson => $composableBuilder(
      column: $table.scoresJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$HrvReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $HrvReadingsTable> {
  $$HrvReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rrIntervalsJson => $composableBuilder(
      column: $table.rrIntervalsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metricsJson => $composableBuilder(
      column: $table.metricsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scoresJson => $composableBuilder(
      column: $table.scoresJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$HrvReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HrvReadingsTable> {
  $$HrvReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);

  GeneratedColumn<String> get rrIntervalsJson => $composableBuilder(
      column: $table.rrIntervalsJson, builder: (column) => column);

  GeneratedColumn<String> get metricsJson => $composableBuilder(
      column: $table.metricsJson, builder: (column) => column);

  GeneratedColumn<String> get scoresJson => $composableBuilder(
      column: $table.scoresJson, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$HrvReadingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HrvReadingsTable,
    HrvReading,
    $$HrvReadingsTableFilterComposer,
    $$HrvReadingsTableOrderingComposer,
    $$HrvReadingsTableAnnotationComposer,
    $$HrvReadingsTableCreateCompanionBuilder,
    $$HrvReadingsTableUpdateCompanionBuilder,
    (HrvReading, BaseReferences<_$AppDatabase, $HrvReadingsTable, HrvReading>),
    HrvReading,
    PrefetchHooks Function()> {
  $$HrvReadingsTableTableManager(_$AppDatabase db, $HrvReadingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HrvReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HrvReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HrvReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<int> durationSeconds = const Value.absent(),
            Value<String> rrIntervalsJson = const Value.absent(),
            Value<String> metricsJson = const Value.absent(),
            Value<String> scoresJson = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> tagsJson = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HrvReadingsCompanion(
            id: id,
            timestamp: timestamp,
            durationSeconds: durationSeconds,
            rrIntervalsJson: rrIntervalsJson,
            metricsJson: metricsJson,
            scoresJson: scoresJson,
            notes: notes,
            tagsJson: tagsJson,
            isSynced: isSynced,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime timestamp,
            required int durationSeconds,
            required String rrIntervalsJson,
            required String metricsJson,
            required String scoresJson,
            Value<String?> notes = const Value.absent(),
            Value<String?> tagsJson = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HrvReadingsCompanion.insert(
            id: id,
            timestamp: timestamp,
            durationSeconds: durationSeconds,
            rrIntervalsJson: rrIntervalsJson,
            metricsJson: metricsJson,
            scoresJson: scoresJson,
            notes: notes,
            tagsJson: tagsJson,
            isSynced: isSynced,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HrvReadingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HrvReadingsTable,
    HrvReading,
    $$HrvReadingsTableFilterComposer,
    $$HrvReadingsTableOrderingComposer,
    $$HrvReadingsTableAnnotationComposer,
    $$HrvReadingsTableCreateCompanionBuilder,
    $$HrvReadingsTableUpdateCompanionBuilder,
    (HrvReading, BaseReferences<_$AppDatabase, $HrvReadingsTable, HrvReading>),
    HrvReading,
    PrefetchHooks Function()>;
typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String key,
  required String value,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
    Setting,
    PrefetchHooks Function()> {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion.insert(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
    Setting,
    PrefetchHooks Function()>;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  required String entityType,
  required String entityId,
  required String action,
  required String dataJson,
  Value<DateTime> createdAt,
  Value<int> retryCount,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<String> entityType,
  Value<String> entityId,
  Value<String> action,
  Value<String> dataJson,
  Value<DateTime> createdAt,
  Value<int> retryCount,
});

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dataJson => $composableBuilder(
      column: $table.dataJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dataJson => $composableBuilder(
      column: $table.dataJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get dataJson =>
      $composableBuilder(column: $table.dataJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);
}

class $$SyncQueueTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> action = const Value.absent(),
            Value<String> dataJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            entityType: entityType,
            entityId: entityId,
            action: action,
            dataJson: dataJson,
            createdAt: createdAt,
            retryCount: retryCount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String entityType,
            required String entityId,
            required String action,
            required String dataJson,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            entityType: entityType,
            entityId: entityId,
            action: action,
            dataJson: dataJson,
            createdAt: createdAt,
            retryCount: retryCount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()>;
typedef $$DailyHealthMetricsTableTableCreateCompanionBuilder
    = DailyHealthMetricsTableCompanion Function({
  required String id,
  required DateTime date,
  Value<int> stepCount,
  Value<double> distanceKm,
  Value<int> activeMinutes,
  Value<int> flightsClimbed,
  Value<String?> sleepDataJson,
  Value<String> workoutsJson,
  Value<String?> menstrualDataJson,
  Value<int?> energyLevel,
  Value<int?> stressLevel,
  Value<String> symptomsJson,
  Value<String> notes,
  Value<bool> isComplete,
  Value<String> dataSourcesJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$DailyHealthMetricsTableTableUpdateCompanionBuilder
    = DailyHealthMetricsTableCompanion Function({
  Value<String> id,
  Value<DateTime> date,
  Value<int> stepCount,
  Value<double> distanceKm,
  Value<int> activeMinutes,
  Value<int> flightsClimbed,
  Value<String?> sleepDataJson,
  Value<String> workoutsJson,
  Value<String?> menstrualDataJson,
  Value<int?> energyLevel,
  Value<int?> stressLevel,
  Value<String> symptomsJson,
  Value<String> notes,
  Value<bool> isComplete,
  Value<String> dataSourcesJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$DailyHealthMetricsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DailyHealthMetricsTableTable> {
  $$DailyHealthMetricsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stepCount => $composableBuilder(
      column: $table.stepCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get distanceKm => $composableBuilder(
      column: $table.distanceKm, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get activeMinutes => $composableBuilder(
      column: $table.activeMinutes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get flightsClimbed => $composableBuilder(
      column: $table.flightsClimbed,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sleepDataJson => $composableBuilder(
      column: $table.sleepDataJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workoutsJson => $composableBuilder(
      column: $table.workoutsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get menstrualDataJson => $composableBuilder(
      column: $table.menstrualDataJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get energyLevel => $composableBuilder(
      column: $table.energyLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stressLevel => $composableBuilder(
      column: $table.stressLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get symptomsJson => $composableBuilder(
      column: $table.symptomsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isComplete => $composableBuilder(
      column: $table.isComplete, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dataSourcesJson => $composableBuilder(
      column: $table.dataSourcesJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$DailyHealthMetricsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyHealthMetricsTableTable> {
  $$DailyHealthMetricsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stepCount => $composableBuilder(
      column: $table.stepCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get distanceKm => $composableBuilder(
      column: $table.distanceKm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get activeMinutes => $composableBuilder(
      column: $table.activeMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get flightsClimbed => $composableBuilder(
      column: $table.flightsClimbed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sleepDataJson => $composableBuilder(
      column: $table.sleepDataJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workoutsJson => $composableBuilder(
      column: $table.workoutsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get menstrualDataJson => $composableBuilder(
      column: $table.menstrualDataJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get energyLevel => $composableBuilder(
      column: $table.energyLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stressLevel => $composableBuilder(
      column: $table.stressLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get symptomsJson => $composableBuilder(
      column: $table.symptomsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isComplete => $composableBuilder(
      column: $table.isComplete, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dataSourcesJson => $composableBuilder(
      column: $table.dataSourcesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$DailyHealthMetricsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyHealthMetricsTableTable> {
  $$DailyHealthMetricsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get stepCount =>
      $composableBuilder(column: $table.stepCount, builder: (column) => column);

  GeneratedColumn<double> get distanceKm => $composableBuilder(
      column: $table.distanceKm, builder: (column) => column);

  GeneratedColumn<int> get activeMinutes => $composableBuilder(
      column: $table.activeMinutes, builder: (column) => column);

  GeneratedColumn<int> get flightsClimbed => $composableBuilder(
      column: $table.flightsClimbed, builder: (column) => column);

  GeneratedColumn<String> get sleepDataJson => $composableBuilder(
      column: $table.sleepDataJson, builder: (column) => column);

  GeneratedColumn<String> get workoutsJson => $composableBuilder(
      column: $table.workoutsJson, builder: (column) => column);

  GeneratedColumn<String> get menstrualDataJson => $composableBuilder(
      column: $table.menstrualDataJson, builder: (column) => column);

  GeneratedColumn<int> get energyLevel => $composableBuilder(
      column: $table.energyLevel, builder: (column) => column);

  GeneratedColumn<int> get stressLevel => $composableBuilder(
      column: $table.stressLevel, builder: (column) => column);

  GeneratedColumn<String> get symptomsJson => $composableBuilder(
      column: $table.symptomsJson, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isComplete => $composableBuilder(
      column: $table.isComplete, builder: (column) => column);

  GeneratedColumn<String> get dataSourcesJson => $composableBuilder(
      column: $table.dataSourcesJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$DailyHealthMetricsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyHealthMetricsTableTable,
    DailyHealthMetricsTableData,
    $$DailyHealthMetricsTableTableFilterComposer,
    $$DailyHealthMetricsTableTableOrderingComposer,
    $$DailyHealthMetricsTableTableAnnotationComposer,
    $$DailyHealthMetricsTableTableCreateCompanionBuilder,
    $$DailyHealthMetricsTableTableUpdateCompanionBuilder,
    (
      DailyHealthMetricsTableData,
      BaseReferences<_$AppDatabase, $DailyHealthMetricsTableTable,
          DailyHealthMetricsTableData>
    ),
    DailyHealthMetricsTableData,
    PrefetchHooks Function()> {
  $$DailyHealthMetricsTableTableTableManager(
      _$AppDatabase db, $DailyHealthMetricsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyHealthMetricsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyHealthMetricsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyHealthMetricsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> stepCount = const Value.absent(),
            Value<double> distanceKm = const Value.absent(),
            Value<int> activeMinutes = const Value.absent(),
            Value<int> flightsClimbed = const Value.absent(),
            Value<String?> sleepDataJson = const Value.absent(),
            Value<String> workoutsJson = const Value.absent(),
            Value<String?> menstrualDataJson = const Value.absent(),
            Value<int?> energyLevel = const Value.absent(),
            Value<int?> stressLevel = const Value.absent(),
            Value<String> symptomsJson = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<bool> isComplete = const Value.absent(),
            Value<String> dataSourcesJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyHealthMetricsTableCompanion(
            id: id,
            date: date,
            stepCount: stepCount,
            distanceKm: distanceKm,
            activeMinutes: activeMinutes,
            flightsClimbed: flightsClimbed,
            sleepDataJson: sleepDataJson,
            workoutsJson: workoutsJson,
            menstrualDataJson: menstrualDataJson,
            energyLevel: energyLevel,
            stressLevel: stressLevel,
            symptomsJson: symptomsJson,
            notes: notes,
            isComplete: isComplete,
            dataSourcesJson: dataSourcesJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime date,
            Value<int> stepCount = const Value.absent(),
            Value<double> distanceKm = const Value.absent(),
            Value<int> activeMinutes = const Value.absent(),
            Value<int> flightsClimbed = const Value.absent(),
            Value<String?> sleepDataJson = const Value.absent(),
            Value<String> workoutsJson = const Value.absent(),
            Value<String?> menstrualDataJson = const Value.absent(),
            Value<int?> energyLevel = const Value.absent(),
            Value<int?> stressLevel = const Value.absent(),
            Value<String> symptomsJson = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<bool> isComplete = const Value.absent(),
            Value<String> dataSourcesJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyHealthMetricsTableCompanion.insert(
            id: id,
            date: date,
            stepCount: stepCount,
            distanceKm: distanceKm,
            activeMinutes: activeMinutes,
            flightsClimbed: flightsClimbed,
            sleepDataJson: sleepDataJson,
            workoutsJson: workoutsJson,
            menstrualDataJson: menstrualDataJson,
            energyLevel: energyLevel,
            stressLevel: stressLevel,
            symptomsJson: symptomsJson,
            notes: notes,
            isComplete: isComplete,
            dataSourcesJson: dataSourcesJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DailyHealthMetricsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $DailyHealthMetricsTableTable,
        DailyHealthMetricsTableData,
        $$DailyHealthMetricsTableTableFilterComposer,
        $$DailyHealthMetricsTableTableOrderingComposer,
        $$DailyHealthMetricsTableTableAnnotationComposer,
        $$DailyHealthMetricsTableTableCreateCompanionBuilder,
        $$DailyHealthMetricsTableTableUpdateCompanionBuilder,
        (
          DailyHealthMetricsTableData,
          BaseReferences<_$AppDatabase, $DailyHealthMetricsTableTable,
              DailyHealthMetricsTableData>
        ),
        DailyHealthMetricsTableData,
        PrefetchHooks Function()>;
typedef $$AdaptivePacingAssessmentsTableTableCreateCompanionBuilder
    = AdaptivePacingAssessmentsTableCompanion Function({
  required String id,
  required DateTime date,
  required String currentStateJson,
  required String pemRisk,
  required int energyEnvelopePercentage,
  required String hrvContributionJson,
  required String activityContributionJson,
  required String sleepContributionJson,
  Value<String?> menstrualContributionJson,
  required String recommendationsJson,
  required String activityGuidanceJson,
  Value<String> trendWarningsJson,
  Value<int> consecutiveHighRiskDays,
  Value<double> sevenDayEnergyTrend,
  required String conditionProfileJson,
  Value<double> personalSensitivity,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$AdaptivePacingAssessmentsTableTableUpdateCompanionBuilder
    = AdaptivePacingAssessmentsTableCompanion Function({
  Value<String> id,
  Value<DateTime> date,
  Value<String> currentStateJson,
  Value<String> pemRisk,
  Value<int> energyEnvelopePercentage,
  Value<String> hrvContributionJson,
  Value<String> activityContributionJson,
  Value<String> sleepContributionJson,
  Value<String?> menstrualContributionJson,
  Value<String> recommendationsJson,
  Value<String> activityGuidanceJson,
  Value<String> trendWarningsJson,
  Value<int> consecutiveHighRiskDays,
  Value<double> sevenDayEnergyTrend,
  Value<String> conditionProfileJson,
  Value<double> personalSensitivity,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$AdaptivePacingAssessmentsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AdaptivePacingAssessmentsTableTable> {
  $$AdaptivePacingAssessmentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentStateJson => $composableBuilder(
      column: $table.currentStateJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pemRisk => $composableBuilder(
      column: $table.pemRisk, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get energyEnvelopePercentage => $composableBuilder(
      column: $table.energyEnvelopePercentage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hrvContributionJson => $composableBuilder(
      column: $table.hrvContributionJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get activityContributionJson => $composableBuilder(
      column: $table.activityContributionJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sleepContributionJson => $composableBuilder(
      column: $table.sleepContributionJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get menstrualContributionJson => $composableBuilder(
      column: $table.menstrualContributionJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recommendationsJson => $composableBuilder(
      column: $table.recommendationsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get activityGuidanceJson => $composableBuilder(
      column: $table.activityGuidanceJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get trendWarningsJson => $composableBuilder(
      column: $table.trendWarningsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get consecutiveHighRiskDays => $composableBuilder(
      column: $table.consecutiveHighRiskDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sevenDayEnergyTrend => $composableBuilder(
      column: $table.sevenDayEnergyTrend,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get conditionProfileJson => $composableBuilder(
      column: $table.conditionProfileJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get personalSensitivity => $composableBuilder(
      column: $table.personalSensitivity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$AdaptivePacingAssessmentsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AdaptivePacingAssessmentsTableTable> {
  $$AdaptivePacingAssessmentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentStateJson => $composableBuilder(
      column: $table.currentStateJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pemRisk => $composableBuilder(
      column: $table.pemRisk, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get energyEnvelopePercentage => $composableBuilder(
      column: $table.energyEnvelopePercentage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hrvContributionJson => $composableBuilder(
      column: $table.hrvContributionJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get activityContributionJson => $composableBuilder(
      column: $table.activityContributionJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sleepContributionJson => $composableBuilder(
      column: $table.sleepContributionJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get menstrualContributionJson => $composableBuilder(
      column: $table.menstrualContributionJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recommendationsJson => $composableBuilder(
      column: $table.recommendationsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get activityGuidanceJson => $composableBuilder(
      column: $table.activityGuidanceJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get trendWarningsJson => $composableBuilder(
      column: $table.trendWarningsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get consecutiveHighRiskDays => $composableBuilder(
      column: $table.consecutiveHighRiskDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sevenDayEnergyTrend => $composableBuilder(
      column: $table.sevenDayEnergyTrend,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get conditionProfileJson => $composableBuilder(
      column: $table.conditionProfileJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get personalSensitivity => $composableBuilder(
      column: $table.personalSensitivity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$AdaptivePacingAssessmentsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AdaptivePacingAssessmentsTableTable> {
  $$AdaptivePacingAssessmentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get currentStateJson => $composableBuilder(
      column: $table.currentStateJson, builder: (column) => column);

  GeneratedColumn<String> get pemRisk =>
      $composableBuilder(column: $table.pemRisk, builder: (column) => column);

  GeneratedColumn<int> get energyEnvelopePercentage => $composableBuilder(
      column: $table.energyEnvelopePercentage, builder: (column) => column);

  GeneratedColumn<String> get hrvContributionJson => $composableBuilder(
      column: $table.hrvContributionJson, builder: (column) => column);

  GeneratedColumn<String> get activityContributionJson => $composableBuilder(
      column: $table.activityContributionJson, builder: (column) => column);

  GeneratedColumn<String> get sleepContributionJson => $composableBuilder(
      column: $table.sleepContributionJson, builder: (column) => column);

  GeneratedColumn<String> get menstrualContributionJson => $composableBuilder(
      column: $table.menstrualContributionJson, builder: (column) => column);

  GeneratedColumn<String> get recommendationsJson => $composableBuilder(
      column: $table.recommendationsJson, builder: (column) => column);

  GeneratedColumn<String> get activityGuidanceJson => $composableBuilder(
      column: $table.activityGuidanceJson, builder: (column) => column);

  GeneratedColumn<String> get trendWarningsJson => $composableBuilder(
      column: $table.trendWarningsJson, builder: (column) => column);

  GeneratedColumn<int> get consecutiveHighRiskDays => $composableBuilder(
      column: $table.consecutiveHighRiskDays, builder: (column) => column);

  GeneratedColumn<double> get sevenDayEnergyTrend => $composableBuilder(
      column: $table.sevenDayEnergyTrend, builder: (column) => column);

  GeneratedColumn<String> get conditionProfileJson => $composableBuilder(
      column: $table.conditionProfileJson, builder: (column) => column);

  GeneratedColumn<double> get personalSensitivity => $composableBuilder(
      column: $table.personalSensitivity, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$AdaptivePacingAssessmentsTableTableTableManager
    extends RootTableManager<
        _$AppDatabase,
        $AdaptivePacingAssessmentsTableTable,
        AdaptivePacingAssessmentsTableData,
        $$AdaptivePacingAssessmentsTableTableFilterComposer,
        $$AdaptivePacingAssessmentsTableTableOrderingComposer,
        $$AdaptivePacingAssessmentsTableTableAnnotationComposer,
        $$AdaptivePacingAssessmentsTableTableCreateCompanionBuilder,
        $$AdaptivePacingAssessmentsTableTableUpdateCompanionBuilder,
        (
          AdaptivePacingAssessmentsTableData,
          BaseReferences<_$AppDatabase, $AdaptivePacingAssessmentsTableTable,
              AdaptivePacingAssessmentsTableData>
        ),
        AdaptivePacingAssessmentsTableData,
        PrefetchHooks Function()> {
  $$AdaptivePacingAssessmentsTableTableTableManager(
      _$AppDatabase db, $AdaptivePacingAssessmentsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AdaptivePacingAssessmentsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$AdaptivePacingAssessmentsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AdaptivePacingAssessmentsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> currentStateJson = const Value.absent(),
            Value<String> pemRisk = const Value.absent(),
            Value<int> energyEnvelopePercentage = const Value.absent(),
            Value<String> hrvContributionJson = const Value.absent(),
            Value<String> activityContributionJson = const Value.absent(),
            Value<String> sleepContributionJson = const Value.absent(),
            Value<String?> menstrualContributionJson = const Value.absent(),
            Value<String> recommendationsJson = const Value.absent(),
            Value<String> activityGuidanceJson = const Value.absent(),
            Value<String> trendWarningsJson = const Value.absent(),
            Value<int> consecutiveHighRiskDays = const Value.absent(),
            Value<double> sevenDayEnergyTrend = const Value.absent(),
            Value<String> conditionProfileJson = const Value.absent(),
            Value<double> personalSensitivity = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AdaptivePacingAssessmentsTableCompanion(
            id: id,
            date: date,
            currentStateJson: currentStateJson,
            pemRisk: pemRisk,
            energyEnvelopePercentage: energyEnvelopePercentage,
            hrvContributionJson: hrvContributionJson,
            activityContributionJson: activityContributionJson,
            sleepContributionJson: sleepContributionJson,
            menstrualContributionJson: menstrualContributionJson,
            recommendationsJson: recommendationsJson,
            activityGuidanceJson: activityGuidanceJson,
            trendWarningsJson: trendWarningsJson,
            consecutiveHighRiskDays: consecutiveHighRiskDays,
            sevenDayEnergyTrend: sevenDayEnergyTrend,
            conditionProfileJson: conditionProfileJson,
            personalSensitivity: personalSensitivity,
            createdAt: createdAt,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime date,
            required String currentStateJson,
            required String pemRisk,
            required int energyEnvelopePercentage,
            required String hrvContributionJson,
            required String activityContributionJson,
            required String sleepContributionJson,
            Value<String?> menstrualContributionJson = const Value.absent(),
            required String recommendationsJson,
            required String activityGuidanceJson,
            Value<String> trendWarningsJson = const Value.absent(),
            Value<int> consecutiveHighRiskDays = const Value.absent(),
            Value<double> sevenDayEnergyTrend = const Value.absent(),
            required String conditionProfileJson,
            Value<double> personalSensitivity = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AdaptivePacingAssessmentsTableCompanion.insert(
            id: id,
            date: date,
            currentStateJson: currentStateJson,
            pemRisk: pemRisk,
            energyEnvelopePercentage: energyEnvelopePercentage,
            hrvContributionJson: hrvContributionJson,
            activityContributionJson: activityContributionJson,
            sleepContributionJson: sleepContributionJson,
            menstrualContributionJson: menstrualContributionJson,
            recommendationsJson: recommendationsJson,
            activityGuidanceJson: activityGuidanceJson,
            trendWarningsJson: trendWarningsJson,
            consecutiveHighRiskDays: consecutiveHighRiskDays,
            sevenDayEnergyTrend: sevenDayEnergyTrend,
            conditionProfileJson: conditionProfileJson,
            personalSensitivity: personalSensitivity,
            createdAt: createdAt,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AdaptivePacingAssessmentsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $AdaptivePacingAssessmentsTableTable,
        AdaptivePacingAssessmentsTableData,
        $$AdaptivePacingAssessmentsTableTableFilterComposer,
        $$AdaptivePacingAssessmentsTableTableOrderingComposer,
        $$AdaptivePacingAssessmentsTableTableAnnotationComposer,
        $$AdaptivePacingAssessmentsTableTableCreateCompanionBuilder,
        $$AdaptivePacingAssessmentsTableTableUpdateCompanionBuilder,
        (
          AdaptivePacingAssessmentsTableData,
          BaseReferences<_$AppDatabase, $AdaptivePacingAssessmentsTableTable,
              AdaptivePacingAssessmentsTableData>
        ),
        AdaptivePacingAssessmentsTableData,
        PrefetchHooks Function()>;
typedef $$WorkoutSessionsTableTableCreateCompanionBuilder
    = WorkoutSessionsTableCompanion Function({
  required String id,
  required DateTime startTime,
  required DateTime endTime,
  required String workoutType,
  required int durationMinutes,
  Value<int?> perceivedExertion,
  Value<double?> averageHeartRate,
  Value<double?> maxHeartRate,
  Value<int?> caloriesBurned,
  Value<double?> distanceKm,
  Value<int?> steps,
  Value<double?> avgSpeed,
  Value<double?> elevationGain,
  Value<int?> recoveryHeartRate,
  Value<int?> recoveryTimeMinutes,
  Value<String> notes,
  Value<String> source,
  Value<String?> dailyMetricsId,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$WorkoutSessionsTableTableUpdateCompanionBuilder
    = WorkoutSessionsTableCompanion Function({
  Value<String> id,
  Value<DateTime> startTime,
  Value<DateTime> endTime,
  Value<String> workoutType,
  Value<int> durationMinutes,
  Value<int?> perceivedExertion,
  Value<double?> averageHeartRate,
  Value<double?> maxHeartRate,
  Value<int?> caloriesBurned,
  Value<double?> distanceKm,
  Value<int?> steps,
  Value<double?> avgSpeed,
  Value<double?> elevationGain,
  Value<int?> recoveryHeartRate,
  Value<int?> recoveryTimeMinutes,
  Value<String> notes,
  Value<String> source,
  Value<String?> dailyMetricsId,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$WorkoutSessionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTableTable> {
  $$WorkoutSessionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workoutType => $composableBuilder(
      column: $table.workoutType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get perceivedExertion => $composableBuilder(
      column: $table.perceivedExertion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get averageHeartRate => $composableBuilder(
      column: $table.averageHeartRate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get maxHeartRate => $composableBuilder(
      column: $table.maxHeartRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get distanceKm => $composableBuilder(
      column: $table.distanceKm, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get avgSpeed => $composableBuilder(
      column: $table.avgSpeed, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get elevationGain => $composableBuilder(
      column: $table.elevationGain, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get recoveryHeartRate => $composableBuilder(
      column: $table.recoveryHeartRate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get recoveryTimeMinutes => $composableBuilder(
      column: $table.recoveryTimeMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dailyMetricsId => $composableBuilder(
      column: $table.dailyMetricsId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$WorkoutSessionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTableTable> {
  $$WorkoutSessionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workoutType => $composableBuilder(
      column: $table.workoutType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get perceivedExertion => $composableBuilder(
      column: $table.perceivedExertion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get averageHeartRate => $composableBuilder(
      column: $table.averageHeartRate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get maxHeartRate => $composableBuilder(
      column: $table.maxHeartRate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get distanceKm => $composableBuilder(
      column: $table.distanceKm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get avgSpeed => $composableBuilder(
      column: $table.avgSpeed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get elevationGain => $composableBuilder(
      column: $table.elevationGain,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get recoveryHeartRate => $composableBuilder(
      column: $table.recoveryHeartRate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get recoveryTimeMinutes => $composableBuilder(
      column: $table.recoveryTimeMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dailyMetricsId => $composableBuilder(
      column: $table.dailyMetricsId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$WorkoutSessionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTableTable> {
  $$WorkoutSessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get workoutType => $composableBuilder(
      column: $table.workoutType, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<int> get perceivedExertion => $composableBuilder(
      column: $table.perceivedExertion, builder: (column) => column);

  GeneratedColumn<double> get averageHeartRate => $composableBuilder(
      column: $table.averageHeartRate, builder: (column) => column);

  GeneratedColumn<double> get maxHeartRate => $composableBuilder(
      column: $table.maxHeartRate, builder: (column) => column);

  GeneratedColumn<int> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned, builder: (column) => column);

  GeneratedColumn<double> get distanceKm => $composableBuilder(
      column: $table.distanceKm, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<double> get avgSpeed =>
      $composableBuilder(column: $table.avgSpeed, builder: (column) => column);

  GeneratedColumn<double> get elevationGain => $composableBuilder(
      column: $table.elevationGain, builder: (column) => column);

  GeneratedColumn<int> get recoveryHeartRate => $composableBuilder(
      column: $table.recoveryHeartRate, builder: (column) => column);

  GeneratedColumn<int> get recoveryTimeMinutes => $composableBuilder(
      column: $table.recoveryTimeMinutes, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get dailyMetricsId => $composableBuilder(
      column: $table.dailyMetricsId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$WorkoutSessionsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutSessionsTableTable,
    WorkoutSessionsTableData,
    $$WorkoutSessionsTableTableFilterComposer,
    $$WorkoutSessionsTableTableOrderingComposer,
    $$WorkoutSessionsTableTableAnnotationComposer,
    $$WorkoutSessionsTableTableCreateCompanionBuilder,
    $$WorkoutSessionsTableTableUpdateCompanionBuilder,
    (
      WorkoutSessionsTableData,
      BaseReferences<_$AppDatabase, $WorkoutSessionsTableTable,
          WorkoutSessionsTableData>
    ),
    WorkoutSessionsTableData,
    PrefetchHooks Function()> {
  $$WorkoutSessionsTableTableTableManager(
      _$AppDatabase db, $WorkoutSessionsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSessionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSessionsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSessionsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime> endTime = const Value.absent(),
            Value<String> workoutType = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<int?> perceivedExertion = const Value.absent(),
            Value<double?> averageHeartRate = const Value.absent(),
            Value<double?> maxHeartRate = const Value.absent(),
            Value<int?> caloriesBurned = const Value.absent(),
            Value<double?> distanceKm = const Value.absent(),
            Value<int?> steps = const Value.absent(),
            Value<double?> avgSpeed = const Value.absent(),
            Value<double?> elevationGain = const Value.absent(),
            Value<int?> recoveryHeartRate = const Value.absent(),
            Value<int?> recoveryTimeMinutes = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> dailyMetricsId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutSessionsTableCompanion(
            id: id,
            startTime: startTime,
            endTime: endTime,
            workoutType: workoutType,
            durationMinutes: durationMinutes,
            perceivedExertion: perceivedExertion,
            averageHeartRate: averageHeartRate,
            maxHeartRate: maxHeartRate,
            caloriesBurned: caloriesBurned,
            distanceKm: distanceKm,
            steps: steps,
            avgSpeed: avgSpeed,
            elevationGain: elevationGain,
            recoveryHeartRate: recoveryHeartRate,
            recoveryTimeMinutes: recoveryTimeMinutes,
            notes: notes,
            source: source,
            dailyMetricsId: dailyMetricsId,
            createdAt: createdAt,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime startTime,
            required DateTime endTime,
            required String workoutType,
            required int durationMinutes,
            Value<int?> perceivedExertion = const Value.absent(),
            Value<double?> averageHeartRate = const Value.absent(),
            Value<double?> maxHeartRate = const Value.absent(),
            Value<int?> caloriesBurned = const Value.absent(),
            Value<double?> distanceKm = const Value.absent(),
            Value<int?> steps = const Value.absent(),
            Value<double?> avgSpeed = const Value.absent(),
            Value<double?> elevationGain = const Value.absent(),
            Value<int?> recoveryHeartRate = const Value.absent(),
            Value<int?> recoveryTimeMinutes = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> dailyMetricsId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutSessionsTableCompanion.insert(
            id: id,
            startTime: startTime,
            endTime: endTime,
            workoutType: workoutType,
            durationMinutes: durationMinutes,
            perceivedExertion: perceivedExertion,
            averageHeartRate: averageHeartRate,
            maxHeartRate: maxHeartRate,
            caloriesBurned: caloriesBurned,
            distanceKm: distanceKm,
            steps: steps,
            avgSpeed: avgSpeed,
            elevationGain: elevationGain,
            recoveryHeartRate: recoveryHeartRate,
            recoveryTimeMinutes: recoveryTimeMinutes,
            notes: notes,
            source: source,
            dailyMetricsId: dailyMetricsId,
            createdAt: createdAt,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkoutSessionsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $WorkoutSessionsTableTable,
        WorkoutSessionsTableData,
        $$WorkoutSessionsTableTableFilterComposer,
        $$WorkoutSessionsTableTableOrderingComposer,
        $$WorkoutSessionsTableTableAnnotationComposer,
        $$WorkoutSessionsTableTableCreateCompanionBuilder,
        $$WorkoutSessionsTableTableUpdateCompanionBuilder,
        (
          WorkoutSessionsTableData,
          BaseReferences<_$AppDatabase, $WorkoutSessionsTableTable,
              WorkoutSessionsTableData>
        ),
        WorkoutSessionsTableData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HrvReadingsTableTableManager get hrvReadings =>
      $$HrvReadingsTableTableManager(_db, _db.hrvReadings);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$DailyHealthMetricsTableTableTableManager get dailyHealthMetricsTable =>
      $$DailyHealthMetricsTableTableTableManager(
          _db, _db.dailyHealthMetricsTable);
  $$AdaptivePacingAssessmentsTableTableTableManager
      get adaptivePacingAssessmentsTable =>
          $$AdaptivePacingAssessmentsTableTableTableManager(
              _db, _db.adaptivePacingAssessmentsTable);
  $$WorkoutSessionsTableTableTableManager get workoutSessionsTable =>
      $$WorkoutSessionsTableTableTableManager(_db, _db.workoutSessionsTable);
}
