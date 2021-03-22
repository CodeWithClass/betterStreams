// import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soccerstreams/helpers/serverResponse.dart';
import 'package:intl/intl.dart';
import 'package:soccerstreams/helpers/webscrapper.dart';

// final url = "https://sportscentral.io";
final date = new DateFormat('yyyy-MM-dd');
var dateString = date.format(DateTime.now());

Future<ServerResponse> getAllMatches() async {
  final Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  const endpoint = '/new-api/matches';
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

Future<ServerResponse> getEvent(int id) async {
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

Future<ServerResponse> getEentLinks(int id) async {
  Scraper(id: id);
}
