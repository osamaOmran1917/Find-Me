import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String currentLang = 'en';

  void changeLanguage(String newLang) {
    if (newLang == currentLang) {
      return;
    }
    currentLang = newLang;
    notifyListeners();
  }
}
