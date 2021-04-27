import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:betterstreams/components/event.dart';
import 'package:betterstreams/services/getData.dart';

final soccerEventDataProvider =
    ChangeNotifierProvider((ref) => MainDataNotifier());

class MainDataNotifier extends ChangeNotifier {
  final id;
  MainDataNotifier({this.id}) {
    _init();
  }
  Event _eventData;

  Event get eventData => _eventData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _init() async {}

  void load(int id) async {
    _isLoading = true;
    notifyListeners();
    var eventRes = await getEvent(id);
    if (eventRes.status) setEventData(eventRes.data);
    await getEventLinks(id);
    // if (linksRes.status) setEventData(linksRes.data);

    if (eventRes.status != null) _isLoading = false;
    notifyListeners();
  }

  void setEventData(val) {
    // rawData.add(jsonDecode(val));

    _eventData = Event.fromMap(jsonDecode(val)["event"]);
    notifyListeners();
  }
}
