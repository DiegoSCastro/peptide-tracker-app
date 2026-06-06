// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CompoundsTableTable extends CompoundsTable
    with TableInfo<$CompoundsTableTable, CompoundsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompoundsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultUnitMeta = const VerificationMeta(
    'defaultUnit',
  );
  @override
  late final GeneratedColumn<String> defaultUnit = GeneratedColumn<String>(
    'default_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    defaultUnit,
    notes,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'compounds_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompoundsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('default_unit')) {
      context.handle(
        _defaultUnitMeta,
        defaultUnit.isAcceptableOrUnknown(
          data['default_unit']!,
          _defaultUnitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_defaultUnitMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompoundsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompoundsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      defaultUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_unit'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CompoundsTableTable createAlias(String alias) {
    return $CompoundsTableTable(attachedDatabase, alias);
  }
}

class CompoundsTableData extends DataClass
    implements Insertable<CompoundsTableData> {
  final String id;
  final String name;
  final String category;
  final String defaultUnit;
  final String? notes;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CompoundsTableData({
    required this.id,
    required this.name,
    required this.category,
    required this.defaultUnit,
    this.notes,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['default_unit'] = Variable<String>(defaultUnit);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CompoundsTableCompanion toCompanion(bool nullToAbsent) {
    return CompoundsTableCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      defaultUnit: Value(defaultUnit),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CompoundsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompoundsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      defaultUnit: serializer.fromJson<String>(json['defaultUnit']),
      notes: serializer.fromJson<String?>(json['notes']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'defaultUnit': serializer.toJson<String>(defaultUnit),
      'notes': serializer.toJson<String?>(notes),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CompoundsTableData copyWith({
    String? id,
    String? name,
    String? category,
    String? defaultUnit,
    Value<String?> notes = const Value.absent(),
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CompoundsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    defaultUnit: defaultUnit ?? this.defaultUnit,
    notes: notes.present ? notes.value : this.notes,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CompoundsTableData copyWithCompanion(CompoundsTableCompanion data) {
    return CompoundsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      defaultUnit: data.defaultUnit.present
          ? data.defaultUnit.value
          : this.defaultUnit,
      notes: data.notes.present ? data.notes.value : this.notes,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompoundsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('defaultUnit: $defaultUnit, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category,
    defaultUnit,
    notes,
    isArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompoundsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.defaultUnit == this.defaultUnit &&
          other.notes == this.notes &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CompoundsTableCompanion extends UpdateCompanion<CompoundsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> defaultUnit;
  final Value<String?> notes;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CompoundsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.defaultUnit = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompoundsTableCompanion.insert({
    required String id,
    required String name,
    required String category,
    required String defaultUnit,
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       category = Value(category),
       defaultUnit = Value(defaultUnit),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CompoundsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? defaultUnit,
    Expression<String>? notes,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (defaultUnit != null) 'default_unit': defaultUnit,
      if (notes != null) 'notes': notes,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompoundsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? category,
    Value<String>? defaultUnit,
    Value<String?>? notes,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CompoundsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      defaultUnit: defaultUnit ?? this.defaultUnit,
      notes: notes ?? this.notes,
      isArchived: isArchived ?? this.isArchived,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (defaultUnit.present) {
      map['default_unit'] = Variable<String>(defaultUnit.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
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
    return (StringBuffer('CompoundsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('defaultUnit: $defaultUnit, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProtocolsTableTable extends ProtocolsTable
    with TableInfo<$ProtocolsTableTable, ProtocolsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProtocolsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _compoundIdMeta = const VerificationMeta(
    'compoundId',
  );
  @override
  late final GeneratedColumn<String> compoundId = GeneratedColumn<String>(
    'compound_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES compounds_table (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedAmountMeta = const VerificationMeta(
    'plannedAmount',
  );
  @override
  late final GeneratedColumn<double> plannedAmount = GeneratedColumn<double>(
    'planned_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitLabelMeta = const VerificationMeta(
    'unitLabel',
  );
  @override
  late final GeneratedColumn<String> unitLabel = GeneratedColumn<String>(
    'unit_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduleTypeMeta = const VerificationMeta(
    'scheduleType',
  );
  @override
  late final GeneratedColumn<String> scheduleType = GeneratedColumn<String>(
    'schedule_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderMinutesAfterMidnightMeta =
      const VerificationMeta('reminderMinutesAfterMidnight');
  @override
  late final GeneratedColumn<int> reminderMinutesAfterMidnight =
      GeneratedColumn<int>(
        'reminder_minutes_after_midnight',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    compoundId,
    name,
    plannedAmount,
    unitLabel,
    scheduleType,
    intervalDays,
    reminderMinutesAfterMidnight,
    startDate,
    isActive,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'protocols_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProtocolsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('compound_id')) {
      context.handle(
        _compoundIdMeta,
        compoundId.isAcceptableOrUnknown(data['compound_id']!, _compoundIdMeta),
      );
    } else if (isInserting) {
      context.missing(_compoundIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('planned_amount')) {
      context.handle(
        _plannedAmountMeta,
        plannedAmount.isAcceptableOrUnknown(
          data['planned_amount']!,
          _plannedAmountMeta,
        ),
      );
    }
    if (data.containsKey('unit_label')) {
      context.handle(
        _unitLabelMeta,
        unitLabel.isAcceptableOrUnknown(data['unit_label']!, _unitLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_unitLabelMeta);
    }
    if (data.containsKey('schedule_type')) {
      context.handle(
        _scheduleTypeMeta,
        scheduleType.isAcceptableOrUnknown(
          data['schedule_type']!,
          _scheduleTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduleTypeMeta);
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('reminder_minutes_after_midnight')) {
      context.handle(
        _reminderMinutesAfterMidnightMeta,
        reminderMinutesAfterMidnight.isAcceptableOrUnknown(
          data['reminder_minutes_after_midnight']!,
          _reminderMinutesAfterMidnightMeta,
        ),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProtocolsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProtocolsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      compoundId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}compound_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      plannedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}planned_amount'],
      ),
      unitLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_label'],
      )!,
      scheduleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schedule_type'],
      )!,
      intervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_days'],
      ),
      reminderMinutesAfterMidnight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_minutes_after_midnight'],
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProtocolsTableTable createAlias(String alias) {
    return $ProtocolsTableTable(attachedDatabase, alias);
  }
}

class ProtocolsTableData extends DataClass
    implements Insertable<ProtocolsTableData> {
  final String id;
  final String compoundId;
  final String name;
  final double? plannedAmount;
  final String unitLabel;
  final String scheduleType;
  final int? intervalDays;
  final int? reminderMinutesAfterMidnight;
  final DateTime startDate;
  final bool isActive;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ProtocolsTableData({
    required this.id,
    required this.compoundId,
    required this.name,
    this.plannedAmount,
    required this.unitLabel,
    required this.scheduleType,
    this.intervalDays,
    this.reminderMinutesAfterMidnight,
    required this.startDate,
    required this.isActive,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['compound_id'] = Variable<String>(compoundId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || plannedAmount != null) {
      map['planned_amount'] = Variable<double>(plannedAmount);
    }
    map['unit_label'] = Variable<String>(unitLabel);
    map['schedule_type'] = Variable<String>(scheduleType);
    if (!nullToAbsent || intervalDays != null) {
      map['interval_days'] = Variable<int>(intervalDays);
    }
    if (!nullToAbsent || reminderMinutesAfterMidnight != null) {
      map['reminder_minutes_after_midnight'] = Variable<int>(
        reminderMinutesAfterMidnight,
      );
    }
    map['start_date'] = Variable<DateTime>(startDate);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProtocolsTableCompanion toCompanion(bool nullToAbsent) {
    return ProtocolsTableCompanion(
      id: Value(id),
      compoundId: Value(compoundId),
      name: Value(name),
      plannedAmount: plannedAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedAmount),
      unitLabel: Value(unitLabel),
      scheduleType: Value(scheduleType),
      intervalDays: intervalDays == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalDays),
      reminderMinutesAfterMidnight:
          reminderMinutesAfterMidnight == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderMinutesAfterMidnight),
      startDate: Value(startDate),
      isActive: Value(isActive),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProtocolsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProtocolsTableData(
      id: serializer.fromJson<String>(json['id']),
      compoundId: serializer.fromJson<String>(json['compoundId']),
      name: serializer.fromJson<String>(json['name']),
      plannedAmount: serializer.fromJson<double?>(json['plannedAmount']),
      unitLabel: serializer.fromJson<String>(json['unitLabel']),
      scheduleType: serializer.fromJson<String>(json['scheduleType']),
      intervalDays: serializer.fromJson<int?>(json['intervalDays']),
      reminderMinutesAfterMidnight: serializer.fromJson<int?>(
        json['reminderMinutesAfterMidnight'],
      ),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'compoundId': serializer.toJson<String>(compoundId),
      'name': serializer.toJson<String>(name),
      'plannedAmount': serializer.toJson<double?>(plannedAmount),
      'unitLabel': serializer.toJson<String>(unitLabel),
      'scheduleType': serializer.toJson<String>(scheduleType),
      'intervalDays': serializer.toJson<int?>(intervalDays),
      'reminderMinutesAfterMidnight': serializer.toJson<int?>(
        reminderMinutesAfterMidnight,
      ),
      'startDate': serializer.toJson<DateTime>(startDate),
      'isActive': serializer.toJson<bool>(isActive),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProtocolsTableData copyWith({
    String? id,
    String? compoundId,
    String? name,
    Value<double?> plannedAmount = const Value.absent(),
    String? unitLabel,
    String? scheduleType,
    Value<int?> intervalDays = const Value.absent(),
    Value<int?> reminderMinutesAfterMidnight = const Value.absent(),
    DateTime? startDate,
    bool? isActive,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ProtocolsTableData(
    id: id ?? this.id,
    compoundId: compoundId ?? this.compoundId,
    name: name ?? this.name,
    plannedAmount: plannedAmount.present
        ? plannedAmount.value
        : this.plannedAmount,
    unitLabel: unitLabel ?? this.unitLabel,
    scheduleType: scheduleType ?? this.scheduleType,
    intervalDays: intervalDays.present ? intervalDays.value : this.intervalDays,
    reminderMinutesAfterMidnight: reminderMinutesAfterMidnight.present
        ? reminderMinutesAfterMidnight.value
        : this.reminderMinutesAfterMidnight,
    startDate: startDate ?? this.startDate,
    isActive: isActive ?? this.isActive,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ProtocolsTableData copyWithCompanion(ProtocolsTableCompanion data) {
    return ProtocolsTableData(
      id: data.id.present ? data.id.value : this.id,
      compoundId: data.compoundId.present
          ? data.compoundId.value
          : this.compoundId,
      name: data.name.present ? data.name.value : this.name,
      plannedAmount: data.plannedAmount.present
          ? data.plannedAmount.value
          : this.plannedAmount,
      unitLabel: data.unitLabel.present ? data.unitLabel.value : this.unitLabel,
      scheduleType: data.scheduleType.present
          ? data.scheduleType.value
          : this.scheduleType,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      reminderMinutesAfterMidnight: data.reminderMinutesAfterMidnight.present
          ? data.reminderMinutesAfterMidnight.value
          : this.reminderMinutesAfterMidnight,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProtocolsTableData(')
          ..write('id: $id, ')
          ..write('compoundId: $compoundId, ')
          ..write('name: $name, ')
          ..write('plannedAmount: $plannedAmount, ')
          ..write('unitLabel: $unitLabel, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('intervalDays: $intervalDays, ')
          ..write(
            'reminderMinutesAfterMidnight: $reminderMinutesAfterMidnight, ',
          )
          ..write('startDate: $startDate, ')
          ..write('isActive: $isActive, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    compoundId,
    name,
    plannedAmount,
    unitLabel,
    scheduleType,
    intervalDays,
    reminderMinutesAfterMidnight,
    startDate,
    isActive,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProtocolsTableData &&
          other.id == this.id &&
          other.compoundId == this.compoundId &&
          other.name == this.name &&
          other.plannedAmount == this.plannedAmount &&
          other.unitLabel == this.unitLabel &&
          other.scheduleType == this.scheduleType &&
          other.intervalDays == this.intervalDays &&
          other.reminderMinutesAfterMidnight ==
              this.reminderMinutesAfterMidnight &&
          other.startDate == this.startDate &&
          other.isActive == this.isActive &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProtocolsTableCompanion extends UpdateCompanion<ProtocolsTableData> {
  final Value<String> id;
  final Value<String> compoundId;
  final Value<String> name;
  final Value<double?> plannedAmount;
  final Value<String> unitLabel;
  final Value<String> scheduleType;
  final Value<int?> intervalDays;
  final Value<int?> reminderMinutesAfterMidnight;
  final Value<DateTime> startDate;
  final Value<bool> isActive;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProtocolsTableCompanion({
    this.id = const Value.absent(),
    this.compoundId = const Value.absent(),
    this.name = const Value.absent(),
    this.plannedAmount = const Value.absent(),
    this.unitLabel = const Value.absent(),
    this.scheduleType = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.reminderMinutesAfterMidnight = const Value.absent(),
    this.startDate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProtocolsTableCompanion.insert({
    required String id,
    required String compoundId,
    required String name,
    this.plannedAmount = const Value.absent(),
    required String unitLabel,
    required String scheduleType,
    this.intervalDays = const Value.absent(),
    this.reminderMinutesAfterMidnight = const Value.absent(),
    required DateTime startDate,
    this.isActive = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       compoundId = Value(compoundId),
       name = Value(name),
       unitLabel = Value(unitLabel),
       scheduleType = Value(scheduleType),
       startDate = Value(startDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ProtocolsTableData> custom({
    Expression<String>? id,
    Expression<String>? compoundId,
    Expression<String>? name,
    Expression<double>? plannedAmount,
    Expression<String>? unitLabel,
    Expression<String>? scheduleType,
    Expression<int>? intervalDays,
    Expression<int>? reminderMinutesAfterMidnight,
    Expression<DateTime>? startDate,
    Expression<bool>? isActive,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (compoundId != null) 'compound_id': compoundId,
      if (name != null) 'name': name,
      if (plannedAmount != null) 'planned_amount': plannedAmount,
      if (unitLabel != null) 'unit_label': unitLabel,
      if (scheduleType != null) 'schedule_type': scheduleType,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (reminderMinutesAfterMidnight != null)
        'reminder_minutes_after_midnight': reminderMinutesAfterMidnight,
      if (startDate != null) 'start_date': startDate,
      if (isActive != null) 'is_active': isActive,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProtocolsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? compoundId,
    Value<String>? name,
    Value<double?>? plannedAmount,
    Value<String>? unitLabel,
    Value<String>? scheduleType,
    Value<int?>? intervalDays,
    Value<int?>? reminderMinutesAfterMidnight,
    Value<DateTime>? startDate,
    Value<bool>? isActive,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProtocolsTableCompanion(
      id: id ?? this.id,
      compoundId: compoundId ?? this.compoundId,
      name: name ?? this.name,
      plannedAmount: plannedAmount ?? this.plannedAmount,
      unitLabel: unitLabel ?? this.unitLabel,
      scheduleType: scheduleType ?? this.scheduleType,
      intervalDays: intervalDays ?? this.intervalDays,
      reminderMinutesAfterMidnight:
          reminderMinutesAfterMidnight ?? this.reminderMinutesAfterMidnight,
      startDate: startDate ?? this.startDate,
      isActive: isActive ?? this.isActive,
      notes: notes ?? this.notes,
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
    if (compoundId.present) {
      map['compound_id'] = Variable<String>(compoundId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (plannedAmount.present) {
      map['planned_amount'] = Variable<double>(plannedAmount.value);
    }
    if (unitLabel.present) {
      map['unit_label'] = Variable<String>(unitLabel.value);
    }
    if (scheduleType.present) {
      map['schedule_type'] = Variable<String>(scheduleType.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (reminderMinutesAfterMidnight.present) {
      map['reminder_minutes_after_midnight'] = Variable<int>(
        reminderMinutesAfterMidnight.value,
      );
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('ProtocolsTableCompanion(')
          ..write('id: $id, ')
          ..write('compoundId: $compoundId, ')
          ..write('name: $name, ')
          ..write('plannedAmount: $plannedAmount, ')
          ..write('unitLabel: $unitLabel, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('intervalDays: $intervalDays, ')
          ..write(
            'reminderMinutesAfterMidnight: $reminderMinutesAfterMidnight, ',
          )
          ..write('startDate: $startDate, ')
          ..write('isActive: $isActive, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LogEntriesTableTable extends LogEntriesTable
    with TableInfo<$LogEntriesTableTable, LogEntriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogEntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _protocolIdMeta = const VerificationMeta(
    'protocolId',
  );
  @override
  late final GeneratedColumn<String> protocolId = GeneratedColumn<String>(
    'protocol_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES protocols_table (id)',
    ),
  );
  static const VerificationMeta _compoundIdMeta = const VerificationMeta(
    'compoundId',
  );
  @override
  late final GeneratedColumn<String> compoundId = GeneratedColumn<String>(
    'compound_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES compounds_table (id)',
    ),
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitLabelMeta = const VerificationMeta(
    'unitLabel',
  );
  @override
  late final GeneratedColumn<String> unitLabel = GeneratedColumn<String>(
    'unit_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdFromReminderMeta =
      const VerificationMeta('createdFromReminder');
  @override
  late final GeneratedColumn<bool> createdFromReminder = GeneratedColumn<bool>(
    'created_from_reminder',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("created_from_reminder" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _protocolNameSnapshotMeta =
      const VerificationMeta('protocolNameSnapshot');
  @override
  late final GeneratedColumn<String> protocolNameSnapshot =
      GeneratedColumn<String>(
        'protocol_name_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _compoundNameSnapshotMeta =
      const VerificationMeta('compoundNameSnapshot');
  @override
  late final GeneratedColumn<String> compoundNameSnapshot =
      GeneratedColumn<String>(
        'compound_name_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    protocolId,
    compoundId,
    loggedAt,
    status,
    amount,
    unitLabel,
    note,
    createdFromReminder,
    protocolNameSnapshot,
    compoundNameSnapshot,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'log_entries_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<LogEntriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('protocol_id')) {
      context.handle(
        _protocolIdMeta,
        protocolId.isAcceptableOrUnknown(data['protocol_id']!, _protocolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_protocolIdMeta);
    }
    if (data.containsKey('compound_id')) {
      context.handle(
        _compoundIdMeta,
        compoundId.isAcceptableOrUnknown(data['compound_id']!, _compoundIdMeta),
      );
    } else if (isInserting) {
      context.missing(_compoundIdMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('unit_label')) {
      context.handle(
        _unitLabelMeta,
        unitLabel.isAcceptableOrUnknown(data['unit_label']!, _unitLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_unitLabelMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_from_reminder')) {
      context.handle(
        _createdFromReminderMeta,
        createdFromReminder.isAcceptableOrUnknown(
          data['created_from_reminder']!,
          _createdFromReminderMeta,
        ),
      );
    }
    if (data.containsKey('protocol_name_snapshot')) {
      context.handle(
        _protocolNameSnapshotMeta,
        protocolNameSnapshot.isAcceptableOrUnknown(
          data['protocol_name_snapshot']!,
          _protocolNameSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_protocolNameSnapshotMeta);
    }
    if (data.containsKey('compound_name_snapshot')) {
      context.handle(
        _compoundNameSnapshotMeta,
        compoundNameSnapshot.isAcceptableOrUnknown(
          data['compound_name_snapshot']!,
          _compoundNameSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_compoundNameSnapshotMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogEntriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogEntriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      protocolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}protocol_id'],
      )!,
      compoundId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}compound_id'],
      )!,
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      ),
      unitLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_label'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdFromReminder: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}created_from_reminder'],
      )!,
      protocolNameSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}protocol_name_snapshot'],
      )!,
      compoundNameSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}compound_name_snapshot'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LogEntriesTableTable createAlias(String alias) {
    return $LogEntriesTableTable(attachedDatabase, alias);
  }
}

class LogEntriesTableData extends DataClass
    implements Insertable<LogEntriesTableData> {
  final String id;
  final String protocolId;
  final String compoundId;
  final DateTime loggedAt;
  final String status;
  final double? amount;
  final String unitLabel;
  final String? note;
  final bool createdFromReminder;
  final String protocolNameSnapshot;
  final String compoundNameSnapshot;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LogEntriesTableData({
    required this.id,
    required this.protocolId,
    required this.compoundId,
    required this.loggedAt,
    required this.status,
    this.amount,
    required this.unitLabel,
    this.note,
    required this.createdFromReminder,
    required this.protocolNameSnapshot,
    required this.compoundNameSnapshot,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['protocol_id'] = Variable<String>(protocolId);
    map['compound_id'] = Variable<String>(compoundId);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    map['unit_label'] = Variable<String>(unitLabel);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_from_reminder'] = Variable<bool>(createdFromReminder);
    map['protocol_name_snapshot'] = Variable<String>(protocolNameSnapshot);
    map['compound_name_snapshot'] = Variable<String>(compoundNameSnapshot);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LogEntriesTableCompanion toCompanion(bool nullToAbsent) {
    return LogEntriesTableCompanion(
      id: Value(id),
      protocolId: Value(protocolId),
      compoundId: Value(compoundId),
      loggedAt: Value(loggedAt),
      status: Value(status),
      amount: amount == null && nullToAbsent
          ? const Value.absent()
          : Value(amount),
      unitLabel: Value(unitLabel),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdFromReminder: Value(createdFromReminder),
      protocolNameSnapshot: Value(protocolNameSnapshot),
      compoundNameSnapshot: Value(compoundNameSnapshot),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LogEntriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogEntriesTableData(
      id: serializer.fromJson<String>(json['id']),
      protocolId: serializer.fromJson<String>(json['protocolId']),
      compoundId: serializer.fromJson<String>(json['compoundId']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      status: serializer.fromJson<String>(json['status']),
      amount: serializer.fromJson<double?>(json['amount']),
      unitLabel: serializer.fromJson<String>(json['unitLabel']),
      note: serializer.fromJson<String?>(json['note']),
      createdFromReminder: serializer.fromJson<bool>(
        json['createdFromReminder'],
      ),
      protocolNameSnapshot: serializer.fromJson<String>(
        json['protocolNameSnapshot'],
      ),
      compoundNameSnapshot: serializer.fromJson<String>(
        json['compoundNameSnapshot'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'protocolId': serializer.toJson<String>(protocolId),
      'compoundId': serializer.toJson<String>(compoundId),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'status': serializer.toJson<String>(status),
      'amount': serializer.toJson<double?>(amount),
      'unitLabel': serializer.toJson<String>(unitLabel),
      'note': serializer.toJson<String?>(note),
      'createdFromReminder': serializer.toJson<bool>(createdFromReminder),
      'protocolNameSnapshot': serializer.toJson<String>(protocolNameSnapshot),
      'compoundNameSnapshot': serializer.toJson<String>(compoundNameSnapshot),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LogEntriesTableData copyWith({
    String? id,
    String? protocolId,
    String? compoundId,
    DateTime? loggedAt,
    String? status,
    Value<double?> amount = const Value.absent(),
    String? unitLabel,
    Value<String?> note = const Value.absent(),
    bool? createdFromReminder,
    String? protocolNameSnapshot,
    String? compoundNameSnapshot,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LogEntriesTableData(
    id: id ?? this.id,
    protocolId: protocolId ?? this.protocolId,
    compoundId: compoundId ?? this.compoundId,
    loggedAt: loggedAt ?? this.loggedAt,
    status: status ?? this.status,
    amount: amount.present ? amount.value : this.amount,
    unitLabel: unitLabel ?? this.unitLabel,
    note: note.present ? note.value : this.note,
    createdFromReminder: createdFromReminder ?? this.createdFromReminder,
    protocolNameSnapshot: protocolNameSnapshot ?? this.protocolNameSnapshot,
    compoundNameSnapshot: compoundNameSnapshot ?? this.compoundNameSnapshot,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LogEntriesTableData copyWithCompanion(LogEntriesTableCompanion data) {
    return LogEntriesTableData(
      id: data.id.present ? data.id.value : this.id,
      protocolId: data.protocolId.present
          ? data.protocolId.value
          : this.protocolId,
      compoundId: data.compoundId.present
          ? data.compoundId.value
          : this.compoundId,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      status: data.status.present ? data.status.value : this.status,
      amount: data.amount.present ? data.amount.value : this.amount,
      unitLabel: data.unitLabel.present ? data.unitLabel.value : this.unitLabel,
      note: data.note.present ? data.note.value : this.note,
      createdFromReminder: data.createdFromReminder.present
          ? data.createdFromReminder.value
          : this.createdFromReminder,
      protocolNameSnapshot: data.protocolNameSnapshot.present
          ? data.protocolNameSnapshot.value
          : this.protocolNameSnapshot,
      compoundNameSnapshot: data.compoundNameSnapshot.present
          ? data.compoundNameSnapshot.value
          : this.compoundNameSnapshot,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogEntriesTableData(')
          ..write('id: $id, ')
          ..write('protocolId: $protocolId, ')
          ..write('compoundId: $compoundId, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('status: $status, ')
          ..write('amount: $amount, ')
          ..write('unitLabel: $unitLabel, ')
          ..write('note: $note, ')
          ..write('createdFromReminder: $createdFromReminder, ')
          ..write('protocolNameSnapshot: $protocolNameSnapshot, ')
          ..write('compoundNameSnapshot: $compoundNameSnapshot, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    protocolId,
    compoundId,
    loggedAt,
    status,
    amount,
    unitLabel,
    note,
    createdFromReminder,
    protocolNameSnapshot,
    compoundNameSnapshot,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogEntriesTableData &&
          other.id == this.id &&
          other.protocolId == this.protocolId &&
          other.compoundId == this.compoundId &&
          other.loggedAt == this.loggedAt &&
          other.status == this.status &&
          other.amount == this.amount &&
          other.unitLabel == this.unitLabel &&
          other.note == this.note &&
          other.createdFromReminder == this.createdFromReminder &&
          other.protocolNameSnapshot == this.protocolNameSnapshot &&
          other.compoundNameSnapshot == this.compoundNameSnapshot &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LogEntriesTableCompanion extends UpdateCompanion<LogEntriesTableData> {
  final Value<String> id;
  final Value<String> protocolId;
  final Value<String> compoundId;
  final Value<DateTime> loggedAt;
  final Value<String> status;
  final Value<double?> amount;
  final Value<String> unitLabel;
  final Value<String?> note;
  final Value<bool> createdFromReminder;
  final Value<String> protocolNameSnapshot;
  final Value<String> compoundNameSnapshot;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LogEntriesTableCompanion({
    this.id = const Value.absent(),
    this.protocolId = const Value.absent(),
    this.compoundId = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.amount = const Value.absent(),
    this.unitLabel = const Value.absent(),
    this.note = const Value.absent(),
    this.createdFromReminder = const Value.absent(),
    this.protocolNameSnapshot = const Value.absent(),
    this.compoundNameSnapshot = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LogEntriesTableCompanion.insert({
    required String id,
    required String protocolId,
    required String compoundId,
    required DateTime loggedAt,
    required String status,
    this.amount = const Value.absent(),
    required String unitLabel,
    this.note = const Value.absent(),
    this.createdFromReminder = const Value.absent(),
    required String protocolNameSnapshot,
    required String compoundNameSnapshot,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       protocolId = Value(protocolId),
       compoundId = Value(compoundId),
       loggedAt = Value(loggedAt),
       status = Value(status),
       unitLabel = Value(unitLabel),
       protocolNameSnapshot = Value(protocolNameSnapshot),
       compoundNameSnapshot = Value(compoundNameSnapshot),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LogEntriesTableData> custom({
    Expression<String>? id,
    Expression<String>? protocolId,
    Expression<String>? compoundId,
    Expression<DateTime>? loggedAt,
    Expression<String>? status,
    Expression<double>? amount,
    Expression<String>? unitLabel,
    Expression<String>? note,
    Expression<bool>? createdFromReminder,
    Expression<String>? protocolNameSnapshot,
    Expression<String>? compoundNameSnapshot,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (protocolId != null) 'protocol_id': protocolId,
      if (compoundId != null) 'compound_id': compoundId,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (status != null) 'status': status,
      if (amount != null) 'amount': amount,
      if (unitLabel != null) 'unit_label': unitLabel,
      if (note != null) 'note': note,
      if (createdFromReminder != null)
        'created_from_reminder': createdFromReminder,
      if (protocolNameSnapshot != null)
        'protocol_name_snapshot': protocolNameSnapshot,
      if (compoundNameSnapshot != null)
        'compound_name_snapshot': compoundNameSnapshot,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LogEntriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? protocolId,
    Value<String>? compoundId,
    Value<DateTime>? loggedAt,
    Value<String>? status,
    Value<double?>? amount,
    Value<String>? unitLabel,
    Value<String?>? note,
    Value<bool>? createdFromReminder,
    Value<String>? protocolNameSnapshot,
    Value<String>? compoundNameSnapshot,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return LogEntriesTableCompanion(
      id: id ?? this.id,
      protocolId: protocolId ?? this.protocolId,
      compoundId: compoundId ?? this.compoundId,
      loggedAt: loggedAt ?? this.loggedAt,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      unitLabel: unitLabel ?? this.unitLabel,
      note: note ?? this.note,
      createdFromReminder: createdFromReminder ?? this.createdFromReminder,
      protocolNameSnapshot: protocolNameSnapshot ?? this.protocolNameSnapshot,
      compoundNameSnapshot: compoundNameSnapshot ?? this.compoundNameSnapshot,
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
    if (protocolId.present) {
      map['protocol_id'] = Variable<String>(protocolId.value);
    }
    if (compoundId.present) {
      map['compound_id'] = Variable<String>(compoundId.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (unitLabel.present) {
      map['unit_label'] = Variable<String>(unitLabel.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdFromReminder.present) {
      map['created_from_reminder'] = Variable<bool>(createdFromReminder.value);
    }
    if (protocolNameSnapshot.present) {
      map['protocol_name_snapshot'] = Variable<String>(
        protocolNameSnapshot.value,
      );
    }
    if (compoundNameSnapshot.present) {
      map['compound_name_snapshot'] = Variable<String>(
        compoundNameSnapshot.value,
      );
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
    return (StringBuffer('LogEntriesTableCompanion(')
          ..write('id: $id, ')
          ..write('protocolId: $protocolId, ')
          ..write('compoundId: $compoundId, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('status: $status, ')
          ..write('amount: $amount, ')
          ..write('unitLabel: $unitLabel, ')
          ..write('note: $note, ')
          ..write('createdFromReminder: $createdFromReminder, ')
          ..write('protocolNameSnapshot: $protocolNameSnapshot, ')
          ..write('compoundNameSnapshot: $compoundNameSnapshot, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CompoundsTableTable compoundsTable = $CompoundsTableTable(this);
  late final $ProtocolsTableTable protocolsTable = $ProtocolsTableTable(this);
  late final $LogEntriesTableTable logEntriesTable = $LogEntriesTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    compoundsTable,
    protocolsTable,
    logEntriesTable,
  ];
}

typedef $$CompoundsTableTableCreateCompanionBuilder =
    CompoundsTableCompanion Function({
      required String id,
      required String name,
      required String category,
      required String defaultUnit,
      Value<String?> notes,
      Value<bool> isArchived,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CompoundsTableTableUpdateCompanionBuilder =
    CompoundsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> category,
      Value<String> defaultUnit,
      Value<String?> notes,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$CompoundsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CompoundsTableTable,
          CompoundsTableData
        > {
  $$CompoundsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ProtocolsTableTable, List<ProtocolsTableData>>
  _protocolsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.protocolsTable,
    aliasName: $_aliasNameGenerator(
      db.compoundsTable.id,
      db.protocolsTable.compoundId,
    ),
  );

  $$ProtocolsTableTableProcessedTableManager get protocolsTableRefs {
    final manager = $$ProtocolsTableTableTableManager(
      $_db,
      $_db.protocolsTable,
    ).filter((f) => f.compoundId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_protocolsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LogEntriesTableTable, List<LogEntriesTableData>>
  _logEntriesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.logEntriesTable,
    aliasName: $_aliasNameGenerator(
      db.compoundsTable.id,
      db.logEntriesTable.compoundId,
    ),
  );

  $$LogEntriesTableTableProcessedTableManager get logEntriesTableRefs {
    final manager = $$LogEntriesTableTableTableManager(
      $_db,
      $_db.logEntriesTable,
    ).filter((f) => f.compoundId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _logEntriesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CompoundsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CompoundsTableTable> {
  $$CompoundsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> protocolsTableRefs(
    Expression<bool> Function($$ProtocolsTableTableFilterComposer f) f,
  ) {
    final $$ProtocolsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.protocolsTable,
      getReferencedColumn: (t) => t.compoundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProtocolsTableTableFilterComposer(
            $db: $db,
            $table: $db.protocolsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> logEntriesTableRefs(
    Expression<bool> Function($$LogEntriesTableTableFilterComposer f) f,
  ) {
    final $$LogEntriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logEntriesTable,
      getReferencedColumn: (t) => t.compoundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogEntriesTableTableFilterComposer(
            $db: $db,
            $table: $db.logEntriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CompoundsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CompoundsTableTable> {
  $$CompoundsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompoundsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompoundsTableTable> {
  $$CompoundsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> protocolsTableRefs<T extends Object>(
    Expression<T> Function($$ProtocolsTableTableAnnotationComposer a) f,
  ) {
    final $$ProtocolsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.protocolsTable,
      getReferencedColumn: (t) => t.compoundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProtocolsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.protocolsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> logEntriesTableRefs<T extends Object>(
    Expression<T> Function($$LogEntriesTableTableAnnotationComposer a) f,
  ) {
    final $$LogEntriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logEntriesTable,
      getReferencedColumn: (t) => t.compoundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogEntriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.logEntriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CompoundsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompoundsTableTable,
          CompoundsTableData,
          $$CompoundsTableTableFilterComposer,
          $$CompoundsTableTableOrderingComposer,
          $$CompoundsTableTableAnnotationComposer,
          $$CompoundsTableTableCreateCompanionBuilder,
          $$CompoundsTableTableUpdateCompanionBuilder,
          (CompoundsTableData, $$CompoundsTableTableReferences),
          CompoundsTableData,
          PrefetchHooks Function({
            bool protocolsTableRefs,
            bool logEntriesTableRefs,
          })
        > {
  $$CompoundsTableTableTableManager(
    _$AppDatabase db,
    $CompoundsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompoundsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompoundsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompoundsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> defaultUnit = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompoundsTableCompanion(
                id: id,
                name: name,
                category: category,
                defaultUnit: defaultUnit,
                notes: notes,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String category,
                required String defaultUnit,
                Value<String?> notes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CompoundsTableCompanion.insert(
                id: id,
                name: name,
                category: category,
                defaultUnit: defaultUnit,
                notes: notes,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CompoundsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({protocolsTableRefs = false, logEntriesTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (protocolsTableRefs) db.protocolsTable,
                    if (logEntriesTableRefs) db.logEntriesTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (protocolsTableRefs)
                        await $_getPrefetchedData<
                          CompoundsTableData,
                          $CompoundsTableTable,
                          ProtocolsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CompoundsTableTableReferences
                              ._protocolsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CompoundsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).protocolsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.compoundId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (logEntriesTableRefs)
                        await $_getPrefetchedData<
                          CompoundsTableData,
                          $CompoundsTableTable,
                          LogEntriesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CompoundsTableTableReferences
                              ._logEntriesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CompoundsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).logEntriesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.compoundId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CompoundsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompoundsTableTable,
      CompoundsTableData,
      $$CompoundsTableTableFilterComposer,
      $$CompoundsTableTableOrderingComposer,
      $$CompoundsTableTableAnnotationComposer,
      $$CompoundsTableTableCreateCompanionBuilder,
      $$CompoundsTableTableUpdateCompanionBuilder,
      (CompoundsTableData, $$CompoundsTableTableReferences),
      CompoundsTableData,
      PrefetchHooks Function({
        bool protocolsTableRefs,
        bool logEntriesTableRefs,
      })
    >;
typedef $$ProtocolsTableTableCreateCompanionBuilder =
    ProtocolsTableCompanion Function({
      required String id,
      required String compoundId,
      required String name,
      Value<double?> plannedAmount,
      required String unitLabel,
      required String scheduleType,
      Value<int?> intervalDays,
      Value<int?> reminderMinutesAfterMidnight,
      required DateTime startDate,
      Value<bool> isActive,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ProtocolsTableTableUpdateCompanionBuilder =
    ProtocolsTableCompanion Function({
      Value<String> id,
      Value<String> compoundId,
      Value<String> name,
      Value<double?> plannedAmount,
      Value<String> unitLabel,
      Value<String> scheduleType,
      Value<int?> intervalDays,
      Value<int?> reminderMinutesAfterMidnight,
      Value<DateTime> startDate,
      Value<bool> isActive,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ProtocolsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProtocolsTableTable,
          ProtocolsTableData
        > {
  $$ProtocolsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CompoundsTableTable _compoundIdTable(_$AppDatabase db) =>
      db.compoundsTable.createAlias(
        $_aliasNameGenerator(
          db.protocolsTable.compoundId,
          db.compoundsTable.id,
        ),
      );

  $$CompoundsTableTableProcessedTableManager get compoundId {
    final $_column = $_itemColumn<String>('compound_id')!;

    final manager = $$CompoundsTableTableTableManager(
      $_db,
      $_db.compoundsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_compoundIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LogEntriesTableTable, List<LogEntriesTableData>>
  _logEntriesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.logEntriesTable,
    aliasName: $_aliasNameGenerator(
      db.protocolsTable.id,
      db.logEntriesTable.protocolId,
    ),
  );

  $$LogEntriesTableTableProcessedTableManager get logEntriesTableRefs {
    final manager = $$LogEntriesTableTableTableManager(
      $_db,
      $_db.logEntriesTable,
    ).filter((f) => f.protocolId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _logEntriesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProtocolsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProtocolsTableTable> {
  $$ProtocolsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get plannedAmount => $composableBuilder(
    column: $table.plannedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitLabel => $composableBuilder(
    column: $table.unitLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderMinutesAfterMidnight => $composableBuilder(
    column: $table.reminderMinutesAfterMidnight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CompoundsTableTableFilterComposer get compoundId {
    final $$CompoundsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.compoundId,
      referencedTable: $db.compoundsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompoundsTableTableFilterComposer(
            $db: $db,
            $table: $db.compoundsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> logEntriesTableRefs(
    Expression<bool> Function($$LogEntriesTableTableFilterComposer f) f,
  ) {
    final $$LogEntriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logEntriesTable,
      getReferencedColumn: (t) => t.protocolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogEntriesTableTableFilterComposer(
            $db: $db,
            $table: $db.logEntriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProtocolsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProtocolsTableTable> {
  $$ProtocolsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get plannedAmount => $composableBuilder(
    column: $table.plannedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitLabel => $composableBuilder(
    column: $table.unitLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderMinutesAfterMidnight => $composableBuilder(
    column: $table.reminderMinutesAfterMidnight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CompoundsTableTableOrderingComposer get compoundId {
    final $$CompoundsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.compoundId,
      referencedTable: $db.compoundsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompoundsTableTableOrderingComposer(
            $db: $db,
            $table: $db.compoundsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProtocolsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProtocolsTableTable> {
  $$ProtocolsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get plannedAmount => $composableBuilder(
    column: $table.plannedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unitLabel =>
      $composableBuilder(column: $table.unitLabel, builder: (column) => column);

  GeneratedColumn<String> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderMinutesAfterMidnight => $composableBuilder(
    column: $table.reminderMinutesAfterMidnight,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CompoundsTableTableAnnotationComposer get compoundId {
    final $$CompoundsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.compoundId,
      referencedTable: $db.compoundsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompoundsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.compoundsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> logEntriesTableRefs<T extends Object>(
    Expression<T> Function($$LogEntriesTableTableAnnotationComposer a) f,
  ) {
    final $$LogEntriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logEntriesTable,
      getReferencedColumn: (t) => t.protocolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogEntriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.logEntriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProtocolsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProtocolsTableTable,
          ProtocolsTableData,
          $$ProtocolsTableTableFilterComposer,
          $$ProtocolsTableTableOrderingComposer,
          $$ProtocolsTableTableAnnotationComposer,
          $$ProtocolsTableTableCreateCompanionBuilder,
          $$ProtocolsTableTableUpdateCompanionBuilder,
          (ProtocolsTableData, $$ProtocolsTableTableReferences),
          ProtocolsTableData,
          PrefetchHooks Function({bool compoundId, bool logEntriesTableRefs})
        > {
  $$ProtocolsTableTableTableManager(
    _$AppDatabase db,
    $ProtocolsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProtocolsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProtocolsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProtocolsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> compoundId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double?> plannedAmount = const Value.absent(),
                Value<String> unitLabel = const Value.absent(),
                Value<String> scheduleType = const Value.absent(),
                Value<int?> intervalDays = const Value.absent(),
                Value<int?> reminderMinutesAfterMidnight = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProtocolsTableCompanion(
                id: id,
                compoundId: compoundId,
                name: name,
                plannedAmount: plannedAmount,
                unitLabel: unitLabel,
                scheduleType: scheduleType,
                intervalDays: intervalDays,
                reminderMinutesAfterMidnight: reminderMinutesAfterMidnight,
                startDate: startDate,
                isActive: isActive,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String compoundId,
                required String name,
                Value<double?> plannedAmount = const Value.absent(),
                required String unitLabel,
                required String scheduleType,
                Value<int?> intervalDays = const Value.absent(),
                Value<int?> reminderMinutesAfterMidnight = const Value.absent(),
                required DateTime startDate,
                Value<bool> isActive = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProtocolsTableCompanion.insert(
                id: id,
                compoundId: compoundId,
                name: name,
                plannedAmount: plannedAmount,
                unitLabel: unitLabel,
                scheduleType: scheduleType,
                intervalDays: intervalDays,
                reminderMinutesAfterMidnight: reminderMinutesAfterMidnight,
                startDate: startDate,
                isActive: isActive,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProtocolsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({compoundId = false, logEntriesTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (logEntriesTableRefs) db.logEntriesTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (compoundId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.compoundId,
                                    referencedTable:
                                        $$ProtocolsTableTableReferences
                                            ._compoundIdTable(db),
                                    referencedColumn:
                                        $$ProtocolsTableTableReferences
                                            ._compoundIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (logEntriesTableRefs)
                        await $_getPrefetchedData<
                          ProtocolsTableData,
                          $ProtocolsTableTable,
                          LogEntriesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$ProtocolsTableTableReferences
                              ._logEntriesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProtocolsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).logEntriesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.protocolId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProtocolsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProtocolsTableTable,
      ProtocolsTableData,
      $$ProtocolsTableTableFilterComposer,
      $$ProtocolsTableTableOrderingComposer,
      $$ProtocolsTableTableAnnotationComposer,
      $$ProtocolsTableTableCreateCompanionBuilder,
      $$ProtocolsTableTableUpdateCompanionBuilder,
      (ProtocolsTableData, $$ProtocolsTableTableReferences),
      ProtocolsTableData,
      PrefetchHooks Function({bool compoundId, bool logEntriesTableRefs})
    >;
typedef $$LogEntriesTableTableCreateCompanionBuilder =
    LogEntriesTableCompanion Function({
      required String id,
      required String protocolId,
      required String compoundId,
      required DateTime loggedAt,
      required String status,
      Value<double?> amount,
      required String unitLabel,
      Value<String?> note,
      Value<bool> createdFromReminder,
      required String protocolNameSnapshot,
      required String compoundNameSnapshot,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$LogEntriesTableTableUpdateCompanionBuilder =
    LogEntriesTableCompanion Function({
      Value<String> id,
      Value<String> protocolId,
      Value<String> compoundId,
      Value<DateTime> loggedAt,
      Value<String> status,
      Value<double?> amount,
      Value<String> unitLabel,
      Value<String?> note,
      Value<bool> createdFromReminder,
      Value<String> protocolNameSnapshot,
      Value<String> compoundNameSnapshot,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$LogEntriesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LogEntriesTableTable,
          LogEntriesTableData
        > {
  $$LogEntriesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProtocolsTableTable _protocolIdTable(_$AppDatabase db) =>
      db.protocolsTable.createAlias(
        $_aliasNameGenerator(
          db.logEntriesTable.protocolId,
          db.protocolsTable.id,
        ),
      );

  $$ProtocolsTableTableProcessedTableManager get protocolId {
    final $_column = $_itemColumn<String>('protocol_id')!;

    final manager = $$ProtocolsTableTableTableManager(
      $_db,
      $_db.protocolsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_protocolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CompoundsTableTable _compoundIdTable(_$AppDatabase db) =>
      db.compoundsTable.createAlias(
        $_aliasNameGenerator(
          db.logEntriesTable.compoundId,
          db.compoundsTable.id,
        ),
      );

  $$CompoundsTableTableProcessedTableManager get compoundId {
    final $_column = $_itemColumn<String>('compound_id')!;

    final manager = $$CompoundsTableTableTableManager(
      $_db,
      $_db.compoundsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_compoundIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LogEntriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $LogEntriesTableTable> {
  $$LogEntriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitLabel => $composableBuilder(
    column: $table.unitLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get createdFromReminder => $composableBuilder(
    column: $table.createdFromReminder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get protocolNameSnapshot => $composableBuilder(
    column: $table.protocolNameSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get compoundNameSnapshot => $composableBuilder(
    column: $table.compoundNameSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProtocolsTableTableFilterComposer get protocolId {
    final $$ProtocolsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.protocolId,
      referencedTable: $db.protocolsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProtocolsTableTableFilterComposer(
            $db: $db,
            $table: $db.protocolsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompoundsTableTableFilterComposer get compoundId {
    final $$CompoundsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.compoundId,
      referencedTable: $db.compoundsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompoundsTableTableFilterComposer(
            $db: $db,
            $table: $db.compoundsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogEntriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LogEntriesTableTable> {
  $$LogEntriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitLabel => $composableBuilder(
    column: $table.unitLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get createdFromReminder => $composableBuilder(
    column: $table.createdFromReminder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get protocolNameSnapshot => $composableBuilder(
    column: $table.protocolNameSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get compoundNameSnapshot => $composableBuilder(
    column: $table.compoundNameSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProtocolsTableTableOrderingComposer get protocolId {
    final $$ProtocolsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.protocolId,
      referencedTable: $db.protocolsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProtocolsTableTableOrderingComposer(
            $db: $db,
            $table: $db.protocolsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompoundsTableTableOrderingComposer get compoundId {
    final $$CompoundsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.compoundId,
      referencedTable: $db.compoundsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompoundsTableTableOrderingComposer(
            $db: $db,
            $table: $db.compoundsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogEntriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogEntriesTableTable> {
  $$LogEntriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get unitLabel =>
      $composableBuilder(column: $table.unitLabel, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get createdFromReminder => $composableBuilder(
    column: $table.createdFromReminder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get protocolNameSnapshot => $composableBuilder(
    column: $table.protocolNameSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get compoundNameSnapshot => $composableBuilder(
    column: $table.compoundNameSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProtocolsTableTableAnnotationComposer get protocolId {
    final $$ProtocolsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.protocolId,
      referencedTable: $db.protocolsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProtocolsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.protocolsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompoundsTableTableAnnotationComposer get compoundId {
    final $$CompoundsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.compoundId,
      referencedTable: $db.compoundsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompoundsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.compoundsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogEntriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LogEntriesTableTable,
          LogEntriesTableData,
          $$LogEntriesTableTableFilterComposer,
          $$LogEntriesTableTableOrderingComposer,
          $$LogEntriesTableTableAnnotationComposer,
          $$LogEntriesTableTableCreateCompanionBuilder,
          $$LogEntriesTableTableUpdateCompanionBuilder,
          (LogEntriesTableData, $$LogEntriesTableTableReferences),
          LogEntriesTableData,
          PrefetchHooks Function({bool protocolId, bool compoundId})
        > {
  $$LogEntriesTableTableTableManager(
    _$AppDatabase db,
    $LogEntriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogEntriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogEntriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogEntriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> protocolId = const Value.absent(),
                Value<String> compoundId = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<String> unitLabel = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> createdFromReminder = const Value.absent(),
                Value<String> protocolNameSnapshot = const Value.absent(),
                Value<String> compoundNameSnapshot = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LogEntriesTableCompanion(
                id: id,
                protocolId: protocolId,
                compoundId: compoundId,
                loggedAt: loggedAt,
                status: status,
                amount: amount,
                unitLabel: unitLabel,
                note: note,
                createdFromReminder: createdFromReminder,
                protocolNameSnapshot: protocolNameSnapshot,
                compoundNameSnapshot: compoundNameSnapshot,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String protocolId,
                required String compoundId,
                required DateTime loggedAt,
                required String status,
                Value<double?> amount = const Value.absent(),
                required String unitLabel,
                Value<String?> note = const Value.absent(),
                Value<bool> createdFromReminder = const Value.absent(),
                required String protocolNameSnapshot,
                required String compoundNameSnapshot,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => LogEntriesTableCompanion.insert(
                id: id,
                protocolId: protocolId,
                compoundId: compoundId,
                loggedAt: loggedAt,
                status: status,
                amount: amount,
                unitLabel: unitLabel,
                note: note,
                createdFromReminder: createdFromReminder,
                protocolNameSnapshot: protocolNameSnapshot,
                compoundNameSnapshot: compoundNameSnapshot,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LogEntriesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({protocolId = false, compoundId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (protocolId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.protocolId,
                                referencedTable:
                                    $$LogEntriesTableTableReferences
                                        ._protocolIdTable(db),
                                referencedColumn:
                                    $$LogEntriesTableTableReferences
                                        ._protocolIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (compoundId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.compoundId,
                                referencedTable:
                                    $$LogEntriesTableTableReferences
                                        ._compoundIdTable(db),
                                referencedColumn:
                                    $$LogEntriesTableTableReferences
                                        ._compoundIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LogEntriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LogEntriesTableTable,
      LogEntriesTableData,
      $$LogEntriesTableTableFilterComposer,
      $$LogEntriesTableTableOrderingComposer,
      $$LogEntriesTableTableAnnotationComposer,
      $$LogEntriesTableTableCreateCompanionBuilder,
      $$LogEntriesTableTableUpdateCompanionBuilder,
      (LogEntriesTableData, $$LogEntriesTableTableReferences),
      LogEntriesTableData,
      PrefetchHooks Function({bool protocolId, bool compoundId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CompoundsTableTableTableManager get compoundsTable =>
      $$CompoundsTableTableTableManager(_db, _db.compoundsTable);
  $$ProtocolsTableTableTableManager get protocolsTable =>
      $$ProtocolsTableTableTableManager(_db, _db.protocolsTable);
  $$LogEntriesTableTableTableManager get logEntriesTable =>
      $$LogEntriesTableTableTableManager(_db, _db.logEntriesTable);
}
