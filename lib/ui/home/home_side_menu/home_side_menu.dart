import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:find_me_ii/ui/home/home_side_menu/about_us/about_us_screen.dart';
import 'package:find_me_ii/ui/home/home_side_menu/contact_us/contact_us_screen.dart';
import 'package:find_me_ii/ui/home/home_side_menu/home_side_menu_viewModel.dart';
import 'package:find_me_ii/ui/home/home_side_menu/manage_acc/manage_acc_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../log_in/login_screen.dart';

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
      child: Scaffold(
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
            backgroundColor: MyTheme.tertiaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            titleTextStyle: TextStyle(fontSize: 18, color: Colors.black)),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    viewModel.onManageAccPrsd();
                  },
                  child: Text('Manage your account')),
              TextButton(
                  onPressed: () {
                    viewModel.onAboutUsPrsd();
                  },
                  child: Text('About us')),
              TextButton(
                  onPressed: () {
                    viewModel.onContactUsPrsd();
                  },
                  child: Text('Contact us')),
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    SharedData.user = null;
                    Navigator.pushReplacementNamed(
                        context, LogInScreen.routeName);
                  },
                  child: Text('Log Out')),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void goToManageAccPage() {
    Navigator.pushNamed(context, ManageAcc.routeName);
  }

  @override
  void goToAboutUsPage() {
    Navigator.pushNamed(context, AboutUs.routeName);
  }

  @override
  void goToContactUsPage() {
    Navigator.pushNamed(context, ContactUs.routeName);
  }
}
