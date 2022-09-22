import 'package:car_app_finder_mobile/auth_change_modifier.dart';
import 'package:car_app_finder_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User? _user;

  @override
  void initState() {
    _setUser();
    super.initState();
  }

  _setUser() {
    _user = Provider.of<AuthNotifier>(context, listen: false).user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_user?.email ?? "")),
        body: Center(
            child: SingleChildScrollView(
                child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Id:    ${_user?.id}"),
            )
          ],
        ))));
  }
}
