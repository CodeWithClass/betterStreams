import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soccerstreams/state/master.dart';

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final soccerData = watch(soccerDataProvider);

    return Scaffold(
      body: ListView(
        children: [
          Text("SoccerStreams", style: Theme.of(context).textTheme.headline3),
          if (soccerData.homeData != [])
            for (var i in soccerData.homeData) i
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          soccerData.load();
        },
        child: Icon(
          Icons.play_arrow,
        ),
      ),
    );
  }
}
