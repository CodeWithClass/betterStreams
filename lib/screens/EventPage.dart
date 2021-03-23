import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soccerstreams/components/eventDetail.dart';
import 'package:soccerstreams/components/links.dart';
import 'package:soccerstreams/helpers/displaySize.dart';
import 'package:soccerstreams/state/homeData.dart';

class EventPage extends ConsumerWidget {
  // int id;
  EventPage();
  Widget build(BuildContext context, ScopedReader watch) {
    // final dataController = watch(soccerDataProvider);

    EventDetail eventData = watch(soccerDataProvider).eventData;
    List<Link> links = watch(soccerDataProvider).eventLinks;
    bool isLoading = watch(soccerDataProvider).isLoading;
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
                      child: Text("BetterStreams",
                          style: Theme.of(context).textTheme.headline5),
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
                  for (var l in links) l
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
    );
  }
}
