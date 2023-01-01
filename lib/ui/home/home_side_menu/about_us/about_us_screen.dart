import 'package:find_me_ii/ui/home/home_side_menu/about_us/one_of_us_widget.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const String routeName = 'About Us';

  List<OneOfUsWidget> us = [
    OneOfUsWidget('osama.PNG', 'Osama'),
    OneOfUsWidget('zmlk.PNG', 'Zamalkawy'),
    OneOfUsWidget('adhm.PNG', 'Adham'),
    OneOfUsWidget('Shai5Messi.jpg', 'Alaa'),
    OneOfUsWidget('Shai5Messi.jpg', 'Fatema'),
    OneOfUsWidget('attota.PNG', 'Mohammed'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisSpacing: MediaQuery.of(context).size.width * .01,
        mainAxisSpacing: MediaQuery.of(context).size.height * .04,
        crossAxisCount: 2,
        children: us,
      ), /*Column(
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
      ),*/
    );
  }
}
