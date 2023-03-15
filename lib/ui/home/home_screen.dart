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
    return Scaffold(
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
                        icon: Icon(CupertinoIcons.add),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text(
                                    AppLocalizations.of(context)!.foundPerson),
                                value:
                                    AppLocalizations.of(context)!.foundPerson,
                              ),
                              PopupMenuItem(
                                child: Text(
                                    AppLocalizations.of(context)!.lostPerson),
                                value: AppLocalizations.of(context)!.lostPerson,
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
                          Navigator.pushNamed(context, SearchScreen.routeName);
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
                        icon: Icon(CupertinoIcons.chat_bubble_2_fill)),
                  )
                : Container(),
            HomeScreen.selectedIndex == 0
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * .03,
                  )
                : Container(),
          ],
        ),
        body: tabs[HomeScreen.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: HomeScreen.selectedIndex,
            onTap: (index) {
              onTabClicked(index);
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  icon: Icon(CupertinoIcons.home),
                  label: AppLocalizations.of(context)!.home),
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  icon: Icon(CupertinoIcons.chat_bubble_text_fill),
                  label: AppLocalizations.of(context)!.dashboard),
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  icon: Icon(CupertinoIcons.person_alt),
                  label: AppLocalizations.of(context)!.profile),
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  icon: Icon(CupertinoIcons.bell_fill),
                  label: AppLocalizations.of(context)!.notifications),
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  icon: Icon(CupertinoIcons.settings),
                  label: AppLocalizations.of(context)!.settings)
            ]));
  }

  void onTabClicked(index) {
    viewModel.onTabSelected(index);
  }
}
