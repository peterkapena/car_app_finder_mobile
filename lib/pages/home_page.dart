import 'package:car_app_finder_mobile/auth_change_modifier.dart';
import 'package:car_app_finder_mobile/common.dart';
import 'package:car_app_finder_mobile/models/car.dart';
import 'package:car_app_finder_mobile/models/response_error.dart';
import 'package:car_app_finder_mobile/models/user.dart';
import 'package:car_app_finder_mobile/pages/car_page.dart';
import 'package:car_app_finder_mobile/pages/map_page.dart';
import 'package:car_app_finder_mobile/services/car_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'add_a_car_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;
  final CarApiService _carApiService = CarApiService();

  @override
  void initState() {
    _setUser();
    super.initState();
  }

  _setUser() {
    _user = Provider.of<AuthNotifier>(context, listen: false).user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddAcarPage()))
              .then((res) => setState(() {
                    setState(() {});
                  }));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text("Car Finding System"), actions: [
        IconButton(
            onPressed: (() => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                )),
            icon: const Icon(Icons.settings))
      ]),
      body: SafeArea(
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          const ListTile(
            leading: Icon(Icons.info),
            title: Text(
              "Swipe any direction to delete.",
              style: TextStyle(fontSize: textFontSize),
            ),
          ),
          _user == null
              ? Container()
              : Expanded(
                  child: SizedBox(
                  child: FutureBuilder<List<Car>>(
                    future: _carApiService.getCars(_user!.id ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final data = snapshot.requireData;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 15),
                        child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(
                                      thickness: 1.5,
                                      color: Theme.of(context).primaryColor,
                                    ),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final car = data[index];

                              return Dismissible(
                                  background: Container(
                                    color: Theme.of(context).errorColor,
                                  ),
                                  key: UniqueKey(),
                                  onDismissed: (DismissDirection direction) {
                                    _carApiService
                                        .deleteCar(car.trackerSerialNumber)
                                        .then((value) => setState(() {}));
                                  },
                                  child: ListTile(
                                      iconColor: Theme.of(context).primaryColor,
                                      leading: CircleAvatar(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: const Icon(Icons.garage),
                                      ),
                                      trailing: const Icon(Icons.directions),
                                      title: Text(car.name),
                                      onLongPress: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CarPage(
                                              car: car,
                                            ),
                                          )),
                                      onTap: () {
                                        goToMapMage(car);
                                      }));
                            }),
                      );
                    },
                  ),
                ))
        ])),
      ),
    );
  }

  Future goToMapMage(Car car) async {
    try {
      var coord = await _carApiService.getRecentCoord(car.trackerSerialNumber);
      if (coord.isEmpty) {
        if (mounted) {
          showNotice(context, "There is no coordinate info yet for this car");
        }
        return;
      }

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return MapPage(
              car: car,
              initialCoord: coord,
            );
          }),
        );
      }
    } on ServiceValidationException catch (e) {
      if (kDebugMode) print(e);

      showNotice(context, e.toString());
    } catch (e) {
      showNotice(context, e.toString());
    }
  }
}
