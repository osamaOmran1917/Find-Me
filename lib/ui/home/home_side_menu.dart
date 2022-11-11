import 'package:find_me_ii/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../log_in/login_screen.dart';

class HomeSideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          SharedData.user = null;
          Navigator.pushReplacementNamed(context, LogInScreen.routeName);
        },
        child: Text('Log Out'));
  }
}
