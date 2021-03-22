import 'package:flutter/material.dart';
import 'package:soccerstreams/helpers/displaySize.dart';

// ignore: must_be_immutable
class Event extends StatefulWidget {
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
  FocusNode focusNode = new FocusNode();

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
  @override
  _Event createState() => _Event();
}

class _Event extends State<Event> {
  bool _focused = false;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
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
        // focusNode: widget.focusNode,
        onPressed: () {},
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: displayWidth(context) * 0.2,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              widget.hName,
              textAlign: TextAlign.right,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text('${widget.hScore}  –  ${widget.vScore}'),
                Text('${widget.minute}\'')
              ],
            ),
          ),
          Container(
            width: displayWidth(context) * 0.2,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.vName,
              textAlign: TextAlign.left,
            ),
          ),
        ]),
      ),
    );
  }
}
