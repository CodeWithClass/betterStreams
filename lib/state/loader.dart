import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soccerstreams/components/competition.dart';
import 'package:soccerstreams/services/getData.dart';

final loadingProvider =
    ChangeNotifierProvider((ref) => LoadingChangeNotifier());

class LoadingChangeNotifier extends ChangeNotifier {
  bool show = true;
  bool get isLoading => show;

  LoadingChangeNotifier() {
    // _init(1000);
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
