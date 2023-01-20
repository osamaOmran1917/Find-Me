import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatelessWidget {
  static const String routeName = 'Contact Us';

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    String and = settingsProvider.currentLang == 'ar' ? 'و' : '&',
        number = '+201557712317';
    return Scaffold(
      body: Center(
        child: Text(
            '${AppLocalizations.of(context)!.whats} ${and} ${AppLocalizations.of(context)!.calls}: ${number}'),
      ),
    );
  }
}
