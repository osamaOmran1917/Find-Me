import 'package:find_me_ii/ui/home/home_side_menu.dart';
import 'package:find_me_ii/ui/home/settings_tab/settings_tab.dart';
import 'package:flutter/material.dart';

import 'home_tab/home_tab.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'Home Screen';
  int selectedIndex = 0;
  List<Widget> tabs = [HomeTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: HomeSideMenu(),
      ),
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
