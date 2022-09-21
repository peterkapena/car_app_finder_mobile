import 'package:car_app_finder_mobile/auth_change_modifier.dart';
import 'package:car_app_finder_mobile/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'theme_change_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => ThemeNotifier(),
        child: ChangeNotifierProvider(
          create: (BuildContext context) => AuthNotifier(),
          child: Consumer<ThemeNotifier>(
              builder: (context, value, child) => MaterialApp(
                  theme: theme(value.isLightTheme),
                  debugShowCheckedModeBanner: false,
                  home: Consumer<AuthNotifier>(
                      builder: ((context, value, child) => value.email!.isEmpty
                          ? const AuthPage()
                          : const HomePage())))),
        ));
  }
}
