import 'package:find_me_ii/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OneOfUsWidget extends StatelessWidget {
  String img, name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyTheme.primaryColor,
          boxShadow: [
            BoxShadow(
              color: MyTheme.secondaryColor.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(color: MyTheme.secondaryColor),
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .25,
            width: MediaQuery.of(context).size.width * .25,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: Image.asset(
              'assets/images/${img}',
              fit: BoxFit.cover,
            ),
          ),
          Text('${AppLocalizations.of(context)!.eng}: ${name}')
        ],
      ),
    );
  }

  OneOfUsWidget(this.img, this.name);
}
