import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/dialog_utils.dart';
import 'package:find_me_ii/helpers/shared_data.dart';
import 'package:find_me_ii/ui/log_in/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';

void logOut(BuildContext context) {
  showMessage(context, AppLocalizations.of(context)!.areYouSureYouWannaLogout,
      posAction: () async {
    await MyDataBase.updateActiveStatus(false);
    await FirebaseAuth.instance.signOut().then((value) async {
      await GoogleSignIn().signOut().then((value) {
        MyDataBase.auth = FirebaseAuth.instance;
        Navigator.pushReplacementNamed(context, LogInScreen.routeName);
      });
    });
    SharedData.user = null;
  },
      posActionName: AppLocalizations.of(context)!.yes,
      negAction: () {},
      negActionName: AppLocalizations.of(context)!.no);
}
