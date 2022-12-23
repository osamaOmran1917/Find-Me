import 'package:flutter/material.dart';

abstract class CompleteUserInfoNavigator {
  void goToHome();
}

class CompleteUserInfoViewModel extends ChangeNotifier {
  CompleteUserInfoNavigator? navigator;

  void onSkipPrsd() {
    navigator?.goToHome();
  }
}
