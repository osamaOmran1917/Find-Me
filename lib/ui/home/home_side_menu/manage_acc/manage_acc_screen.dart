import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ManageAcc extends StatelessWidget {
  static const String routeName = 'Manage Account';

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editProfile),
        centerTitle: false,
        shape: InputBorder.none,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.profilePic,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.edit,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.blue),
                      ))
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1500),
                      border: Border.all(color: Colors.black, width: 3.3)),
                  width: MediaQuery.of(context).size.width * .45,
                  height: MediaQuery.of(context).size.height * .25,
                  child: ClipOval(
                    child: Image.network(
                      'https://img.freepik.com/free-icon/important-person_318-10744.jpg?w=2000',
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .03,
                    bottom: MediaQuery.of(context).size.height * .03),
                color: settingsProvider.isDarkMode()
                    ? MyTheme.coloredTertiary
                    : MyTheme.basicBlack,
                height: MediaQuery.of(context).size.height * .0003,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.details,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.edit,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.blue),
                      ))
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.home,
                    color: settingsProvider.isDarkMode()
                        ? MyTheme.coloredTertiary
                        : Colors.grey,
                  ),
                  Text(SharedData.user?.gov ??
                      AppLocalizations.of(context)!.whereDoYouLive)
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .03,
                    bottom: MediaQuery.of(context).size.height * .03),
                color: settingsProvider.isDarkMode()
                    ? MyTheme.coloredTertiary
                    : MyTheme.basicBlack,
                height: MediaQuery.of(context).size.height * .0003,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.links,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.edit,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.blue),
                      ))
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.facebook,
                    color: settingsProvider.isDarkMode()
                        ? MyTheme.coloredTertiary
                        : Colors.grey,
                  ),
                  Text(SharedData.user?.gov ??
                      AppLocalizations.of(context)!.addYourFaceBook)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
