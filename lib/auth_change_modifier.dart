import 'dart:convert';

import 'package:car_app_finder_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier with ChangeNotifier {
  final String _key = 'user';
  User? _user;
  bool get isLoggedIn => _user != null;
  User? get user => _user;

  AuthNotifier() {
    _loadFromPrefs();
  }

  Future setAuth(User user) async {
    _user = user;
    var prefs = await SharedPreferences.getInstance();
    var jsn = json.encode(user);
    prefs.setString(_key, jsn);
    notifyListeners();
  }

  Future signout() async {
    _user = null;
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(_key);

    notifyListeners();
  }

  _loadFromPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    var jsnStr = prefs.getString(_key);
    if (jsnStr != null && jsnStr.isNotEmpty) {
      var jsn = json.decode(jsnStr);
      _user = User.fromJson(jsn);
    } else {
      _user = null;
    }

    notifyListeners();
  }
}
