import 'package:flutter/material.dart';

Widget refreshButton({Function onpressed}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 50,
        height: 50,
        padding: EdgeInsets.all(0),
        child: ElevatedButton(
          onPressed: () => {onpressed()},
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.pink[700]),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.refresh,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
