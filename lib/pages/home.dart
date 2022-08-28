import 'package:car_app_finder_mobile/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/car.dart';
import 'car_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Car> cars = [];

  @override
  @mustCallSuper
  void initState() {
    cars = [
      Car("Toyota", "8923823fdf#d", "723627326gfssfuhyu"),
      Car("BMW", "8923832323fdf", "723627326gfssfuhyu"),
      Car("Hundai", "8923323823fdf", "723627326gfssfuhyu")
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: authBtnHorizontalPadding,
                  vertical: authBtnVerticalPadding),
              child: Text(
                "Welcome!",
                style: GoogleFonts.bebasNeue(fontSize: 36),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.info),
              title: Text(
                "Press on the car for directions to that car .",
                style: TextStyle(fontSize: textFontSize),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.info),
              title: Text(
                "Long press to edit car.",
                style: TextStyle(fontSize: textFontSize),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: cars.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: Theme.of(context).primaryColor,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var car = cars[index];
                    return ListTile(
                        iconColor: Theme.of(context).primaryColor,
                        leading: const Icon(Icons.car_crash_outlined),
                        trailing: const Icon(Icons.gps_fixed),
                        title: Text(car.name),
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CarPage(
                                        car: car,
                                      )),
                            ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
