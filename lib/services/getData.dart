// import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:betterstreams/helpers/serverResponse.dart';
import 'package:intl/intl.dart';
import 'package:betterstreams/helpers/webscrapper.dart';
import 'package:html/parser.dart' show parse;

// final url = "https://sportscentral.io";
final date = new DateFormat('yyyy-MM-dd');

Future<ServerResponse> getAllMatches(day) async {
  final now = DateTime.now();
  var dateString = date.format(DateTime(now.year, now.month, now.day + day));

  final Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  const endpoint = '/new-api/matches';
  final qParams = {
    'date': dateString,
    'timeZone': '240',
  };

  final Uri uri = Uri.https('sportscentral.io', '$endpoint', qParams);

  try {
    final response = await http.get(uri, headers: requestHeaders);
    // print(response.body.toString());
    if (response.statusCode == 200)
      return ServerResponse(data: response.body, msg: "success", status: true);
    return ServerResponse(data: response.body, msg: "failure", status: false);
  } catch (e) {
    return ServerResponse(data: e, msg: "error", status: false);
  }
}

Future<ServerResponse> getEvent(int id) async {
  var dateString = date.format(DateTime.now());
  final Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  final endpoint = '/api/v2/soccer/soccerstreams/fixture/${id.toString()}';
  final qParams = {
    'date': dateString,
    'timeZone': '',
  };

  final Uri uri = Uri.https('sportscentral.io', '$endpoint', qParams);

  try {
    final response = await http.get(uri, headers: requestHeaders);
    // print(response.body.toString());
    if (response.statusCode == 200)
      return ServerResponse(data: response.body, msg: "success", status: true);
    return ServerResponse(data: response.body, msg: "failure", status: false);
  } catch (e) {
    return ServerResponse(data: e, msg: "error", status: false);
  }
}

Future<ServerResponse> getEventLinks(int id) async {
  try {
    final response = await http.Client().get(Uri.parse(
        'https://sportscentral.io/streams-table/$id/soccer?new-ui=0&mobile=1&origin=reddt1.soccerstreams.net'));
    if (response.statusCode == 200) {
      final document = parse(response.body);
      final streamLinks = document
          .getElementsByClassName('stream-info')
          .where((e) => e.attributes.containsKey('href'))
          .map((e) => e.attributes['href'])
          .toList();

      final streamNames =
          document.getElementsByClassName('first').map((e) => e.text).toList();

      final streamLangs = document
          .getElementsByClassName('language')
          .map((e) => e.text)
          .toList();
      final streamQuals = document
          .getElementsByClassName('misr-HD')
          .map((e) => e.text)
          .toList();
      final streamBits = document
          .getElementsByClassName('label-bitrate')
          .map((e) => e.text)
          .toList();
      final streamChans = document
          .getElementsByClassName('label-channel-name')
          .map((e) => e.text)
          .toList();

      if (streamLinks.length == 0)
        return ServerResponse(
            data: {
              'links': [],
              'names': [],
              'langs': [],
              'quals': [],
              'bits': [],
              'chan': []
            },
            msg:
                "No links available, links are posted ~30 mins before match start",
            status: true);

      return ServerResponse(data: {
        'links': streamLinks,
        'names': streamNames,
        'langs': streamLangs,
        'quals': streamQuals,
        'bits': streamBits,
        'chan': streamChans,
      }, msg: "success", status: true);
    }
    return ServerResponse(data: [], msg: "Failed to get links", status: false);
  } catch (e) {
    return ServerResponse(data: e, msg: "error", status: false);
  }
}

//scraping
// ignore: non_constant_identifier_names
Future<ServerResponse> getEventLinks_(int id) async {
  final scrape = new Scraper();
  var elements = await scrape.load(id);

  if (elements != [])
    return ServerResponse(data: elements, msg: 'success', status: true);
  return ServerResponse(data: elements, msg: 'failure', status: false);
}
