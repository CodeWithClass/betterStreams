import 'package:betterstreams/services/getData.dart';
import 'package:betterstreams/state/soccerData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:betterstreams/helpers/displaySize.dart';
import 'package:universal_html/html.dart' as html;

// ignore: must_be_immutable
class Link extends ConsumerWidget {
  final int id;
  String name;
  final String url;
  final String language;
  final String quality;
  final String bitrate;
  final String channel;

  Link(
      {this.id,
      this.url,
      this.name,
      this.language,
      this.quality,
      this.bitrate,
      this.channel});

  Widget build(BuildContext context, ScopedReader watch) {
    final soccerData = watch(soccerDataProvider);

    final _name = name.split(' ');
    name = _name[0].trim();
    double mx = displayWidth(context) * .15;
    if (displayWidth(context) < 800) mx = 20;
    if (displayWidth(context) > 1200) mx = mx * 1.5;

    return Container(
      margin: EdgeInsets.fromLTRB(mx, 10, mx, 10),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[900]),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ))),
        // autofocus: true,
        onPressed: () async {
          soccerData.setLoading(true);
          var res = await scrapeLink(url);
          soccerData.setLoading(false);
          if (res.status) return html.window.open(res.data, '');
          html.window.open(url, '');
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Flexible(
            child: Container(
              width: displayWidth(context) * 0.2,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                name,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
          ),
          Flexible(
            child: Container(
              width: displayWidth(context) * 0.4,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Text('$language  ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: language == 'ENG'
                                ? Colors.blue[400]
                                : Colors.grey[300],
                          )),
                      Text('$quality  ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.green[400],
                          )),
                      Text(
                        '$bitrate  ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.green[600],
                        ),
                      ),
                      Container(
                        width: 120,
                        child: Text(
                          '$channel  ',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.yellow[600]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      url,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
