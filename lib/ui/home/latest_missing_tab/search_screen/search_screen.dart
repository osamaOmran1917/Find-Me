import 'package:find_me_ii/helpers/my_theme.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/search_screen/date_search_screen.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/search_screen/text_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = 'Search Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.coloredSecondary,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.height * .8,
          decoration: BoxDecoration(
              color: MyTheme.basicWhite,
              borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  /*showSearch(
                      context: context, delegate: PersonSearchDelegate());*/
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => TextSearchScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.textSearch,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .03),
                    ),
                    Icon(Icons.search)
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: MyTheme.basicBlue))),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.coloredSecondary),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DateSearchScreen(),
                          settings: RouteSettings(arguments: 'post')));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.searchByPostDate,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .03),
                    ),
                    Icon(Icons.search)
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: MyTheme.basicBlue))),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.coloredSecondary),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DateSearchScreen(),
                          settings: RouteSettings(arguments: 'lose')));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.searchByDateOfLose,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .03),
                    ),
                    Icon(Icons.search)
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: MyTheme.basicBlue))),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.coloredSecondary),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DateSearchScreen(),
                          settings: RouteSettings(arguments: 'finding')));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.searchByDateOfFinding,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .03),
                    ),
                    Icon(Icons.search)
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: MyTheme.basicBlue))),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.coloredSecondary),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _launchInBrowser(Uri.parse('http://127.0.0.1:5000'));
                  /*Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ImageSearchScreen()));*/
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.searchByPhoto,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .03),
                    ),
                    Icon(Icons.search)
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: MyTheme.basicBlue))),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.coloredSecondary),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}