import 'package:betterstreams/components/backbutton.dart';
import 'package:betterstreams/components/mainLogo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:betterstreams/components/eventDetail.dart';
import 'package:betterstreams/components/links.dart';
import 'package:betterstreams/helpers/displaySize.dart';
import 'package:betterstreams/state/soccerData.dart';

class EventPage extends ConsumerWidget {
  // int id;
  EventPage();
  Widget build(BuildContext context, ScopedReader watch) {
    // final dataController = watch(soccerDataProvider);

    EventDetail eventData = watch(soccerDataProvider).eventData;
    List<Link> links = watch(soccerDataProvider).eventLinks;
    bool isLoading = watch(soccerDataProvider).isLoading;
    // print(links);
    // print(eventData.toString());
    // print(eventData.statusName);

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
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
                  backbutton(context: context),
                  if (eventData != null)
                    eventData
                  else
                    Container(
                      height: displayHeight(context) * .9,
                      child: Center(
                        child: Text('Sorry no event data'),
                      ),
                    ),
                  if (links.length > 0)
                    for (var l in links) l
                ],
              ),
      ),
    );
  }
}
