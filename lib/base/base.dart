import 'package:find_me_ii/helpers/dialog_utils.dart';
import 'package:flutter/material.dart';

abstract class BaseNavigator {
  void showLoadingDialog({String message = 'Loading..'});

  void hideLoadinDialog();

  void showMessageDialog(String message);
}

class BaseViewModel<Nav extends BaseNavigator> {
  Nav? navigator;
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  VM initViewModel();

  @override
  void showLoadingDialog({String message = 'Loading..'}) {
    showLoading(context, message);
  }

  @override
  void showMessageDialog(String message) {
    showMessage(context, message);
  }

  @override
  void hideLoadinDialog() {
    hideLoading(context);
  }
}