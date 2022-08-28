import 'package:car_app_finder_mobile/auth_change_modifier.dart';
import 'package:car_app_finder_mobile/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'theme_change_notifier.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
                      builder: ((context, value, child) => value.isLoggedIn
                          ? const HomePage()
                          : const AuthPage())))),
        ));

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(),
    //   home: const MainPage(),
    // );
  }
}
