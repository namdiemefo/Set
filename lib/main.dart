import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_set/ui/bloc/blocs.dart';
import 'package:street_set/ui/db/set_db.dart';
import 'package:street_set/ui/db/set_repository.dart';
import './ui/app.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final TeamRepository teamRepository = TeamRepository(setDao: SetDao(SetDatabase()));
  runApp(App(teamRepository: teamRepository));
}