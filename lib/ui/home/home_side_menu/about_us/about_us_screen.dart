import 'package:find_me_ii/ui/home/home_side_menu/about_us/one_of_us_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUs extends StatelessWidget {
  static const String routeName = 'About Us';

  @override
  Widget build(BuildContext context) {
    List<OneOfUsWidget> us = [
      OneOfUsWidget(
        'cat.jpg',
        AppLocalizations.of(context)!.osama,
      ),
      OneOfUsWidget('cat.jpg', AppLocalizations.of(context)!.zamalkawy),
      OneOfUsWidget('cat.jpg', AppLocalizations.of(context)!.adham),
      OneOfUsWidget('cat.jpg', AppLocalizations.of(context)!.alaa),
      OneOfUsWidget('cat.jpg', AppLocalizations.of(context)!.fatema),
      OneOfUsWidget('cat.jpg', AppLocalizations.of(context)!.mohammed),
    ];

    return Scaffold(
      body: GridView.count(
        crossAxisSpacing: MediaQuery
            .of(context)
            .size
            .width * .01,
        mainAxisSpacing: MediaQuery
            .of(context)
            .size
            .height * .04,
        crossAxisCount: 2,
        children: us,
      ),
    );
  }
}