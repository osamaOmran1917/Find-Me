import 'package:find_me_ii/base/base.dart';

abstract class HomeTabNavigator extends BaseNavigator {
  void goToSearchScreen();

  void goToInsertMissingPersonScreen();
}

class HomeTabViewModel extends BaseViewModel<HomeTabNavigator> {
  void onFindPersonClicked() {
    navigator?.goToSearchScreen();
  }

  void onInsertMissingPersonClicked() {
    navigator?.goToInsertMissingPersonScreen();
  }
}
