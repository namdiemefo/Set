import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_set/ui/bloc/blocs.dart';
import 'package:street_set/ui/db/set_repository.dart';
import 'package:street_set/ui/home.dart';

class App extends StatelessWidget {
  final TeamRepository teamRepository;

  App({Key key, this.teamRepository}) :  super(key: key) ;

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.deepOrange[400],
          fontFamily: "LibreBaskerville"
      ),
      title: 'Set',
      home: BlocProvider(
        create: (context) => TeamBloc(teamRepository: teamRepository),
        child: Home(),
      ),
    );
  }
}