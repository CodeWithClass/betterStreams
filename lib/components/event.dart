import 'package:flutter/material.dart';
import 'package:soccerstreams/helpers/displaySize.dart';

// ignore: must_be_immutable
class Event extends StatelessWidget {
  int id;
  int hScore;
  int vScore;
  String hName;
  String vName;
  int minute;
  String status;
  String statusName;
  bool hasStreams;
  bool hasHighlights;

  Event.fromMap(Map data) {
    this.id = data['id'];
    this.hScore = data['hScore'];
    this.vScore = data['vScore'];
    this.hName = data['homeTeam']['name'];
    this.vName = data['awayTeam']['name'];
    this.minute = data['minute'];
    this.status = data['status']["type"];
    this.statusName = data['statusDescription'];
    this.hasStreams = data['hasStreams'];
    this.hasHighlights = data['hasHighlights'];
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.black54),
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(20),
      width: displayWidth(context) * 0.8,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(hName),
        ),
        Column(
          children: [Text('$hScore  –  $vScore'), Text('$minute\'')],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(vName),
        ),
      ]),
    );
  }
}
