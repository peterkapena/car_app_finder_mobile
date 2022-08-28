import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_change_modifier.dart';
import '../common.dart';
import '../theme_change_notifier.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> logout(Future<void> Function() toggleAuth) async {
    try {
      showLoading(context);
      // Future.delayed(const Duration(seconds: 5)).then((value) =>
      //     {if (mounted) ScaffoldMessenger.of(context).hideCurrentSnackBar()});
      await FirebaseAuth.instance.signOut();
      if (mounted) ScaffoldMessenger.of(context).hideCurrentSnackBar();
      await toggleAuth();
    } catch (e) {
      showNotice(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var settings = [
      Consumer<AuthNotifier>(
          builder: ((context, value, child) => ListTile(
                iconColor: Theme.of(context).primaryColor,
                leading: const Icon(Icons.logout),
                onTap: () => logout(value.toggleAuth),
                title: const Text("Log out"),
              ))),
      Consumer<ThemeNotifier>(
          builder: (context, notifier, child) => ListTile(
                iconColor: Theme.of(context).primaryColor,
                leading: const Icon(Icons.light_mode_outlined),
                onTap: notifier.toggleTheme,
                title: const Text("Switch theme"),
              ))
    ];

    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        body: Container(
            child: ListView.separated(
                itemCount: settings.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                      color: Theme.of(context).primaryColor,
                    ),
                itemBuilder: (BuildContext context, int index) =>
                    settings[index])));
  }
}
