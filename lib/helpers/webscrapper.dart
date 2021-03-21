import 'package:web_scraper/web_scraper.dart';

class Scraper{
  final webScraper = WebScraper('https://reddi.soccerstreams.net');

  Scraper(){
    __init();
  }

  __init() async{
    if (await webScraper.loadWebPage('/home')) {
      List<Map<String, dynamic>> elements =
          webScraper.getElement('#search-overlay', ['']);
      print(elements);
      
    }
  }




}