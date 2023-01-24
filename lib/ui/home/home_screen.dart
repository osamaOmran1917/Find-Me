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
                  child: popMenus(
                    context: context,
                    options: [
                      {
                        "menu": "Found Person" ?? '',
                        "menu_id": 1,
                      },
                      {
                        "menu": "Lost Person" ?? "",
                        "menu_id": 2,
                      },
                    ],
                  ),
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

  Widget popMenus({
    required List<Map<String, dynamic>> options,
    required BuildContext context,
  }) {
    return PopupMenuButton(
      iconSize: 24.0,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      icon: Icon(
        Icons.add,
      ),
      offset: Offset(0, 10),
      itemBuilder: (BuildContext bc) {
        return options
            .map(
              (selectedOption) => PopupMenuItem(
                height: 12.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedOption['menu'] ?? "",
                      style: TextStyle(
                        // fontSize: ScreenUtil().setSp(14.0),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: Colors.blue,
                      ),
                    ),
                    (options.length == (options.indexOf(selectedOption) + 1))
                        ? SizedBox(
                            width: 0.0,
                            height: 0.0,
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                            ),
                            child: Divider(
                              color: Colors.grey,
                              // height: ScreenUtil().setHeight(1.0),
                            ),
                          ),
                  ],
                ),
                value: selectedOption,
              ),
            )
            .toList();
      },
      onSelected: (value) async {
        Navigator.pushNamed(context, InsertLostPersonScreen.routeName);
      },
    );
  }
}