// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_db.dart';

// ignore_for_file: type=lint
class $PendingMarksTable extends PendingMarks with TableInfo<$PendingMarksTable, PendingMark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingMarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientMutationIdMeta = const VerificationMeta('clientMutationId');
  @override
  late final GeneratedColumn<String> clientMutationId = GeneratedColumn<String>(
    'client_mutation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _employeeIdMeta = const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
    'employee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _employeeNameMeta = const VerificationMeta('employeeName');
  @override
  late final GeneratedColumn<String> employeeName = GeneratedColumn<String>(
    'employee_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _depotIdMeta = const VerificationMeta('depotId');
  @override
  late final GeneratedColumn<String> depotId = GeneratedColumn<String>('depot_id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>('date', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>('status', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>('note', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PENDING'),
  );
  static const VerificationMeta _errorCodeMeta = const VerificationMeta('errorCode');
  @override
  late final GeneratedColumn<String> errorCode = GeneratedColumn<String>(
    'error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [clientMutationId, employeeId, employeeName, depotId, date, status, note, state, errorCode, errorMessage, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_marks';
  @override
  VerificationContext validateIntegrity(Insertable<PendingMark> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_mutation_id')) {
      context.handle(_clientMutationIdMeta, clientMutationId.isAcceptableOrUnknown(data['client_mutation_id']!, _clientMutationIdMeta));
    } else if (isInserting) {
      context.missing(_clientMutationIdMeta);
    }
    if (data.containsKey('employee_id')) {
      context.handle(_employeeIdMeta, employeeId.isAcceptableOrUnknown(data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('employee_name')) {
      context.handle(_employeeNameMeta, employeeName.isAcceptableOrUnknown(data['employee_name']!, _employeeNameMeta));
    } else if (isInserting) {
      context.missing(_employeeNameMeta);
    }
    if (data.containsKey('depot_id')) {
      context.handle(_depotIdMeta, depotId.isAcceptableOrUnknown(data['depot_id']!, _depotIdMeta));
    } else if (isInserting) {
      context.missing(_depotIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(_dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta, status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('state')) {
      context.handle(_stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    }
    if (data.containsKey('error_code')) {
      context.handle(_errorCodeMeta, errorCode.isAcceptableOrUnknown(data['error_code']!, _errorCodeMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(_errorMessageMeta, errorMessage.isAcceptableOrUnknown(data['error_message']!, _errorMessageMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientMutationId};
  @override
  PendingMark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingMark(
      clientMutationId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}client_mutation_id'])!,
      employeeId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      employeeName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}employee_name'])!,
      depotId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}depot_id'])!,
      date: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      status: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
      state: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      errorCode: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}error_code']),
      errorMessage: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}error_message']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PendingMarksTable createAlias(String alias) {
    return $PendingMarksTable(attachedDatabase, alias);
  }
}

class PendingMark extends DataClass implements Insertable<PendingMark> {
  final String clientMutationId;
  final String employeeId;
  final String employeeName;
  final String depotId;
  final String date;
  final String status;
  final String? note;

  /// PENDING (to send) or FAILED (the API rejected it; needs the manager's attention).
  final String state;
  final String? errorCode;
  final String? errorMessage;
  final DateTime createdAt;
  const PendingMark({
    required this.clientMutationId,
    required this.employeeId,
    required this.employeeName,
    required this.depotId,
    required this.date,
    required this.status,
    this.note,
    required this.state,
    this.errorCode,
    this.errorMessage,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_mutation_id'] = Variable<String>(clientMutationId);
    map['employee_id'] = Variable<String>(employeeId);
    map['employee_name'] = Variable<String>(employeeName);
    map['depot_id'] = Variable<String>(depotId);
    map['date'] = Variable<String>(date);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['state'] = Variable<String>(state);
    if (!nullToAbsent || errorCode != null) {
      map['error_code'] = Variable<String>(errorCode);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PendingMarksCompanion toCompanion(bool nullToAbsent) {
    return PendingMarksCompanion(
      clientMutationId: Value(clientMutationId),
      employeeId: Value(employeeId),
      employeeName: Value(employeeName),
      depotId: Value(depotId),
      date: Value(date),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      state: Value(state),
      errorCode: errorCode == null && nullToAbsent ? const Value.absent() : Value(errorCode),
      errorMessage: errorMessage == null && nullToAbsent ? const Value.absent() : Value(errorMessage),
      createdAt: Value(createdAt),
    );
  }

  factory PendingMark.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingMark(
      clientMutationId: serializer.fromJson<String>(json['clientMutationId']),
      employeeId: serializer.fromJson<String>(json['employeeId']),
      employeeName: serializer.fromJson<String>(json['employeeName']),
      depotId: serializer.fromJson<String>(json['depotId']),
      date: serializer.fromJson<String>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
      state: serializer.fromJson<String>(json['state']),
      errorCode: serializer.fromJson<String?>(json['errorCode']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientMutationId': serializer.toJson<String>(clientMutationId),
      'employeeId': serializer.toJson<String>(employeeId),
      'employeeName': serializer.toJson<String>(employeeName),
      'depotId': serializer.toJson<String>(depotId),
      'date': serializer.toJson<String>(date),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String?>(note),
      'state': serializer.toJson<String>(state),
      'errorCode': serializer.toJson<String?>(errorCode),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PendingMark copyWith({
    String? clientMutationId,
    String? employeeId,
    String? employeeName,
    String? depotId,
    String? date,
    String? status,
    Value<String?> note = const Value.absent(),
    String? state,
    Value<String?> errorCode = const Value.absent(),
    Value<String?> errorMessage = const Value.absent(),
    DateTime? createdAt,
  }) => PendingMark(
    clientMutationId: clientMutationId ?? this.clientMutationId,
    employeeId: employeeId ?? this.employeeId,
    employeeName: employeeName ?? this.employeeName,
    depotId: depotId ?? this.depotId,
    date: date ?? this.date,
    status: status ?? this.status,
    note: note.present ? note.value : this.note,
    state: state ?? this.state,
    errorCode: errorCode.present ? errorCode.value : this.errorCode,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    createdAt: createdAt ?? this.createdAt,
  );
  PendingMark copyWithCompanion(PendingMarksCompanion data) {
    return PendingMark(
      clientMutationId: data.clientMutationId.present ? data.clientMutationId.value : this.clientMutationId,
      employeeId: data.employeeId.present ? data.employeeId.value : this.employeeId,
      employeeName: data.employeeName.present ? data.employeeName.value : this.employeeName,
      depotId: data.depotId.present ? data.depotId.value : this.depotId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
      state: data.state.present ? data.state.value : this.state,
      errorCode: data.errorCode.present ? data.errorCode.value : this.errorCode,
      errorMessage: data.errorMessage.present ? data.errorMessage.value : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingMark(')
          ..write('clientMutationId: $clientMutationId, ')
          ..write('employeeId: $employeeId, ')
          ..write('employeeName: $employeeName, ')
          ..write('depotId: $depotId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('state: $state, ')
          ..write('errorCode: $errorCode, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clientMutationId, employeeId, employeeName, depotId, date, status, note, state, errorCode, errorMessage, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingMark &&
          other.clientMutationId == this.clientMutationId &&
          other.employeeId == this.employeeId &&
          other.employeeName == this.employeeName &&
          other.depotId == this.depotId &&
          other.date == this.date &&
          other.status == this.status &&
          other.note == this.note &&
          other.state == this.state &&
          other.errorCode == this.errorCode &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt);
}

class PendingMarksCompanion extends UpdateCompanion<PendingMark> {
  final Value<String> clientMutationId;
  final Value<String> employeeId;
  final Value<String> employeeName;
  final Value<String> depotId;
  final Value<String> date;
  final Value<String> status;
  final Value<String?> note;
  final Value<String> state;
  final Value<String?> errorCode;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PendingMarksCompanion({
    this.clientMutationId = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.employeeName = const Value.absent(),
    this.depotId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.state = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PendingMarksCompanion.insert({
    required String clientMutationId,
    required String employeeId,
    required String employeeName,
    required String depotId,
    required String date,
    required String status,
    this.note = const Value.absent(),
    this.state = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.errorMessage = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : clientMutationId = Value(clientMutationId),
       employeeId = Value(employeeId),
       employeeName = Value(employeeName),
       depotId = Value(depotId),
       date = Value(date),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<PendingMark> custom({
    Expression<String>? clientMutationId,
    Expression<String>? employeeId,
    Expression<String>? employeeName,
    Expression<String>? depotId,
    Expression<String>? date,
    Expression<String>? status,
    Expression<String>? note,
    Expression<String>? state,
    Expression<String>? errorCode,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientMutationId != null) 'client_mutation_id': clientMutationId,
      if (employeeId != null) 'employee_id': employeeId,
      if (employeeName != null) 'employee_name': employeeName,
      if (depotId != null) 'depot_id': depotId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (state != null) 'state': state,
      if (errorCode != null) 'error_code': errorCode,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PendingMarksCompanion copyWith({
    Value<String>? clientMutationId,
    Value<String>? employeeId,
    Value<String>? employeeName,
    Value<String>? depotId,
    Value<String>? date,
    Value<String>? status,
    Value<String?>? note,
    Value<String>? state,
    Value<String?>? errorCode,
    Value<String?>? errorMessage,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PendingMarksCompanion(
      clientMutationId: clientMutationId ?? this.clientMutationId,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      depotId: depotId ?? this.depotId,
      date: date ?? this.date,
      status: status ?? this.status,
      note: note ?? this.note,
      state: state ?? this.state,
      errorCode: errorCode ?? this.errorCode,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientMutationId.present) {
      map['client_mutation_id'] = Variable<String>(clientMutationId.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (employeeName.present) {
      map['employee_name'] = Variable<String>(employeeName.value);
    }
    if (depotId.present) {
      map['depot_id'] = Variable<String>(depotId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (errorCode.present) {
      map['error_code'] = Variable<String>(errorCode.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingMarksCompanion(')
          ..write('clientMutationId: $clientMutationId, ')
          ..write('employeeId: $employeeId, ')
          ..write('employeeName: $employeeName, ')
          ..write('depotId: $depotId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('state: $state, ')
          ..write('errorCode: $errorCode, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$OfflineDb extends GeneratedDatabase {
  _$OfflineDb(QueryExecutor e) : super(e);
  $OfflineDbManager get managers => $OfflineDbManager(this);
  late final $PendingMarksTable pendingMarks = $PendingMarksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [pendingMarks];
}

typedef $$PendingMarksTableCreateCompanionBuilder = PendingMarksCompanion Function({
  required String clientMutationId,
  required String employeeId,
  required String employeeName,
  required String depotId,
  required String date,
  required String status,
  Value<String?> note,
  Value<String> state,
  Value<String?> errorCode,
  Value<String?> errorMessage,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$PendingMarksTableUpdateCompanionBuilder = PendingMarksCompanion Function({
  Value<String> clientMutationId,
  Value<String> employeeId,
  Value<String> employeeName,
  Value<String> depotId,
  Value<String> date,
  Value<String> status,
  Value<String?> note,
  Value<String> state,
  Value<String?> errorCode,
  Value<String?> errorMessage,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$PendingMarksTableFilterComposer extends Composer<_$OfflineDb, $PendingMarksTable> {
  $$PendingMarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientMutationId => $composableBuilder(column: $table.clientMutationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeId => $composableBuilder(column: $table.employeeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeName => $composableBuilder(column: $table.employeeName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get depotId => $composableBuilder(column: $table.depotId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get state => $composableBuilder(column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorCode => $composableBuilder(column: $table.errorCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(column: $table.errorMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$PendingMarksTableOrderingComposer extends Composer<_$OfflineDb, $PendingMarksTable> {
  $$PendingMarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientMutationId => $composableBuilder(column: $table.clientMutationId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeId => $composableBuilder(column: $table.employeeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeName => $composableBuilder(column: $table.employeeName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get depotId => $composableBuilder(column: $table.depotId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get state => $composableBuilder(column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorCode => $composableBuilder(column: $table.errorCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(column: $table.errorMessage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$PendingMarksTableAnnotationComposer extends Composer<_$OfflineDb, $PendingMarksTable> {
  $$PendingMarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientMutationId => $composableBuilder(column: $table.clientMutationId, builder: (column) => column);

  GeneratedColumn<String> get employeeId => $composableBuilder(column: $table.employeeId, builder: (column) => column);

  GeneratedColumn<String> get employeeName => $composableBuilder(column: $table.employeeName, builder: (column) => column);

  GeneratedColumn<String> get depotId => $composableBuilder(column: $table.depotId, builder: (column) => column);

  GeneratedColumn<String> get date => $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status => $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get state => $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get errorCode => $composableBuilder(column: $table.errorCode, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(column: $table.errorMessage, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PendingMarksTableTableManager
    extends
        RootTableManager<
          _$OfflineDb,
          $PendingMarksTable,
          PendingMark,
          $$PendingMarksTableFilterComposer,
          $$PendingMarksTableOrderingComposer,
          $$PendingMarksTableAnnotationComposer,
          $$PendingMarksTableCreateCompanionBuilder,
          $$PendingMarksTableUpdateCompanionBuilder,
          (PendingMark, BaseReferences<_$OfflineDb, $PendingMarksTable, PendingMark>),
          PendingMark,
          PrefetchHooks Function()
        > {
  $$PendingMarksTableTableManager(_$OfflineDb db, $PendingMarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$PendingMarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$PendingMarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$PendingMarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> clientMutationId = const Value.absent(),
                Value<String> employeeId = const Value.absent(),
                Value<String> employeeName = const Value.absent(),
                Value<String> depotId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PendingMarksCompanion(
                clientMutationId: clientMutationId,
                employeeId: employeeId,
                employeeName: employeeName,
                depotId: depotId,
                date: date,
                status: status,
                note: note,
                state: state,
                errorCode: errorCode,
                errorMessage: errorMessage,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clientMutationId,
                required String employeeId,
                required String employeeName,
                required String depotId,
                required String date,
                required String status,
                Value<String?> note = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PendingMarksCompanion.insert(
                clientMutationId: clientMutationId,
                employeeId: employeeId,
                employeeName: employeeName,
                depotId: depotId,
                date: date,
                status: status,
                note: note,
                state: state,
                errorCode: errorCode,
                errorMessage: errorMessage,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$PendingMarksTable, PendingMark>(table), BaseReferences<_$OfflineDb, $PendingMarksTable, PendingMark>(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingMarksTableProcessedTableManager =
    ProcessedTableManager<
      _$OfflineDb,
      $PendingMarksTable,
      PendingMark,
      $$PendingMarksTableFilterComposer,
      $$PendingMarksTableOrderingComposer,
      $$PendingMarksTableAnnotationComposer,
      $$PendingMarksTableCreateCompanionBuilder,
      $$PendingMarksTableUpdateCompanionBuilder,
      (PendingMark, BaseReferences<_$OfflineDb, $PendingMarksTable, PendingMark>),
      PendingMark,
      PrefetchHooks Function()
    >;

class $OfflineDbManager {
  final _$OfflineDb _db;
  $OfflineDbManager(this._db);
  $$PendingMarksTableTableManager get pendingMarks => $$PendingMarksTableTableManager(_db, _db.pendingMarks);
}
