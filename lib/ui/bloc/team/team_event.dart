import 'package:equatable/equatable.dart';
import 'package:street_set/ui/db/set_db.dart';

abstract class TeamEvent extends Equatable {
  const TeamEvent();

  @override
  List<Object> get props => [];
}

class TeamLoadEvent extends TeamEvent {}

class AddTeamEvent extends TeamEvent {
  final TeamData team;

  AddTeamEvent({this.team});

  @override
  List<Object> get props => [ team ];
}

class TeamLossEvent extends TeamEvent {
  final TeamData team;

  TeamLossEvent(this.team);

  @override
  List<Object> get props => [ team ];

}

class BothTeamOutEvent extends TeamEvent {
  final List<TeamData> teams;

  BothTeamOutEvent(this.teams);

  @override
  List<Object> get props => teams;
}

class ClearAllEvent extends TeamEvent {

  ClearAllEvent();

  List<Object> get props => [];


}