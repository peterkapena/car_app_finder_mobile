import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier with ChangeNotifier {
  final String _key = 'email';
  String? _email = "";
  String? get email => _email;

  AuthNotifier() {
    _loadFromPrefs();
  }

  Future<void> setAuth() async {
    await _savePrefs();
    notifyListeners();
  }

  _loadFromPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    _email = prefs.getString(_key);
    notifyListeners();
  }

  _savePrefs() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, _email ?? "");
  }
}
