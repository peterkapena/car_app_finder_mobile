import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData theme(bool isLightTheme) => ThemeData(
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      primaryColor: Colors.lime[900],
    );

class ThemeNotifier with ChangeNotifier {
  final String _key = 'theme';
  bool _isLightTheme = true;
  bool get isLightTheme => _isLightTheme;

  ThemeNotifier() {
    _isLightTheme = false;
    _loadFromPrefs();
  }

  toggleTheme() {
    _isLightTheme = !_isLightTheme;
    notifyListeners();
    _savePrefs();
  }

  _loadFromPrefs() async {
    _isLightTheme =
        (await SharedPreferences.getInstance()).getBool(_key) ?? true;
    notifyListeners();
  }

  _savePrefs() async {
    (await SharedPreferences.getInstance()).setBool(_key, _isLightTheme);
  }
}
