import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soccerstreams/helpers/displaySize.dart';
import 'package:soccerstreams/helpers/webscrapper.dart';
import 'package:soccerstreams/screens/EventPage.dart';
import 'package:soccerstreams/screens/testPage.dart';
import 'package:soccerstreams/state/homeData.dart';
import 'package:flutter/services.dart';

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

  Widget build(BuildContext context, ScopedReader watch) {
    final dataController = watch(soccerDataProvider);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: displayWidth(context) * 0.8,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ))),
        autofocus: true,
        onPressed: () async {
          // dataController.loadEvent(id);
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => (EventPage())));

          var scrape = new Scraper();
          // var src =
          //     await scrape.getIframe("https://wigistream.to/embed/bp346kr7byj");

          var src = "https://wigistream.to/embed/bp346kr7byj";

          SystemChrome.setEnabledSystemUIOverlays([]);
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight
          ]).then((_) => Navigator.push(context,
              MaterialPageRoute(builder: (context) => (TestPage(src: src)))));
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
              children: [Text('$hScore  –  $vScore'), Text('$minute\'')],
            ),
          ),
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
