import 'package:flutter/material.dart';
import 'package:soccerstreams/components/event.dart';

class Competition extends StatelessWidget {
  String name;
  String logo;
  int popular;
  String country;
  List events = [];

  Competition({
    this.name,
    this.logo,
    this.popular,
    this.country,
    this.events,
  });

  Competition.fromMap(Map data) {
    this.name = data['name'];
    this.logo = data['logo'];
    this.popular = data['popular'];
    this.country = data['country']['name'];
    this.events = data['events'];
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(80, 20, 80, 20),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(width: 50, child: Image(image: NetworkImage(logo))),
                Text(name),
              ],
            ),
            for (var e in events) Event.fromMap(e)
          ],
        ),
      ),
    );
  }
}
