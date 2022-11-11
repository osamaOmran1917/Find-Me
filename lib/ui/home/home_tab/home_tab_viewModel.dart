import '../../../base/base.dart';

abstract class HomeTabNavigator extends BaseNavigator {
  void goToSearchScreen();
}

class HomeTabViewModel extends BaseViewModel<HomeTabNavigator> {
  void onFindPersonClicked() {
    navigator?.goToSearchScreen();
  }
}
