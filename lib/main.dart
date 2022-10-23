import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/ui/log_in/log_in_screen.dart';
import 'package:find_me_ii/ui/registeration/register_screen.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme,
      initialRoute: RegisterScreen.routeName,
      routes: {
        LogInScreen.routeName: (_) => LogInScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen()
      },
      home: RegisterScreen(),
    );
  }
}
