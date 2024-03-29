import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/my_theme.dart';
import 'package:find_me_ii/helpers/shared_data.dart';
import 'package:find_me_ii/ui/home/dashboard_tab/dashboard.dart';
import 'package:find_me_ii/ui/home/home_viewModel.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/chat/chats_screen.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/insert_lost_person_screen/insert_lost_person_screen.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/latest_lost_tab.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/search_screen/search_screen.dart';
import 'package:find_me_ii/ui/home/notificationa_tab/notifications_tab.dart';
import 'package:find_me_ii/ui/home/profile_tab/profile_tab.dart';
import 'package:find_me_ii/ui/home/settings_tab/settings_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_side_menu/home_side_menu.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home Screen';
  static int selectedIndex = 0;
  static bool hasMessage = false;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  void initState() {
    super.initState();
    MyDataBase.getSelfInfo();
    SystemChannels.lifecycle.setMessageHandler((message) {
      if (MyDataBase.auth.currentUser != null && SharedData.user != null) {
        if (message.toString().contains('resume'))
          MyDataBase.updateActiveStatus(true);
        if (message.toString().contains('pause'))
          MyDataBase.updateActiveStatus(false);
      }
      return Future.value(message);
    });
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  List<Widget> tabs = [
    LatestLost(),
    DashboardTab(),
    ProfileTab(
      user: SharedData.user!,
    ),
    NotificationsTab(),
    SettingsTab(),
  ];

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showMyDialog();
        return shouldPop ?? false;
      },
      child: Scaffold(
        drawer: Drawer(
          child: HomeSideMenu(),
        ),
        appBar: AppBar(
          centerTitle: HomeScreen.selectedIndex == 0 ? false : true,
          title: Text(AppLocalizations.of(context)!.app_title),
          actions: [
            HomeScreen.selectedIndex == 0
                ? CircleAvatar(
              backgroundColor: MyTheme.basicWhite.withOpacity(.2),
              child: PopupMenuButton(
                  onSelected: (value) {
                    value == AppLocalizations.of(context)!.foundPerson
                        ? Navigator.pushNamed(
                        context, InsertLostPersonScreen.routeName,
                        arguments: InsertLostPersonScreen.lost =
                        false)
                        : Navigator.pushNamed(
                        context, InsertLostPersonScreen.routeName,
                        arguments: InsertLostPersonScreen.lost =
                        true);
                  },
                  icon: ImageIcon(
                      AssetImage('assets/images/add-user.png')),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text(AppLocalizations.of(context)!
                          .foundPerson),
                      value:
                      AppLocalizations.of(context)!.foundPerson,
                    ),
                    PopupMenuItem(
                      child: Text(
                          AppLocalizations.of(context)!.lostPerson),
                      value:
                      AppLocalizations.of(context)!.lostPerson,
                    )
                  ]),
            )
                : Container(),
            HomeScreen.selectedIndex == 0
                ? SizedBox(
              width: MediaQuery.of(context).size.width * .03,
            )
                : Container(),
            HomeScreen.selectedIndex == 0
                ? CircleAvatar(
                backgroundColor: MyTheme.basicWhite.withOpacity(.2),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, SearchScreen.routeName);
                    },
                    icon: Icon(CupertinoIcons.search)))
                : Container(),
            HomeScreen.selectedIndex == 0
                ? SizedBox(
              width: MediaQuery.of(context).size.width * .03,
            )
                : Container(),
            HomeScreen.selectedIndex == 0
                ? CircleAvatar(
                backgroundColor: MyTheme.basicWhite.withOpacity(.2),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ChatsScreen.routeName);
                  },
                  icon: Stack(
                    children: [
                      Icon(CupertinoIcons.chat_bubble_2),
                      if (HomeScreen.hasMessage)
                        Positioned(
                          bottom: MediaQuery.of(context).size.height * 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height *
                                        500)),
                            width:
                            MediaQuery.of(context).size.width * .03,
                            height:
                            MediaQuery.of(context).size.width * .03,
                          ),
                        )
                    ],
                  ),
                    ))
                : Container(),
            HomeScreen.selectedIndex == 0
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * .03,
                  )
                : Container(),
          ],
        ),
        body: tabs[HomeScreen.selectedIndex],
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: HomeScreen.selectedIndex,
          onItemSelected: (index) =>
              setState(() => HomeScreen.selectedIndex = index),
          items: [
            BottomNavyBarItem(
              icon: Icon(CupertinoIcons.home),
              title: Text(AppLocalizations.of(context)!.home),
              activeColor: MyTheme.basicBlack,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: ImageIcon(AssetImage('assets/images/dashboard.png')),
              title: Text(AppLocalizations.of(context)!.dashboard),
              activeColor: MyTheme.basicBlack,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(CupertinoIcons.person_alt),
              title: Text(AppLocalizations.of(context)!.profile),
              activeColor: MyTheme.basicBlack,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(CupertinoIcons.bell_fill),
              title: Text(AppLocalizations.of(context)!.notifications),
              activeColor: MyTheme.basicBlack,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(CupertinoIcons.settings),
              title: Text(AppLocalizations.of(context)!.settings),
              activeColor: MyTheme.basicBlack,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void onTabClicked(index) {
    viewModel.onTabSelected(index);
  }

  Future<bool?> showMyDialog() {
    if (HomeScreen.selectedIndex != 0) {
      HomeScreen.selectedIndex = 0;
      setState(() {});
      return false as Future<bool?>;
    } else
      return showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure, you want to leave?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('cancel')),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('yes'))
            ],
          ));
  }
}
