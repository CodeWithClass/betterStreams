import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soccerstreams/helpers/displaySize.dart';
import 'package:intl/intl.dart';

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
  var statusName;

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

    this.statusName = data['statusDescription'];
    this.startTimestamp = data['startTimestamp'];
    this.status = data['status']["type"];

    // this.statusName = data['statusDescription'];
    // this.hasStreams = data['hasStreams'];
    // this.hasHighlights = data['hasHighlights'];
  }

  Widget build(BuildContext context, ScopedReader watch) {
    final startDate =
        new DateTime.fromMillisecondsSinceEpoch(this.startTimestamp * 1000);
    final DateFormat timeFormatter = DateFormat('h:ss a');
    final String startTime = timeFormatter.format(startDate);

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
              children: [
                if (statusName == "NS")
                  Column(
                    children: [
                      Text('Match starts at'),
                      Text('$startTime'),
                    ],
                  )
                else if (statusName == "POSTP")
                  Text('$status')
                else
                  Column(children: [
                    Text('$statusName'),
                    Text('$hScore  –  $vScore')
                  ])
              ],
            )),
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
