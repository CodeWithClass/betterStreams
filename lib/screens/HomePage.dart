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

  calcOffset(context, buttons) {
    final numBtns = buttons.length;
    final btnsWidth = 130 * numBtns;
    if (displayWidth(context) > btnsWidth) {
      return 0;
    }
    return (btnsWidth - displayWidth(context)) / 2;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final buttons = [
      {'text': 'Day Before', 'val': -2},
      {'text': 'Yesterday', 'val': -1},
      {'text': 'Today', 'val': 0},
      {'text': 'Tomorrow', 'val': 1},
      {'text': 'Day After', 'val': 2}
    ];
    final soccerData = watch(soccerDataProvider);
    final isLoading = watch(soccerDataProvider).isLoading;
    final day = watch(soccerDataProvider).day;
    final sc =
        ScrollController(initialScrollOffset: calcOffset(context, buttons));
    return Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                    // semanticsLabel: 'Fetching matches',

                    ),
              )
            : Column(
                children: [
                  if (soccerData.homeData != [])
                    Expanded(
                      child: Container(
                        // height: displayHeight(context),
                        child: ListView.builder(
                          itemCount: soccerData.homeData.length,
                          itemBuilder: (context, index) {
                            if (index == 0)
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextButton(
                                          onPressed: () {}, child: mainLogo()),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('v1.4.0'),
                                      )
                                    ],
                                  ),
                                  refreshButton(onpressed: soccerData.load),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                  ),
                                  Container(
                                    width: displayWidth(context),
                                    height: 60,
                                    child: Center(
                                      child: SingleChildScrollView(
                                          controller: sc,
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              for (var i = 0;
                                                  i < buttons.length;
                                                  i++)
                                                dayButton(
                                                  onPressed: () => context
                                                      .read(soccerDataProvider)
                                                      .changeDay(
                                                          buttons[i]['val']),
                                                  text: buttons[i]['text'],
                                                  selected:
                                                      buttons[i]['val'] == day,
                                                ),
                                            ],
                                          )),
                                    ),
                                  ),
                                  soccerData.homeData[index]
                                ],
                              );
                            return soccerData.homeData[index];
                          },
                        ),
                      ),
                    )
                  else
                    Container(
                      height: displayHeight(context) * .9,
                      child: Center(
                        child: Text('Sorry no streams right now'),
                      ),
                    )
                ],
              ));
  }
}
