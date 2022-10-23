import 'package:find_me_ii/log_in/log_in_screen.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme,
      home: LogInScreen(),
    );
  }
}
