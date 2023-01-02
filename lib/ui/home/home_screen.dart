import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/ui/home/chatbot_tab/chatbot_tab.dart';
import 'package:find_me_ii/ui/home/home_viewModel.dart';
import 'package:find_me_ii/ui/home/latest_lost_tab/current_user_posts.dart';
import 'package:find_me_ii/ui/home/latest_lost_tab/latest_lost_tab.dart';
import 'package:find_me_ii/ui/home/settings_tab/settings_tab.dart';
import 'package:flutter/material.dart';

import 'home_side_menu/home_side_menu.dart';
import 'home_tab/home_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home Screen';
  static int selectedIndex = 0;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  List<Widget> tabs = [HomeTab(), LatestLost(), ChatBotTab(), SettingsTab()];

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: HomeScreen.selectedIndex == 1
          ? FloatingActionButton(
              backgroundColor: MyTheme.secondaryColor,
              onPressed: () {
                Navigator.pushNamed(context, CurrentUserPosts.routeName);
              },
              child: Text(
                'My Posts',
                textAlign: TextAlign.center,
              ),
            )
          : null,
      drawer: Drawer(
        child: HomeSideMenu(),
      ),
      appBar: AppBar(
        title: Text('FindMe'),
        actions: [
          Icon(Icons.notifications_on),
          SizedBox(
            width: MediaQuery.of(context).size.width * .05,
          )
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
                icon: Icon(Icons.timelapse_outlined),
                label: 'Latest Lost'),
            BottomNavigationBarItem(
                backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                icon: Icon(Icons.chat_outlined),
                label: 'ChatBot'),
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
