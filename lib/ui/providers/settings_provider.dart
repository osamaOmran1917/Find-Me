import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String currentLang = 'en';
  ThemeMode currentTheme = ThemeMode.light;

  void changeTheme(ThemeMode newTheme) async {
    final prefs = await SharedPreferences.getInstance();
    if (newTheme == currentTheme) {
      return;
    }
    currentTheme = newTheme;
    prefs.setString('theme', isDarkMode() ? 'dark' : 'light');
    notifyListeners();
  }

  void changeLanguage(String newLang) async {
    final prefs = await SharedPreferences.getInstance();
    if (newLang == currentLang) {
      return;
    }
    currentLang = newLang;
    prefs.setString('lang', currentLang);
    notifyListeners();
  }

  bool isDarkMode() {
    return currentTheme == ThemeMode.dark;
  }

  bool isArabic() {
    return currentLang == 'ar';
  }
}
