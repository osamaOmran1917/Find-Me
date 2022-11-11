import 'package:find_me_ii/ui/home/home_screen.dart';

import '../../base/base.dart';

abstract class HomeNavigator extends BaseNavigator {}

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  void onTabSelected(index) {
    HomeScreen.selectedIndex = index;
  }
}
