import 'package:moor_flutter/moor_flutter.dart';

part 'set_db.g.dart';

class Team extends Table {
 // IntColumn get id => integer().autoIncrement()();
  IntColumn get set => integer()();
  DateTimeColumn get date => dateTime()();
  IntColumn get num => integer().autoIncrement()();

  Set<Column> get primaryKey => { num };
}

@UseMoor(tables: [Team], daos: [SetDao])
class SetDatabase extends _$SetDatabase {
  SetDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'set_db.sqite', logStatements: true));

  @override
  int get schemaVersion => 3;
}

@UseDao(tables: [Team])
class SetDao extends DatabaseAccessor<SetDatabase> with _$SetDaoMixin {
  final SetDatabase db;

  SetDao(this.db) : super(db);

  Future<List<TeamData>> getAllTeams() {
    return select(team).get();
  }

  Stream<List<TeamData>> watchAllTeams() {
    return select(team).watch();
  }

  Future insertTeam(TeamData teams) => into(team).insert(teams);
  Future updateTeam(TeamData teams) => update(team).replace(teams);
  Future deleteTeam(TeamData teams) => delete(team).delete(teams);
  Future deleteTeams() => delete(team).go();

}