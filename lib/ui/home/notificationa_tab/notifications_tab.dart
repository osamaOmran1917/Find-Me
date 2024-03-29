import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Text(AppLocalizations.of(context)!.youHaveNoNotificationsRightNow),
      ),
    );
  }
}
