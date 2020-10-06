import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_set/ui/bloc/blocs.dart';
import 'package:street_set/ui/db/set_db.dart';
import 'package:street_set/ui/widgets/count_down.dart';

typedef AlertAction<T> = void Function(T index);

class Alert {

  String title;
  String hint;
  String alertActionTitles;
  AlertAction<int> alertAction;
  int actionMethod;
  List<String> values;

  TextEditingController value = TextEditingController();
  TextEditingController value1 = TextEditingController();
  Alert({this.title, this.hint, this.alertActionTitles, this.alertAction, this.actionMethod, this.values});

  void show(BuildContext context) {
    List<Widget> actions = <Widget>[];
    Widget actionButton = RaisedButton(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1,
              style: BorderStyle.solid
          )
      ),
      onPressed: () {
        if (actionMethod == 1) {
          _submitSet(context);
        } else if (actionMethod == 2) {
          _submitTime(context);
        } else if (actionMethod == 3) {
          if (values.isNotEmpty) {
            print('values is ${values.first}');
            _removeOne(context, values.first);
          }

        } else if (actionMethod == 4) {
          _removeTwo(context, values);
        } else if (actionMethod == 5) {
          _deleteAll(context);
        }
      },
      child: Text(alertActionTitles),
    );
    actions.add(actionButton);
    showDialog(context: context, barrierDismissible: true, builder: (BuildContext context) {
      return _getAlertDialog(actions, actionMethod);
    });
  }

  Widget _getAlertDialog(List<Widget> actions, int actionMethod) {
    if (actionMethod == 7) {
      if (Platform.isIOS) {
        return CupertinoAlertDialog(
          title: Text(title),
        );
      } else {
        return AlertDialog(
          title: Text(title),
        );
      }
    }
    if (actionMethod == 3 || actionMethod == 4 || actionMethod == 5) {
      if (Platform.isIOS) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text('${ value1.value.text }'),
          actions: actions,
          );
        } else {
        return AlertDialog(
         title: Text(title),
          actions: actions,
        );
      }
    }
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: TextField(
          controller: value,
          decoration: InputDecoration(hintText: hint),
          keyboardType: TextInputType.number,
        ),
        actions: actions,
      );
    } else {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: value,
          decoration: InputDecoration(hintText: hint),
          keyboardType: TextInputType.number,
        ),
        actions: actions,
      );
    }
  }
  

  void _submitSet(BuildContext context) {
    var team = int.parse(value.text);
    var teamData = TeamData(set: team, date: DateTime.now());
    BlocProvider.of<TeamBloc>(context).add(AddTeamEvent(team: teamData));
    Navigator.pop(context);
  }

  void _submitTime(BuildContext context) {
    var route = MaterialPageRoute(builder: (context) => CountDown(time: int.parse(value.text)));
    Navigator.push(context, route);
  }

  void _removeOne(BuildContext context, String text) {
    print('enter one');
    var team = int.parse(text);
    var teams = TeamData(set: team);
    BlocProvider.of<TeamBloc>(context).add(TeamLossEvent(teams));
    Navigator.pop(context);
  }

  void _removeTwo(BuildContext context, List<String> values) {
    print('${values.toString()}');
    List<int> setNo = List<int>();
    List<TeamData> teams = List<TeamData>();

    for (var i = 0; i < values.length; i++) {
      setNo.add(int.parse(values[i]));
      var team = TeamData(set: setNo[i], date: DateTime.now());
      teams.add(team);
    }
    BlocProvider.of<TeamBloc>(context).add(BothTeamOutEvent(teams));
    Navigator.pop(context);
  }

  void _deleteAll(BuildContext context) {
    BlocProvider.of<TeamBloc>(context).add(ClearAllEvent());
    Navigator.pop(context);
  }

}