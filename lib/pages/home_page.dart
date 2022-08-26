import 'package:car_app_finder_mobile/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("data"),
          MaterialButton(
            onPressed: signout,
            color: Colors.deepPurple[200],
            child: const Text("SIGN OUT"),
          )
        ],
      )), //user.Email
    );
  }

  Future signout() async {
    try {
      showLoading(context);
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;

      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }
}
