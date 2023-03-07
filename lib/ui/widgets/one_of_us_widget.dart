import 'package:find_me_ii/helpers/my_theme.dart';
import 'package:flutter/material.dart';

class OneOfUsWidget extends StatelessWidget {
  String img, name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyTheme.basicWhite,
          boxShadow: [
            BoxShadow(
              color: MyTheme.coloredSecondary.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(color: MyTheme.coloredSecondary),
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .2,
            width: MediaQuery.of(context).size.width * .2,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: Image.asset(
              'assets/images/${img}',
              fit: BoxFit.contain,
            ),
          ),
          Text(name)
        ],
      ),
    );
  }

  OneOfUsWidget(this.img, this.name);
}