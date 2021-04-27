import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:betterstreams/helpers/displaySize.dart';
import 'package:betterstreams/helpers/webscrapper.dart';
import 'package:betterstreams/screens/testPage.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

// ignore: must_be_immutable
class Link extends ConsumerWidget {
  int id;
  String url;

  Link({this.id, this.url});

  Widget build(BuildContext context, ScopedReader watch) {
    // final dataController = watch(soccerDataProvider);
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ))),
        autofocus: true,
        onPressed: () {
          html.window.open(url, 'new tab');
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: displayWidth(context) * 0.2,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Link $id',
              textAlign: TextAlign.right,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
          ),
          Container(
            width: displayWidth(context) * 0.6,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              url,
              textAlign: TextAlign.left,
            ),
          ),
        ]),
      ),
    );
  }
}
