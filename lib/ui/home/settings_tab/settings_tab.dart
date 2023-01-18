import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white),
              child: Text(
                'English',
                style: Theme.of(context).textTheme.headline5,
              ))
        ],
      ),
    );
  }
}
