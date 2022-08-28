import 'package:car_app_finder_mobile/models/car.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common.dart';

class CarPage extends StatefulWidget {
  final Car car;
  const CarPage({super.key, required this.car});

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.car.name)),
        body: SafeArea(
            child: Center(
                child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: authBtnHorizontalPadding,
                vertical: authBtnVerticalPadding),
            child: Text(
              widget.car.name,
              style: GoogleFonts.bebasNeue(fontSize: 36),
            ),
          ),
        ]))));
  }
}
