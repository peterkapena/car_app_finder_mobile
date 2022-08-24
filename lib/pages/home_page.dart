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
            onPressed: () {
              // FirebaseAuth.instance.signOut();
            },
            color: Colors.deepPurple[200],
            child: const Text("SIGN OUT"),
          )
        ],
      )), //user.Email
    );
  }
}
