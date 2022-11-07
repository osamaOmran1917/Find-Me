import 'package:flutter/material.dart';

import '../log_in/login_screen.dart';

class HomeSideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () =>
            Navigator.pushReplacementNamed(context, LogInScreen.routeName),
        child: Text('Log Out'));
  }
}
