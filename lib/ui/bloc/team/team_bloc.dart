import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_set/ui/bloc/team/team_event.dart';
import 'package:street_set/ui/bloc/team/team_state.dart';
import 'package:street_set/ui/db/set_db.dart';
import 'package:street_set/ui/db/set_repository.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  final TeamRepository teamRepository;
  TeamData addedTeam;
  List<TeamData> team;

  TeamBloc({@required this.teamRepository}) : assert(teamRepository != null), super(TeamInitial());

  @override
  Stream<TeamState> mapEventToState(TeamEvent event) async* {
    if (event is TeamLoadEvent) {
      yield* _passAllTeams();
    }
    if (event is TeamLossEvent) {
      yield* _passOneTeam(event);
    } else if (event is BothTeamOutEvent) {
      yield* _passBothTeam(event);
    } else if (event is AddTeamEvent) {
      yield* _add(event);
    } else if (event is ClearAllEvent) {
      yield* _clearAllEvent();
    }

  }

  Future<List<TeamData>> all() async {
    var teams = await teamRepository.getAllTeams();
    return teams;
  }

  Stream<TeamState> _passAllTeams() async* {
    try {
      List<TeamData> teams = await teamRepository.getAllTeams();
      yield TeamSuccess(teams);
    } catch (_) {
      //yield TeamFailure();
    }

  }

  Stream<TeamState> _passOneTeam(TeamLossEvent event) async* {
    TeamData teams = event.team;
    List<TeamData> team = await teamRepository.getAllTeams();
    print('from db ${team.toString()}');
    int index = team.indexWhere((element) => element.set == teams.set );
    print('the index is $index');
    List finals = shiftArray(team, index);
    print('final is ${finals.toString()}');
    await teamRepository.deleteTeam();
    _insertNewSet(finals);
    print('push to ui $finals');
    yield TeamSuccess(finals);
  }

  Stream<TeamState> _add(AddTeamEvent event) async* {
    print('here now');
    TeamData teams = event.team;
    print('team set is ${teams.set.toString()}');
    int done = await teamRepository.saveTeam(teams);
    List<TeamData> team = await teamRepository.getAllTeams();
    // if (done == 0) {
    //   var error = "This set dey already my g";
    //   yield TeamFailure(error);
    //   yield TeamSuccess(team);
    // }
    print(team.toString());
    yield TeamSuccess(team);
  }

  Stream<TeamState> _passBothTeam(BothTeamOutEvent event) async* {
    List<TeamData> teams = event.teams;
    List<int> bothIndexes = List<int>();
    List<TeamData> team = await teamRepository.getAllTeams();
    for (var i = 0; i < teams.length; i++) {
      int index = team.indexWhere((element) => element.set == teams[i].set);
      print('indexes are ${index.toString()}');
      bothIndexes.add(index);
    }
    print('both index is  ${bothIndexes.toString()}');
    List<TeamData> bothSet = _reArrangeTwoSet(team, bothIndexes);
    print('final both sets is ${bothSet.toString()}');
    await teamRepository.deleteTeam();
    _insertNewSet(bothSet);
    yield TeamSuccess(bothSet);
  }

  Stream<TeamState> _clearAllEvent() async* {
    await teamRepository.deleteTeam();
    yield TeamInitial();
  }

  List<TeamData> shiftArray(List<TeamData> array, int oldIndex) {
    var listData = List<TeamData>();
    int zeroth = array[oldIndex].set;
    var empty = List<int>();
    for (var i = 0; i < array.length; i++) {
      empty.add(array[i].set);
    }
    List<int> numb = split(empty, oldIndex);
    numb.add(zeroth);
    for (var j = 0; j < numb.length; j++) {
      var sets = numb[j];
      var team = TeamData(set: sets, date: DateTime.now());
      listData.add(team);
    }
    return listData;
  }

  List<TeamData> _reArrangeTwoSet(List<TeamData> teams, List<int> bothIndexes) {
    var listData = List<TeamData>();
    List<int> sets = List<int>();
    List<int> allSets = List<int>();
    // take the first two sets
    sets.add(teams[0].set);
    sets.add(teams[1].set);
    for (var i = 0; i < teams.length; i++) {
      allSets.add(teams[i].set);
    }
    print('${sets.toString()}');
    List<int> newSets = _moreSplit(allSets, bothIndexes);
    newSets.addAll(sets);
    print('new sets are ${newSets.toString()}');
    for (var j = 0; j < newSets.length; j++) {
      var sets = newSets[j];
      var team = TeamData(set: sets, date: DateTime.now());
      listData.add(team);
    }
    return listData;
  }

  void _insertNewSet(List<TeamData> newSet) async {
    for (var i = 0; i < newSet.length; i++) {
      await teamRepository.saveTeam(newSet[i]);
    }
  }

  List split(List list, int index) {
    list.removeAt(index);
    return list;
  }


  List<int> _moreSplit(List<int> allSets, List<int> bothIndexes) {
    print('all sets is ${allSets.toString()}');
    for (var i = 0; i < bothIndexes.length; i++) {
      print('bozz index ${bothIndexes[i].toString()}');
      allSets.removeAt(bothIndexes[0]);
    }
    print('final sets is ${allSets.toString()}');
    return allSets;
  }

}