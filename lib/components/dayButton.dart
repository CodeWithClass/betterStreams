import 'package:flutter/material.dart';

Widget dayButton({Function onPressed, String text, bool selected}) {
  if (selected)
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.pink[700]),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ))),
      ),
    );
  return Container(
    margin: EdgeInsets.all(10),
    child: OutlinedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text),
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
