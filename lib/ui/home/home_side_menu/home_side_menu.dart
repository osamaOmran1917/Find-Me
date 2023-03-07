import 'package:find_me_ii/helpers/log_out.dart';
import 'package:find_me_ii/ui/home/home_side_menu/about_us/about_us_screen.dart';
import 'package:find_me_ii/ui/home/home_side_menu/contact_us/contact_us_screen.dart';
import 'package:find_me_ii/ui/home/home_side_menu/home_side_menu_viewModel.dart';
import 'package:find_me_ii/ui/home/home_side_menu/manage_acc/manage_acc_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeSideMenu extends StatefulWidget {
  @override
  State<HomeSideMenu> createState() => _HomeSideMenuState();
}

class _HomeSideMenuState extends State<HomeSideMenu>
    implements HomeSideMenuNavigator {
  late HomeSideMenuViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = HomeSideMenuViewModel();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: /*Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Row(
              children: [
                Icon(Icons.person),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .05,
                ),
                Text(SharedData.user?.userName ?? ''),
              ],
            ),
            automaticallyImplyLeading: false,
            actionsIconTheme: IconThemeData(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: MyTheme.basicBlue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            titleTextStyle: TextStyle(fontSize: 18, color: Colors.black)),
        body: */
          Container(
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/icon.png',
                      width: MediaQuery.of(context).size.width * .2,
                      height: MediaQuery.of(context).size.height * .2),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .1,
                  ),
                  Text(
                    AppLocalizations.of(context)!.app_title,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .07),
                  )
                ]),
            TextButton.icon(
                onPressed: () {
                  viewModel.onManageAccPrsd();
                },
                icon: Icon(CupertinoIcons.profile_circled),
                label: Text(AppLocalizations.of(context)!.manageAcc)),
            TextButton.icon(
                onPressed: () {
                  viewModel.onAboutUsPrsd();
                },
                icon: Icon(CupertinoIcons.group),
                label: Text(AppLocalizations.of(context)!.aboutUs)),
            TextButton.icon(
                onPressed: () {
                  viewModel.onContactUsPrsd();
                },
                icon: Icon(CupertinoIcons.phone),
                label: Text(AppLocalizations.of(context)!.contactUs)),
            TextButton.icon(
                onPressed: () {
                  logOut(context);
                },
                icon: Icon(Icons.logout_outlined),
                label: Text(AppLocalizations.of(context)!.logOut)),
          ],
        ),
      ),
      // ),
    );
  }

  @override
  void goToManageAccPage() {
    Navigator.pushNamed(context, ManageAcc.routeName);
  }

  @override
  void goToAboutUsPage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => AboutUs()));
  }

  @override
  void goToContactUsPage() {
    Navigator.pushNamed(context, ContactUs.routeName);
  }
}
