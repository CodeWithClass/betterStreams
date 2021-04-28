import 'package:flutter/material.dart';
import 'package:betterstreams/components/event.dart';
import 'package:betterstreams/helpers/displaySize.dart';

// ignore: must_be_immutable
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
      margin: EdgeInsets.fromLTRB(
          displayWidth(context) * 0.1, 20, displayWidth(context) * 0.1, 20),
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
                Container(
                  width: 50,
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: Image(image: NetworkImage(logo)),
                ),
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
