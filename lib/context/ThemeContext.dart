import 'package:esya_app_mobile/theme_preference.dart';
import 'package:flutter/material.dart';

class ThemeContext extends ChangeNotifier {
  late bool _isDark;
  late ThemePreference _preferences;
  bool get isDark => _isDark;

  ThemeContext() {
    _isDark = false;
    _preferences = ThemePreference();
    getPreferences();
  }

//Switching the themes
  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}
