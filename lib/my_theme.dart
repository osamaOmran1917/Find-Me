import 'package:flutter/material.dart';

class MyTheme {
  static final Color primaryColor = Color(0xFFEFBD8E);
  static final Color secondaryColor = Color(0xFF778891);
  static final Color tertiaryColor = Color(0xFFA18B7D);
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(color: primaryColor),
        iconTheme: IconThemeData(color: primaryColor),
        centerTitle: true,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        backgroundColor: MyTheme.secondaryColor,
        // backgroundColor: Color(0xFFFFA19F),
        elevation: 15,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: MyTheme.tertiaryColor, width: 1),
            borderRadius: BorderRadius.circular(18)),
        titleTextStyle: TextStyle(fontSize: 18, color: Colors.black)),
    scaffoldBackgroundColor: primaryColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: secondaryColor,
      selectedIconTheme: IconThemeData(color: primaryColor),
      showSelectedLabels: true,
      selectedItemColor: primaryColor,
    ),
    textTheme:
        TextTheme(bodyText1: TextStyle(color: Colors.black, fontSize: 18)),
  );
}
