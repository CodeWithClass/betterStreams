import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soccerstreams/components/competition.dart';
import 'package:soccerstreams/components/eventDetail.dart';
import 'package:soccerstreams/components/links.dart';
import 'package:soccerstreams/helpers/serverResponse.dart';
import 'package:soccerstreams/services/getData.dart';

final soccerDataProvider = ChangeNotifierProvider((ref) => MainDataNotifier());

class MainDataNotifier extends ChangeNotifier {
  MainDataNotifier() {
    _init();
  }
  List rawData = [];
  List<Competition> _homeData = [];
  EventDetail _eventData;
  List<Link> _eventLinks = [];

  List<Competition> get homeData => _homeData;
  EventDetail get eventData => _eventData;
  List<Link> get eventLinks => _eventLinks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _init() async {
    _isLoading = true;
    var res = await getAllMatches();
    if (res.status) setHomeData(res.data);
    if (res.status != null) _isLoading = false;
  }

  void load() async {
    _isLoading = true;
    notifyListeners();
    var res = await getAllMatches();
    if (res.status) setHomeData(res.data);
    if (res.status != null) _isLoading = false;
    notifyListeners();
  }

  void loadEvent(int id) async {
    _isLoading = true;
    notifyListeners();
    ServerResponse eventRes = await getEvent(id);
    if (eventRes.status) setEventData(eventRes.data);

    ServerResponse eventLinkRes = await getEventLinks(id);
    if (eventLinkRes.status) setEventLinksData(eventLinkRes.data);
    // print('============== res status========' + eventRes.status.toString());
    if (eventRes.status != null) _isLoading = false;
    notifyListeners();
  }

  void setHomeData(val) {
    rawData.addAll(jsonDecode(val));
    rawData.forEach((e) => {
          if (e != null && e["popular"] == 1)
            {this._homeData.add(Competition.fromMap(e))}
        });
    notifyListeners();
  }

  void setEventData(val) {
    print(jsonDecode(val));
    _eventData = EventDetail.fromMap(jsonDecode(val)["event"]);
    notifyListeners();
  }

  void setEventLinksData(linksList) {
    var i = 1;
    for (var l in linksList) {
      _eventLinks.add(Link(
        id: i,
        url: l,
      ));
      i++;
    }
    notifyListeners();
  }
}
