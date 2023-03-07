import 'package:find_me_ii/helpers/my_theme.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.all(18),
      child: Column(
        children: [
          InkWell(
              onTap: () {
                settingsProvider.isDarkMode()
                    ? settingsProvider.changeTheme(ThemeMode.light)
                    : null;
              },
              child: settingsProvider.isDarkMode()
                  ? getUnSelectedItem(AppLocalizations.of(context)!.basic)
                  : getSelectedItem(AppLocalizations.of(context)!.basic)),
          SizedBox(
            height: MediaQuery.of(context).size.height * .045,
          ),
          InkWell(
              onTap: () {
                settingsProvider.isDarkMode()
                    ? null
                    : settingsProvider.changeTheme(ThemeMode.dark);
              },
              child: settingsProvider.isDarkMode()
                  ? getSelectedItem(AppLocalizations.of(context)!.colored)
                  : getUnSelectedItem(AppLocalizations.of(context)!.colored))
        ],
      ),
    );
  }

  Widget getSelectedItem(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: MyTheme.basicBlue),
        ),
        Icon(
          Icons.check_circle_outline,
          color: MyTheme.basicBlue,
        )
      ],
    );
  }

  Widget getUnSelectedItem(String text) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headline5,
        )
      ],
    );
  }
}
