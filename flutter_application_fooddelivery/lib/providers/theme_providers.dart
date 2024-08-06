import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const themeStatus = "There Status";
  bool _darkTheme = false;
  bool get getIsDarkTheme => _darkTheme;
  ThemeProvider() {
    getTheme();
  }

  Future<void> setDarktheme({required bool themevalue}) async {
    SharedPreferences prfers = await SharedPreferences.getInstance();
    prfers.setBool(themeStatus, themevalue);
    _darkTheme = themevalue;
    notifyListeners();
  }

  Future<bool> getTheme() async {
    SharedPreferences prefers = await SharedPreferences.getInstance();
    _darkTheme = prefers.getBool(themeStatus) ?? false;
    notifyListeners();
    return _darkTheme;
  }
}
