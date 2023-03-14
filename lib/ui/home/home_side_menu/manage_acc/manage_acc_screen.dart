import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/my_theme.dart';
import 'package:find_me_ii/helpers/shared_data.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ManageAcc extends StatefulWidget {
  static const String routeName = 'Manage Account';

  @override
  State<ManageAcc> createState() => _ManageAccState();
}

class _ManageAccState extends State<ManageAcc> {
  String? _image;

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
              _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * .1),
                      child: Image.file(
                        File(_image!),
                        width: MediaQuery.of(context).size.height * .2,
                        height: MediaQuery.of(context).size.height * .2,
                        fit: BoxFit.cover,
                        // placeholder: (context, url) => CircularProgressIndicator(),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * .1),
                      child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.height * .2,
                        height: MediaQuery.of(context).size.height * .2,
                        fit: BoxFit.cover,
                        imageUrl:
                            MyDataBase.me.image ?? SharedData.user?.image ?? '',
                        // placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                                child: Icon(CupertinoIcons.person_alt)),
                      ),
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
                    CupertinoIcons.home,
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
