import 'package:web_scraper/web_scraper.dart';
import 'package:http/http.dart' as http;

class Scraper {
  // final webScraper = WebScraper('https://sportscentral.io/streams-table');
  Scraper() {
    // __init();
  }

  load(url) async {
    Uri uri = Uri.parse(url);

    print(uri);
    var response = await http.get(uri);
    //If the http request is successful the statusCode will be 200
    if (response.statusCode == 200) {
      String htmlToParse = response.body;
      print(htmlToParse);
    }
  }
}
