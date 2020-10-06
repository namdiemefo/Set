import 'package:equatable/equatable.dart';
import 'package:street_set/ui/db/set_db.dart';

abstract class TeamState extends Equatable {
  const TeamState();

  @override
  List<Object> get props => [];

}

class TeamInitial extends TeamState{}

class TeamProgress extends TeamState {
  final List<TeamData> teamData;

  TeamProgress(this.teamData);

  @override
  List<Object> get props => teamData;
}

class TeamSuccess extends TeamState {
  final List<TeamData> teamData;

  TeamSuccess(this.teamData);

  @override
  List<Object> get props => teamData;
}

class TeamFailure extends TeamState {
  final String error;

  TeamFailure(this.error);

  @override
  List<Object> get props => [error];
}


