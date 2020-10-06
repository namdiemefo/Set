// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TeamData extends DataClass implements Insertable<TeamData> {
  final int set;
  final DateTime date;
  final int num;
  TeamData({@required this.set, @required this.date, @required this.num});
  factory TeamData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return TeamData(
      set: intType.mapFromDatabaseResponse(data['${effectivePrefix}set']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      num: intType.mapFromDatabaseResponse(data['${effectivePrefix}num']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || set != null) {
      map['set'] = Variable<int>(set);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || num != null) {
      map['num'] = Variable<int>(num);
    }
    return map;
  }

  TeamCompanion toCompanion(bool nullToAbsent) {
    return TeamCompanion(
      set: set == null && nullToAbsent ? const Value.absent() : Value(set),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      num: num == null && nullToAbsent ? const Value.absent() : Value(num),
    );
  }

  factory TeamData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TeamData(
      set: serializer.fromJson<int>(json['set']),
      date: serializer.fromJson<DateTime>(json['date']),
      num: serializer.fromJson<int>(json['num']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'set': serializer.toJson<int>(set),
      'date': serializer.toJson<DateTime>(date),
      'num': serializer.toJson<int>(num),
    };
  }

  TeamData copyWith({int set, DateTime date, int num}) => TeamData(
        set: set ?? this.set,
        date: date ?? this.date,
        num: num ?? this.num,
      );
  @override
  String toString() {
    return (StringBuffer('TeamData(')
          ..write('set: $set, ')
          ..write('date: $date, ')
          ..write('num: $num')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(set.hashCode, $mrjc(date.hashCode, num.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TeamData &&
          other.set == this.set &&
          other.date == this.date &&
          other.num == this.num);
}

class TeamCompanion extends UpdateCompanion<TeamData> {
  final Value<int> set;
  final Value<DateTime> date;
  final Value<int> num;
  const TeamCompanion({
    this.set = const Value.absent(),
    this.date = const Value.absent(),
    this.num = const Value.absent(),
  });
  TeamCompanion.insert({
    @required int set,
    @required DateTime date,
    this.num = const Value.absent(),
  })  : set = Value(set),
        date = Value(date);
  static Insertable<TeamData> custom({
    Expression<int> set,
    Expression<DateTime> date,
    Expression<int> num,
  }) {
    return RawValuesInsertable({
      if (set != null) 'set': set,
      if (date != null) 'date': date,
      if (num != null) 'num': num,
    });
  }

  TeamCompanion copyWith(
      {Value<int> set, Value<DateTime> date, Value<int> num}) {
    return TeamCompanion(
      set: set ?? this.set,
      date: date ?? this.date,
      num: num ?? this.num,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (set.present) {
      map['set'] = Variable<int>(set.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (num.present) {
      map['num'] = Variable<int>(num.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamCompanion(')
          ..write('set: $set, ')
          ..write('date: $date, ')
          ..write('num: $num')
          ..write(')'))
        .toString();
  }
}

class $TeamTable extends Team with TableInfo<$TeamTable, TeamData> {
  final GeneratedDatabase _db;
  final String _alias;
  $TeamTable(this._db, [this._alias]);
  final VerificationMeta _setMeta = const VerificationMeta('set');
  GeneratedIntColumn _set;
  @override
  GeneratedIntColumn get set => _set ??= _constructSet();
  GeneratedIntColumn _constructSet() {
    return GeneratedIntColumn(
      'set',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _numMeta = const VerificationMeta('num');
  GeneratedIntColumn _num;
  @override
  GeneratedIntColumn get num => _num ??= _constructNum();
  GeneratedIntColumn _constructNum() {
    return GeneratedIntColumn('num', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  @override
  List<GeneratedColumn> get $columns => [set, date, num];
  @override
  $TeamTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'team';
  @override
  final String actualTableName = 'team';
  @override
  VerificationContext validateIntegrity(Insertable<TeamData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('set')) {
      context.handle(
          _setMeta, set.isAcceptableOrUnknown(data['set'], _setMeta));
    } else if (isInserting) {
      context.missing(_setMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('num')) {
      context.handle(
          _numMeta, num.isAcceptableOrUnknown(data['num'], _numMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {num};
  @override
  TeamData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TeamData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TeamTable createAlias(String alias) {
    return $TeamTable(_db, alias);
  }
}

abstract class _$SetDatabase extends GeneratedDatabase {
  _$SetDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TeamTable _team;
  $TeamTable get team => _team ??= $TeamTable(this);
  SetDao _setDao;
  SetDao get setDao => _setDao ??= SetDao(this as SetDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [team];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$SetDaoMixin on DatabaseAccessor<SetDatabase> {
  $TeamTable get team => attachedDatabase.team;
}
