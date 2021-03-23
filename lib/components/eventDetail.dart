import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soccerstreams/helpers/displaySize.dart';

// ignore: must_be_immutable
class EventDetail extends ConsumerWidget {
  int id;
  int hScore;
  int vScore;
  String hName;
  String vName;
  String hLogo;
  String vLogo;
  int startTimestamp;
  String status;

  // String statusName;
  // bool hasStreams;
  // bool hasHighlights;

  EventDetail.fromMap(Map data) {
    this.id = data['id'];
    this.hScore = data['homeScore']["current"];
    this.vScore = data['awayScore']["current"];
    this.hName = data['homeTeam']['name'];
    this.hLogo = data['homeTeam']['logo'];

    this.vName = data['awayTeam']['name'];
    this.vLogo = data['awayTeam']['logo'];

    this.startTimestamp = data['startTimestamp'];
    this.status = data['status']["type"];

    // this.statusName = data['statusDescription'];
    // this.hasStreams = data['hasStreams'];
    // this.hasHighlights = data['hasHighlights'];
  }

  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: displayWidth(context) * 0.6,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: displayWidth(context) * 0.2,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              Container(
                  width: displayWidth(context) * 0.1,
                  margin: EdgeInsets.all(10),
                  child: Image.network(hLogo)),
              Text(hName, textAlign: TextAlign.center),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [Text('$hScore  –  $vScore'), Text('$startTimestamp\'')],
          ),
        ),
        Container(
          width: displayWidth(context) * 0.2,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              Container(
                  width: displayWidth(context) * 0.1,
                  margin: EdgeInsets.all(10),
                  child: Image.network(vLogo)),
              Text(vName, textAlign: TextAlign.center),
            ],
          ),
        ),
      ]),
    );
  }
}
