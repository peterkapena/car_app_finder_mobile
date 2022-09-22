import 'package:car_app_finder_mobile/models/car.dart';
import 'package:car_app_finder_mobile/pages/car_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common.dart';
import 'history_page.dart';

class CarPage extends StatefulWidget {
  final Car car;
  const CarPage({super.key, required this.car});

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _trackerIdController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _nameController.text = widget.car.name;
      _trackerIdController.text = widget.car.trackerId;
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _trackerIdController.dispose();
    super.dispose();
  }

  Future submit() async {
    Map<String, Object?> data = {
      "name": _nameController.text.trim(),
      "trackerId": _trackerIdController.text.trim()
    };

    // await carsRef.doc(widget.car.id).update(data);
    // await simulate();

    if (mounted) showNotice(context, "The car has been updated");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Car profile"),
        ),
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.garage_outlined,
                    size: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                        vertical: authBtnVerticalPadding),
                    child: Text(
                      widget.car.name,
                      style: GoogleFonts.bebasNeue(fontSize: 36),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).splashColor,
                                  borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.all(8),
                              child: const Text(
                                "Tracker id:",
                                style: TextStyle(
                                    fontSize: textFontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).splashColor,
                                  borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                widget.car.trackerId,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          onPressed: (() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoryPage(
                                          carId: widget.car.id,
                                          trackerId: widget.car.trackerId,
                                        )),
                              )),
                          child: const Text(
                            "History",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          onPressed: (() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CarEditPage(car: widget.car)),
                              )),
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Theme.of(context).errorColor,
                          ),
                          onPressed: () {
                            // carsRef.doc(widget.car.id).delete();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
