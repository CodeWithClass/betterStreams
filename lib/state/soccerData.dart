import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:betterstreams/components/competition.dart';
import 'package:betterstreams/components/eventDetail.dart';
import 'package:betterstreams/components/links.dart';
import 'package:betterstreams/helpers/serverResponse.dart';
import 'package:betterstreams/services/getData.dart';

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
  int _day;
  int get day => _day;

  void _init() async {
    _day = 0;
    load();
  }

  void load() async {
    _isLoading = true;
    notifyListeners();
    var res = await getAllMatches(this._day);
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
    _isLoading = false;
    notifyListeners();
  }

  void setHomeData(val) {
    this._homeData = [];
    this.rawData = [];
    rawData.addAll(jsonDecode(val));
    rawData.forEach((e) => {
          if (e != null && e["popular"] == 1)
            {this._homeData.add(Competition.fromMap(e))}
        });
  }

  void setEventData(val) {
    _eventData = EventDetail.fromMap(jsonDecode(val)["event"]);
    notifyListeners();
  }

  void setEventLinksData(data) {
    final links = data['links'];
    final names = data['names'];
    final langs = data['langs'];
    final quals = data['quals'];
    final bits = data['bits'];
    final chan = data['chan'];

    if (links.length < 1) return;

    for (var i = 0; i < links.length; i++) {
      _eventLinks.add(Link(
        id: i,
        url: links[i],
        name: i < names.length ? names[i] : '',
        quality: i < quals.length ? quals[i] : 'SD',
        language: i < langs.length ? langs[i] : '',
        bitrate: i < bits.length ? bits[i] : '',
        channel: i < chan.length ? chan[i] : '',
      ));
    }

    if (_eventLinks.length > 0) _eventLinks.removeAt(0);
    notifyListeners();
  }

//Scraping
  // ignore: non_constant_identifier_names
  void setEventLinksData_(linksList) {
    var i = 0;
    for (var l in linksList) {
      _eventLinks.add(Link(
        id: i,
        url: l,
      ));
      i++;
    }
    if (_eventLinks.length > 0) _eventLinks.removeAt(0);
    notifyListeners();
  }

  void changeDay(day) {
    this._day = day;
    load();
  }
}
