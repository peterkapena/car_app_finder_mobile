import 'package:car_app_finder_mobile/auth_change_modifier.dart';
import 'package:car_app_finder_mobile/common.dart';
import 'package:car_app_finder_mobile/models/tracker.dart';
import 'package:car_app_finder_mobile/models/user.dart';
import 'package:car_app_finder_mobile/pages/car_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/car.dart';
import 'add_a_car_page.dart';
import 'map_page.dart';
import 'settings_page.dart';

// extension on Query<Car> {
//   /// Create a firebase query from a [CarQuery]
//   Query<Car> queryBy(CarQuery query) {
//     switch (query) {
//       case CarQuery.userId:
//         var user = FirebaseAuth.instance.currentUser;
//         return where('userId', isEqualTo: user!.uid);
//     }
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;

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
          // trackerRef.doc("QXWTayAEqQSpjQvGgWFh").get().then((value) {
          //   print(value.data());
          // });
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
                      child: Container(
                  child: Text(_user?.email ?? ""),
                )
                      // StreamBuilder<QuerySnapshot<Car>>(
                      //   stream: carsRef
                      //       .queryBy(
                      //         CarQuery.userId,
                      //       )
                      //       .snapshots(),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasError) {
                      //       return Center(
                      //         child: Text(snapshot.error.toString()),
                      //       );
                      //     }

                      //     if (!snapshot.hasData) {
                      //       return const Center(child: CircularProgressIndicator());
                      //     }

                      //     final data = snapshot.requireData;

                      //     return Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 18, horizontal: 15),
                      //       child: ListView.separated(
                      //           separatorBuilder:
                      //               (BuildContext context, int index) => Divider(
                      //                     thickness: 1.5,
                      //                     color: Theme.of(context).primaryColor,
                      //                   ),
                      //           shrinkWrap: true,
                      //           itemCount: data.size,
                      //           itemBuilder: (context, index) {
                      //             final car = data.docs[index].data();

                      //             return Dismissible(
                      //                 background: Container(
                      //                   color: Theme.of(context).errorColor,
                      //                 ),
                      //                 key: ValueKey<Car>(car),
                      //                 onDismissed: (DismissDirection direction) {
                      //                   carsRef
                      //                       .doc(car.id)
                      //                       .delete()
                      //                       .then((value) => setState(() {}));
                      //                 },
                      //                 child: ListTile(
                      //                     iconColor: Theme.of(context).primaryColor,
                      //                     leading: CircleAvatar(
                      //                       backgroundColor:
                      //                           Theme.of(context).primaryColor,
                      //                       child: const Icon(Icons.garage),
                      //                     ),
                      //                     trailing: const Icon(Icons.directions),
                      //                     title: Text(car.name),
                      //                     onLongPress: () => Navigator.push(
                      //                         context,
                      //                         MaterialPageRoute(
                      //                           builder: (context) => CarPage(
                      //                             car: car,
                      //                           ),
                      //                         )),
                      //                     onTap: () {
                      //                       // var rr = trackerRef
                      //                       //     .doc("QXWTayAEqQSpjQvGgWFh")
                      //                       //     .get()
                      //                       //     .then((value) {

                      //                       Tracker tracker = Tracker("drr.id",
                      //                           "-33.934657179940366, 18.406920104103524");

                      //                       Navigator.push(
                      //                         context,
                      //                         MaterialPageRoute(builder: (context) {
                      //                           return MapPage(
                      //                             tracker: tracker,
                      //                           );
                      //                         }),
                      //                       );
                      //                     }));
                      //           }),
                      //     );
                      //   },
                      // ),
                      ))
        ])),
      ),
    );
  }
}
