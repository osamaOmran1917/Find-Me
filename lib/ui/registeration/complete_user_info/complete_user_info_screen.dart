import 'package:find_me_ii/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

class CompleteUserInfo extends StatelessWidget {
  static const String routeName = 'Complete User Info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInLeft(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: MyTheme.secondaryColor,
                          borderRadius: BorderRadius.circular(500)),
                      child: Icon(
                        Icons.person_outlined,
                        size: MediaQuery.of(context).size.height * .15,
                        color: MyTheme.primaryColor,
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Text('Add profile picture'),
                  Container(
                    color: Colors.black,
                    height: 1,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .07,
                        vertical: MediaQuery.of(context).size.height * .025),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
