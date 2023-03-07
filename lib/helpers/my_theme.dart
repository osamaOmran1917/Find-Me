import 'package:flutter/material.dart';

class MyTheme {
  static final Color basicWhite = Colors.white;
  static final Color basicBlack = Colors.black;
  static final Color basicBlue = Colors.blue;

  static final Color coloredPrimary = Color(0xFFEFBD8E);
  static final Color coloredSecondary = Color(0xFF778891);
  static final Color coloredTertiary = Color(0xFFA18B7D);

  static final Color fourthColor = Colors.pink;

  static final ThemeData basicTheme = ThemeData(
      primaryColor: basicWhite,
      appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(color: basicWhite),
          iconTheme: IconThemeData(color: basicWhite),
          centerTitle: true,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          backgroundColor: MyTheme.basicBlack,
          // backgroundColor: Color(0xFFFFA19F),
          elevation: 15,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: MyTheme.basicBlue, width: 1),
              borderRadius: BorderRadius.circular(18)),
          titleTextStyle: TextStyle(fontSize: 18, color: MyTheme.basicWhite),
          backwardsCompatibility: false),
      scaffoldBackgroundColor: basicWhite,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: MyTheme.basicBlack,
          selectedIconTheme: IconThemeData(color: basicWhite),
          unselectedIconTheme: IconThemeData(color: basicWhite),
          showSelectedLabels: true,
          selectedItemColor: basicWhite,
          unselectedItemColor: basicWhite),
      textTheme:
          TextTheme(bodyText1: TextStyle(color: Colors.black, fontSize: 18)),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: basicWhite));
  static final ThemeData coloredTheme = ThemeData(
      primaryColor: coloredPrimary,
      appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(color: coloredPrimary),
          iconTheme: IconThemeData(color: coloredPrimary),
          centerTitle: true,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          backgroundColor: MyTheme.coloredSecondary,
          // backgroundColor: Color(0xFFFFA19F),
          elevation: 15,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: MyTheme.coloredTertiary, width: 1),
              borderRadius: BorderRadius.circular(18)),
          titleTextStyle:
              TextStyle(fontSize: 18, color: MyTheme.coloredPrimary),
          backwardsCompatibility: false),
      scaffoldBackgroundColor: coloredPrimary,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: coloredSecondary,
          selectedIconTheme: IconThemeData(color: basicWhite),
          unselectedIconTheme: IconThemeData(color: basicWhite),
          showSelectedLabels: true,
          selectedItemColor: basicWhite,
          unselectedItemColor: basicWhite),
      textTheme:
          TextTheme(bodyText1: TextStyle(color: Colors.black, fontSize: 18)),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: coloredPrimary));
}