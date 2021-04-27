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
                      TextButton(
                        onPressed: () {},
                        // child: Text("BetterStreams",
                        //     style: Theme.of(context).textTheme.headline5),
                      ),
                    ],
                  ),
                  if (eventData != null)
                    eventData
                  else
                    Container(
                      height: displayHeight(context) * .9,
                      child: Center(
                        child: Text('Sorry no event data'),
                      ),
                    ),
                  if (links != [])
                    for (var l in links)
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: l)
                  else
                    Container(
                      height: displayHeight(context) * .9,
                      child: Center(
                        child: Text('Sorry no link right now'),
                      ),
                    ),
                ],
              ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     soccerData.load();
        //   },
        //   child: Icon(
        //     Icons.play_arrow,
        //   ),
        // ),
      ),
    );
  }
}
