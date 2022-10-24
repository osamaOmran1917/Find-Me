import 'package:flutter/material.dart';

class MyTheme {
  static final Color primaryColor = Color(0xFFFFA19F);
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFFFC5BB),
        elevation: 15,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(18)),
        titleTextStyle: TextStyle(fontSize: 18, color: Colors.black)),
    textTheme:
        TextTheme(bodyText1: TextStyle(color: Colors.black, fontSize: 18)),
  );
}
