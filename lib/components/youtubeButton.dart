import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

Widget hlfButton(searchQ) {
  final _url = 'https://highlightsfootball.net/?s=$searchQ';
  final url = _url.replaceAll(' ', '+');

  return Container(
    margin: EdgeInsets.all(10),
    child: OutlinedButton(
      onPressed: () => html.window.open(url, ''),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('highlightsfootball'),
      ),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        side: BorderSide(width: 1, color: Colors.pink),
      ),
    ),
  );
}

Widget shButton(searchQ) {
  final _url = 'https://soccerhighlights.net/?s=$searchQ';
  final url = _url.replaceAll(' ', '+');

  return Container(
    margin: EdgeInsets.all(10),
    child: OutlinedButton(
      onPressed: () => html.window.open(url, ''),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('soccerhighlights'),
      ),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        side: BorderSide(width: 1, color: Colors.pink),
      ),
    ),
  );
}
