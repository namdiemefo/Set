import 'package:flutter/material.dart';
import 'package:street_set/ui/db/set_db.dart';

class Teams extends StatelessWidget {

  final List<TeamData> teams;

  const Teams({Key key, this.teams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('teams is ${teams.toString()}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Sets'),
      ),
      body: ListView.builder(

        itemCount: teams == null ? 1 : teams.length,
          itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text('${ teams != null ? teams[index].set : 'No sets available' }'),
            ),
          );
          }),

    );
  }
}
