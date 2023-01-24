import 'package:find_me_ii/model/my_user.dart';
import 'package:flutter/material.dart';

class ChatSection extends StatelessWidget {
  MyUser user;

  ChatSection(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * .02),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * (1 / 8),
      child: Row(
        children: [
          ClipOval(
              child: SizedBox.fromSize(
            size: Size.fromRadius(
                MediaQuery.of(context).size.width * .085), // Image radius
            child: Image.asset(
              'assets/images/Sia_Kate.jpg',
              fit: BoxFit.cover,
            ),
          )),
          SizedBox(
            width: MediaQuery.of(context).size.width * .03,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.userName ?? '',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * .043,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .009,
              ),
              Text('Last Message')
            ],
          )
        ],
      ),
    );
  }
}
