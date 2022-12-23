import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const String routeName = 'About Us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/osama.PNG', height: 50, width: 50,),
                  Text('Eng: Osama')
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/osama.PNG', height: 50, width: 50,),
                  Text('Eng: Osama')
                ],
              )
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/osama.PNG', height: 50, width: 50,),
                  Text('Eng: Osama')
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/osama.PNG', height: 50, width: 50,),
                  Text('Eng: Osama')
                ],
              )
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/osama.PNG', height: 50, width: 50,),
                  Text('Eng: Osama')
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/osama.PNG', height: 50, width: 50,),
                  Text('Eng: Osama')
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
