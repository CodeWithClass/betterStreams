import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soccerstreams/components/competition.dart';
import 'package:soccerstreams/services/getData.dart';

final soccerDataProvider = ChangeNotifierProvider((ref) => MainDataNotifier());

class MainDataNotifier extends ChangeNotifier {
  MainDataNotifier() {
    _init();
  }
  List rawData = [];
  List<Competition> _homeData = [];
  List<Competition> get homeData => _homeData;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _init() async {
    _isLoading = true;
    var res = await getAllMatches();
    if (res.status) setData(res.data);
    if (res.status != null) _isLoading = false;
  }

  void load() async {
    _isLoading = true;
    var res = await getAllMatches();
    if (res.status) setData(res.data);
    if (res.status != null) _isLoading = false;
  }

  void setData(val) {
    rawData.addAll(jsonDecode(val));
    var i = 1;
    rawData.forEach((e) => {
          if (e != null && e["popular"] == 1)
            {this._homeData.add(Competition.fromMap(e))}
        });
    notifyListeners();
  }
}
