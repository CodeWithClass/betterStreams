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

  void _init() async {
    var res = await getAllMatches();
    if (res.status) setData(res.data);
  }

  void load() async {
    var res = await getAllMatches();
    if (res.status) setData(res.data);
  }

  void setData(val) {
    rawData.addAll(jsonDecode(val));
    rawData.forEach((e) => {
          if (e != null && e["popular"] == 1)
            {
              // print('each compi: ' + e.toString()),
              this._homeData.add(Competition.fromMap(e))
            }
        });
    notifyListeners();
  }
}

class LoadingChangeNotifier extends ChangeNotifier {
  bool show = true;
  bool get isLoading => show;

  LoadingChangeNotifier() {
    _init(1000);
  }

  void _init(time) {
    this.showLoader();

    Future.delayed(Duration(milliseconds: time))
        .then((onValue) => this.hideLoader());
  }

  void showLoader() {
    this.show = true;
    notifyListeners();
  }

  void hideLoader() {
    this.show = false;
    notifyListeners();
  }
}
