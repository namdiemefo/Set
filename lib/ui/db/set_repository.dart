import 'package:flutter/cupertino.dart';
import 'package:street_set/ui/db/set_db.dart';

abstract class ITeamRepository {
  Stream<List<TeamData>> getTeams();
  Future<List<TeamData>> getAllTeams();
  Future saveTeam(TeamData teamData);
  Future deleteTeam();
}

class TeamRepository implements ITeamRepository {
  final SetDao _setDao;

  TeamRepository({ setDao }) : _setDao = setDao;

  @override
  Stream<List<TeamData>> getTeams() {
    return _setDao.watchAllTeams();
  }

  @override
  Future<int> saveTeam(TeamData teamData) async {
    var completed;
    var teams = await _setDao.getAllTeams();
    var sets = List<int>();
    for (var i = 0; i < teams.length; i++) {
      sets.add(teams[i].set);
    }
    if (sets.contains(teamData.set)) {
      return Future.sync(() => 0);
    } else {
      completed = await _setDao.insertTeam(teamData);
      return completed;
    }
    // int num = teams.length;
    //  if (num < 8) {
    //    completed = await _setDao.insertTeam(teamData);
    //    print(completed.toString());
    // }
  }

  @override
  Future<List<TeamData>> getAllTeams() {
    return _setDao.getAllTeams();
  }

  @override
  Future deleteTeam() {
    return _setDao.deleteTeams();
  }


}