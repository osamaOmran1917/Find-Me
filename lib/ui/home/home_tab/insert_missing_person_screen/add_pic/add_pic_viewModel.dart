import 'package:flutter/material.dart';

abstract class AddPicNavigator {
  void goToNewsFeed();
}

class AddPicViewModel extends ChangeNotifier {
  AddPicNavigator? navigator;

  void onSkipPrsd() {
    navigator?.goToNewsFeed();
  }
}
