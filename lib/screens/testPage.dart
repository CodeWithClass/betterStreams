import 'dart:io';
import 'package:flutter/material.dart';
import 'package:betterstreams/helpers/displaySize.dart';
import 'package:flutter/services.dart';

class TestPage extends StatefulWidget {
  final src;
  TestPage({this.src});

  @override
  TestPageState createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  String src;
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.

    this.src = widget.src;
  }

  @override
  Widget build(BuildContext context) {
    double fWidth = displayWidth(context) * .995;
    double fheight = displayHeight(context) * .995;

    if (fheight > fWidth) {
      var temp = fWidth;
      fWidth = fheight;
      fheight = temp;
    }

    return Container();
  }
}
