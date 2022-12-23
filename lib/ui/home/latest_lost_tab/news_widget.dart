import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 22, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/lost.PNG',
            width: MediaQuery.of(context).size.width * .2,
            height: MediaQuery.of(context).size.height * .15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('أحمد عبرازئ الزملكاوي'),
              Text('القليوبية'),
              Text('15/10/2021')
            ],
          )
        ],
      ),
    );
  }
}
