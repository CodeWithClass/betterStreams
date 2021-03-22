import 'package:web_scraper/web_scraper.dart';

class Scraper {
  final webScraper = WebScraper('https://sportscentral.io/streams-table');
  int id;
  Scraper({this.id}) {
    __init();
  }

  __init() async {
    if (await webScraper.loadWebPage('/${id.toString()}/soccer')) {
      List<Map<String, dynamic>> elements =
          webScraper.getElement('div.watch-section > a', ['href']);
      print(elements);
    }
  }
}
