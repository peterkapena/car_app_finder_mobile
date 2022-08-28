import 'package:flutter/material.dart';

class MyCarsPage extends StatefulWidget {
  const MyCarsPage({super.key});

  @override
  State<MyCarsPage> createState() => _MyCarsPageState();
}

class _MyCarsPageState extends State<MyCarsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SizedBox(child: Center(child: Text("MyCarsPage"))));
  }
}
