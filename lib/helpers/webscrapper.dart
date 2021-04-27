import 'package:web_scraper/web_scraper.dart';

class Scraper {
  // final webScraper = WebScraper('https://sportscentral.io/streams-table');
  Scraper() {
    // __init();
  }

  load(id) async {
    try {
      final webScraper = WebScraper('https://sportscentral.io');
      if (await webScraper
          .loadWebPage('/streams-table/${id.toString()}/soccer')) {
        var elements =
            webScraper.getElementAttribute('div.watch-section > a', 'href');
        // print(elements);
        return elements;
      }
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  getIframe(url) async {}
}
