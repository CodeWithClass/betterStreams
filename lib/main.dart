import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soccerstreams/screens/Home.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soccer Streams',
      theme: ThemeData(
          brightness: Brightness.dark,
          // primarySwatch: Colors.pink,
          textTheme: TextTheme(
              headline1: TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.normal,
          ))),
      home: MyHomePage(title: 'SoccerStreams'),
    );
  }
}
