import 'package:find_me_ii/base/base.dart';

abstract class InsertMissingPersonNavigator extends BaseNavigator {}

class InsertMissingPersonViewModel
    extends BaseViewModel<InsertMissingPersonNavigator> {
  void onAddMissingPersonClicked() {}

  void showErrorMessage() {}
}
