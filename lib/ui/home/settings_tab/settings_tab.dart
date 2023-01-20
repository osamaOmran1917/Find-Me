import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/ui/home/settings_tab/theme_bottom_sheet.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'language_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .0125,
          ),
          InkWell(
            onTap: () => showLanguageBottomSheet(),
            child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: MyTheme.coloredSecondary, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: Text(
                  settingsProvider.currentLang == 'en' ? 'English' : 'العربية',
                  style: Theme.of(context).textTheme.headline5,
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .0125,
          ),
          InkWell(
            onTap: () {
              showThemeBottomSheet();
            },
            child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: MyTheme.coloredSecondary, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: Text(
                  settingsProvider.isDarkMode()
                      ? AppLocalizations.of(context)!.colored
                      : AppLocalizations.of(context)!.basic,
                  style: Theme.of(context).textTheme.headline5,
                )),
          )
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return LanguageBottomSheet();
        });
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return ThemeBottomSheet();
        });
  }
}
