import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier with ChangeNotifier {
  final String _key = 'user';
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  AuthNotifier() {
    // _isLoggedIn = false;
    _loadFromPrefs();
  }

  Future<void> setAuth(bool isLoggedIn) async {
    _isLoggedIn = isLoggedIn;
    await _savePrefs();
    notifyListeners();
  }

  _loadFromPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(_key) ?? true;
    notifyListeners();
  }

  _savePrefs() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, _isLoggedIn);
  }
}
