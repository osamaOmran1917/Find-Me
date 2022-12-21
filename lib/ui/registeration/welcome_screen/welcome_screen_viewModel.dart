import 'package:flutter/material.dart';

abstract class WelcomeScreenNavigator {
  void goToCompleteInfoPage();

  void goToHome();
}

class WelcomeScreenViewModel extends ChangeNotifier {
  WelcomeScreenNavigator? navigator;

  void onCompletePrsd() {
    navigator?.goToCompleteInfoPage();
  }

  void onSkipPrsd() {
    navigator?.goToHome();
  }
}
