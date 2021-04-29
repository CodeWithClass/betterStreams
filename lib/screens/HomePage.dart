import 'package:betterstreams/components/dayButton.dart';
import 'package:betterstreams/components/mainLogo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:betterstreams/components/refreshbutton.dart';
import 'package:betterstreams/helpers/displaySize.dart';
import 'package:betterstreams/state/soccerData.dart';

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  dayBtnAction(context, val) {
    context.read(soccerDataProvider).changeDay(val);
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final buttons = [
      {'text': 'Yesterday', 'val': -1},
      {'text': 'Today', 'val': 0},
      {'text': 'Tomorrow', 'val': 1}
    ];
    final soccerData = watch(soccerDataProvider);
    final isLoading = watch(soccerDataProvider).isLoading;
    final day = watch(soccerDataProvider).day;
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
                    TextButton(onPressed: () {}, child: mainLogo()),
                  ],
                ),
                refreshButton(onpressed: soccerData.load),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < 3; i++)
                      dayButton(
                        onPressed: () => context
                            .read(soccerDataProvider)
                            .changeDay(buttons[i]['val']),
                        text: buttons[i]['text'],
                        selected: buttons[i]['val'] == day,
                      ),
                  ],
                ),
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
