import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/ui/home/chatbot_tab/chatbot_tab.dart';
import 'package:find_me_ii/ui/home/home_tab/insert_lost_person_screen/insert_lost_person_screen.dart';
import 'package:find_me_ii/ui/home/home_tab/latest_lost_tab.dart';
import 'package:find_me_ii/ui/home/home_tab/search_screen/search_screen.dart';
import 'package:find_me_ii/ui/home/home_viewModel.dart';
import 'package:find_me_ii/ui/home/notificationa_tab/notifications_tab.dart';
import 'package:find_me_ii/ui/home/profile_tab/profile_tab.dart';
import 'package:find_me_ii/ui/home/settings_tab/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_side_menu/home_side_menu.dart';
import 'home_tab/chat/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home Screen';
  static int selectedIndex = 0;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  List<Widget> tabs = [
    LatestLost(),
    ChatBotTab(),
    ProfileTab(),
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
                        value == 'Found person'
                            ? Navigator.pushNamed(
                                context, InsertLostPersonScreen.routeName,
                                arguments: InsertLostPersonScreen.lost = false)
                            : Navigator.pushNamed(
                                context, InsertLostPersonScreen.routeName,
                                arguments: InsertLostPersonScreen.lost = true);
                      },
                      icon: Icon(Icons.add),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('Found person'),
                              value: 'Found person',
                            ),
                            PopupMenuItem(
                              child: Text('Lost person'),
                              value: 'Lost person',
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
                      icon: Icon(Icons.search)))
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
                        Navigator.pushNamed(context, ChatScreen.routeName);
                      },
                      icon: Icon(Icons.forward_to_inbox_outlined)),
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
                backgroundColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                icon: Icon(Icons.home),
                label: 'Home'),
            BottomNavigationBarItem(
                backgroundColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                icon: Icon(Icons.chat_outlined),
                label: 'ChatBot'),
            BottomNavigationBarItem(
                backgroundColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                icon: Icon(Icons.person),
                label: 'Profile'),
            BottomNavigationBarItem(
                backgroundColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                icon: Icon(Icons.notifications_on),
                label: 'Notifications'),
            BottomNavigationBarItem(
                backgroundColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                icon: Icon(Icons.settings),
                label: 'Settings')
          ]),
    );
  }

  void onTabClicked(index) {
    viewModel.onTabSelected(index);
  }
}
