import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_set/ui/bloc/team/team.dart';
import 'package:street_set/ui/bloc/team/team_bloc.dart';
import 'package:street_set/ui/db/set_db.dart';
import 'package:street_set/ui/db/set_repository.dart';
import 'package:street_set/ui/teams.dart';
import '../ui/helper/alert_dialog.dart';
import 'bloc/team/team_state.dart';

class Home extends StatelessWidget {
  final TeamRepository teamRepository;
  int sets;
  List<TeamData> set;
  TextEditingController value1 = TextEditingController() ;
  TextEditingController value2 = TextEditingController();

  Home({Key key, @required this.teamRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Alert(title: 'Enter set', hint: 'Enter no', alertActionTitles: 'Submit', actionMethod: 1).show(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Set!'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                  ),
                  color: Colors.orange,
                  onLongPress: () => Alert(title: 'Are you sure both teams lost', alertActionTitles: 'Yes', actionMethod: 4, values: [value1.value.text, value2.value.text]).show(context),
                  onPressed: () {
                       Alert(title: 'Are you sure this team lost', alertActionTitles: 'Yes', alertAction: (int index) {
                        }, actionMethod: 3, values: [value1.value.text]).show(context);
                  },
                  child: BlocBuilder<TeamBloc, TeamState>(
                    builder: (context, state) {
                      if (state is TeamInitial) {
                        return Text('Enter Set');
                      }
                      if (state is TeamSuccess) {
                        set = state.teamData;
                        print('set is ${ set.toString() }');
                        return Text(set.length > 0 ? 'Set ${
                            value1.text = set[0].set.toString()
                        }' : 'Enter set');
                      }
                      return Text('');
                    },
                  ),
                ),
              ),

              SizedBox(
                width: 10,
              ),

              Text('vs'),

              SizedBox(
                width: 10,
              ),

              Container(
                height: 120,
                width: 120,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                  ),
                  color: Colors.orange,
                  onLongPress: () => Alert(title: 'Are you sure both teams lost', alertActionTitles: 'Yes', actionMethod: 4, values: [value1.value.text, value2.value.text]).show(context),
                  onPressed: () => Alert(title: 'Are you sure this team lost', alertActionTitles: 'Yes', alertAction: (int v) {

                  }, actionMethod: 3, values: [value2.value.text]).show(context),
                  child: BlocBuilder<TeamBloc, TeamState>(
                    builder: (context, state) {
                      if (state is TeamInitial) {
                        return Text('Enter Set');
                      }
                      if (state is TeamSuccess) {
                        set = state.teamData;
                        print('set is ${ set.toString() }');
                        return Text(set.length > 1 ? 'Set ${
                            //sets = set[1].set
                            value2.text = set[1].set.toString()
                        }' : 'Enter Set');
                      }
                      return Text('');
                    },
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 115,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))
                    ),
                    color: Colors.transparent,
                    textColor: Theme.of(context).primaryColor,
                    child: Text('View Tree'),
                    onPressed: () {
                      _moveToAllSets(context);
                    }
                )
              ),

              SizedBox(
                width: 10,
              ),

              Container(
                height: 80,
                width: 115,
                child:  RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                  ),
                  color: Colors.transparent,
                  child: Text('Enter Time'),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () => Alert(title: 'Enter time', hint: 'Minutes', alertActionTitles: 'Start', actionMethod: 5).show(context),
                )
              ),

            ],
          ),

          SizedBox(
            height: 10,
          ),

          Container(
              height: 80,
              width: 115,
              child:  RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                ),
                color: Colors.transparent,
                child: Text('Start All Over'),
                textColor: Theme.of(context).primaryColor,
                onPressed: () => Alert(title: 'Are you sure you want to start a new game', alertActionTitles: 'yes', actionMethod: 5).show(context),
              )
          ),
        ],
      )
    );
  }

  void _moveToAllSets(BuildContext context) {
    var route = MaterialPageRoute(builder: (context) => Teams(teams: set,));
    Navigator.push(context, route);
  }


}
