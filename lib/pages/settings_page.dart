import 'package:firebase_auth/firebase_auth.dart';
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
  Future<void> logout() async {
    try {
      showLoading(context);
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        await Provider.of<AuthNotifier>(context, listen: false).toggleAuth();
      }
    } catch (e) {
      showNotice(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var settings = [
      ListTile(
        iconColor: Theme.of(context).primaryColor,
        leading: const Icon(Icons.logout),
        onTap: logout,
        title: const Text("Log out"),
      ),
      ListTile(
        iconColor: Theme.of(context).primaryColor,
        leading: const Icon(Icons.light_mode_outlined),
        onTap: () async =>
            await Provider.of<ThemeNotifier>(context, listen: false)
                .toggleTheme(),
        title: const Text("Switch theme"),
      )
    ];

    return Scaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: ListView.separated(
            itemCount: settings.length,
            separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Theme.of(context).primaryColor,
                ),
            itemBuilder: (BuildContext context, int index) => settings[index]));
  }
}
