import 'package:car_app_finder_mobile/common.dart';
import 'package:car_app_finder_mobile/pages/car_page.dart';
import 'package:car_app_finder_mobile/services/firease.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/car.dart';
import 'add_a_car_page.dart';
import 'map_page.dart';
import 'settings_page.dart';

enum CarQuery { userId }

extension on Query<Car> {
  /// Create a firebase query from a [CarQuery]
  Query<Car> queryBy(CarQuery query) {
    switch (query) {
      case CarQuery.userId:
        var user = FirebaseAuth.instance.currentUser;
        return where('userId', isEqualTo: user!.uid);
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final carsRef = FirebaseFirestore.instance
      .collection(carCollectionName)
      .withConverter<Car>(
        fromFirestore: (snapshots, _) => Car.fromJson(snapshots.data()!),
        toFirestore: (car, _) => car.toJson(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddAcarPage()));
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(title: const Text("Car Finding System"), actions: [
          IconButton(
              onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()),
                  )),
              icon: const Icon(Icons.settings))
        ]),
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
                    "Press on the car for directions to that car.",
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
                FirebaseAuth.instance.currentUser == null
                    ? Container()
                    : Expanded(
                        child: SizedBox(
                          child: StreamBuilder<QuerySnapshot<Car>>(
                            stream: carsRef
                                .queryBy(
                                  CarQuery.userId,
                                )
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              }

                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              final data = snapshot.requireData;

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Divider(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: data.size,
                                  itemBuilder: (context, index) {
                                    final car = data.docs[index].data();

                                    return ListTile(
                                        iconColor:
                                            Theme.of(context).primaryColor,
                                        leading: const Icon(
                                            Icons.car_crash_outlined),
                                        trailing: const Icon(Icons.gps_fixed),
                                        title: Text(car.name),
                                        onLongPress: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CarPage(
                                                car: car,
                                              ),
                                            )),
                                        onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MapPage(
                                                        url: testWebViewUrl,
                                                      )),
                                            ));
                                  },
                                ),
                              );
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
