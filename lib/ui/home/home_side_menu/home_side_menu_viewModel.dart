import 'package:flutter/material.dart';

abstract class HomeSideMenuNavigator {
  void goToManageAccPage();

  void goToAboutUsPage();

  void goToContactUsPage();
}

class HomeSideMenuViewModel extends ChangeNotifier {
  HomeSideMenuNavigator? navigator;

  void onManageAccPrsd() {
    navigator?.goToManageAccPage();
  }

  void onAboutUsPrsd() {
    navigator?.goToAboutUsPage();
  }

  void onContactUsPrsd() {
    navigator?.goToContactUsPage();
  }
}