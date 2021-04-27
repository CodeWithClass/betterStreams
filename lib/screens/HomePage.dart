import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:betterstreams/components/refreshbutton.dart';
import 'package:betterstreams/helpers/displaySize.dart';
import 'package:betterstreams/state/soccerData.dart';

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final soccerData = watch(soccerDataProvider);
    final isLoading = watch(soccerDataProvider).isLoading;
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                  // semanticsLabel: 'Fetching matches',
                  ),
            )
          : ListView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      // child: Text("BetterStreams",
                      //     style: Theme.of(context).textTheme.headline5),
                    ),
                  ],
                ),
                refreshButton(onpressed: soccerData.load),
                if (soccerData.homeData != [])
                  for (var i in soccerData.homeData) i
                else
                  Container(
                    height: displayHeight(context) * .9,
                    child: Center(
                      child: Text('Sorry no streams right now'),
                    ),
                  )
              ],
            ),
    );
  }
}
