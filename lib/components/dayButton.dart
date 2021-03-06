import 'package:flutter/material.dart';

Widget dayButton({Function onPressed, String text, bool selected}) {
  if (selected)
    return Container(
      width: 110,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () => {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
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
    width: 110,
    child: OutlinedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
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
