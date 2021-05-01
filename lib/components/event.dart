import 'package:betterstreams/helpers/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:betterstreams/helpers/displaySize.dart';
import 'package:betterstreams/screens/EventPage.dart';
import 'package:betterstreams/state/soccerData.dart';

// ignore: must_be_immutable
class Event extends ConsumerWidget {
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
  int startTimestamp;

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
    this.startTimestamp = data['startTimestamp'];
  }

  Widget build(BuildContext context, ScopedReader watch) {
    final dataController = watch(soccerDataProvider);
    final String startTime = startTimeFormater(this.startTimestamp);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: displayWidth(context) * 0.8,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[900]),
            // backgroundColor: Colors.grey[600],
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ))),
        // autofocus: true,
        onPressed: () async {
          dataController.loadEvent(id);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => (EventPage())));
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: displayWidth(context) * 0.2,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              hName,
              textAlign: TextAlign.right,
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  if (statusName == "NS")
                    Text('$startTime')
                  else if (statusName == "POSTP")
                    Text('$status')
                  else
                    Column(children: [
                      statusName == 'FT'
                          ? Text(
                              '$statusName',
                              style: TextStyle(color: Colors.red[800]),
                            )
                          : Text(
                              '$statusName\'',
                              style: TextStyle(color: Colors.yellow[800]),
                            ),
                      Text(
                        '$hScore  –  $vScore',
                        style:
                            TextStyle(color: Colors.yellow[600], fontSize: 16),
                      )
                    ])
                ],
              )),
          Container(
            width: displayWidth(context) * 0.2,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              vName,
              textAlign: TextAlign.left,
            ),
          ),
        ]),
      ),
    );
  }
}
