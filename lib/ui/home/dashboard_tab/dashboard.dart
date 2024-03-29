import 'package:find_me_ii/helpers/log_out.dart';
import 'package:find_me_ii/ui/home/dashboard_tab/user_instructions.dart';
import 'package:find_me_ii/ui/home/home_side_menu/about_us/about_us_screen.dart';
import 'package:find_me_ii/ui/home/home_side_menu/contact_us/contact_us_screen.dart';
import 'package:find_me_ii/ui/home/home_side_menu/manage_acc/manage_acc_screen.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/chat/chats_screen.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/search_screen/search_screen.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../latest_missing_tab/insert_lost_person_screen/insert_lost_person_screen.dart';

class DashboardTab extends StatefulWidget {
  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SearchScreen()));
                  },
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .01),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .040000001)),
                    child: Text(
                      AppLocalizations.of(context)!.searchForAMissingPerson,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .055,
                          fontFamily: 'Arabic'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, InsertLostPersonScreen.routeName,
                        arguments: InsertLostPersonScreen.lost = true);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .01),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .040000001)),
                    child: Text(
                      AppLocalizations.of(context)!.postAMissingPerson,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .055,
                          fontFamily: 'Arabic'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, InsertLostPersonScreen.routeName,
                        arguments: InsertLostPersonScreen.lost = false);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .01),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .040000001)),
                    child: Text(
                      AppLocalizations.of(context)!.postFoundPerson,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .055,
                          fontFamily: 'Arabic'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ChatsScreen())),
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .01),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .040000001)),
                    child: Text(
                      AppLocalizations.of(context)!.chatWithSomeone,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .055,
                          fontFamily: 'Arabic'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ManageAcc())),
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .01),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .040000001)),
                    child: Text(
                      AppLocalizations.of(context)!.manageAcc,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .055,
                          fontFamily: 'Arabic'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => settingsProvider.changeLanguage(
                      settingsProvider.isArabic() ? 'en' : 'ar'),
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .01),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .040000001)),
                    child: Text(
                      settingsProvider.isArabic() ? 'English' : 'عربي',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .055,
                          fontFamily: 'Arabic'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () => settingsProvider.changeTheme(
                      settingsProvider.isDarkMode()
                          ? ThemeMode.light
                          : ThemeMode.dark),
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .01),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .040000001)),
                    child: Text(
                      AppLocalizations.of(context)!.changeAppTheme,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .055,
                          fontFamily: 'Arabic'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => UserInstructions())),
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .01),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .040000001)),
                    child: Text(
                      AppLocalizations.of(context)!.howToUseFindMe,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .055,
                          fontFamily: 'Arabic'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => AboutUs())),
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .01),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .040000001)),
                    child: Text(
                      AppLocalizations.of(context)!.whoAreWe,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .055,
                          fontFamily: 'Arabic'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ContactUs())),
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .01),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .040000001)),
                    child: Text(
                      AppLocalizations.of(context)!.needHelp,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .055,
                          fontFamily: 'Arabic'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    logOut(context);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .01),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .040000001)),
                    child: Text(
                      AppLocalizations.of(context)!.wannaLogOut,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .055,
                          fontFamily: 'Arabic'),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}