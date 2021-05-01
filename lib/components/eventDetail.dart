import 'package:betterstreams/components/links.dart';
import 'package:betterstreams/components/youtubeButton.dart';
import 'package:betterstreams/state/soccerData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:betterstreams/helpers/displaySize.dart';
import 'package:betterstreams/helpers/time.dart';

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
  }

  Widget build(BuildContext context, ScopedReader watch) {
    final String startTime = startTimeFormater(this.startTimestamp);
    List<Link> links = watch(soccerDataProvider).eventLinks;
    final searchQ = '$hName+$vName';
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: displayWidth(context) * 0.6,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        )
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
          if (statusName == 'NS' && links.length < 1)
            Container(
              height: displayHeight(context) * .3,
              child: Center(
                child: Text(
                  'Links are posted ~30 mins before match start.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          else if (statusName == 'FT')
            Container(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Match has ended. View highlights on ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 5,
                      children: [hlfButton(searchQ), shButton(searchQ)],
                    )
                  ],
                ),
              ),
            )
          else if (links.length < 1)
            Container(
              height: displayHeight(context) * .3,
              child: Center(
                child: Text(
                  'This match doesn\'t seem to have any links.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
        ],
      ),
    );
  }
}
