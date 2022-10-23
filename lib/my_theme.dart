import 'package:flutter/material.dart';

class MyTheme {
  static final ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFFC5BB),
          elevation: 15,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          titleTextStyle: TextStyle(fontSize: 18, color: Colors.black)));
}
