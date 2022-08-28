import 'package:car_app_finder_mobile/common.dart';
import 'package:car_app_finder_mobile/pages/add_a_car_page.dart';
import 'package:car_app_finder_mobile/pages/my_cars_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    MyCarsPage(),
    AddAcarPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Car Finding System"), actions: [
          IconButton(
              onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()),
                  )),
              icon: const Icon(Icons.settings))
        ]),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.car_crash),
              label: 'My cars',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add a car',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }

  Future signout() async {
    try {
      showLoading(context);
      await FirebaseAuth.instance.signOut().then((value) {
        if (mounted) ScaffoldMessenger.of(context).hideCurrentSnackBar();
      });
    } catch (e) {
      showNotice(context, e.toString());
    }
  }
}
