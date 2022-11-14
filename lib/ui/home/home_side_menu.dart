import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../log_in/login_screen.dart';

class HomeSideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: Row(
            children: [
              Icon(Icons.person),
              SizedBox(
                width: MediaQuery.of(context).size.width * .05,
              ),
              Text(SharedData.user?.userName ?? ''),
            ],
          ),
          automaticallyImplyLeading: false,
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: MyTheme.tertiaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          titleTextStyle: TextStyle(fontSize: 18, color: Colors.black)),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: () {}, child: Text('Manage your account')),
            TextButton(onPressed: () {}, child: Text('Contact us')),
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  SharedData.user = null;
                  Navigator.pushReplacementNamed(
                      context, LogInScreen.routeName);
                },
                child: Text('Log Out')),
          ],
        ),
      ),
    );
  }
}
