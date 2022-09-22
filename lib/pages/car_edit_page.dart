import 'package:car_app_finder_mobile/models/car.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common.dart';
import '../widget/text_input.dart';

class CarEditPage extends StatefulWidget {
  final Car car;
  const CarEditPage({super.key, required this.car});

  @override
  State<CarEditPage> createState() => _CarEditPageState();
}

class _CarEditPageState extends State<CarEditPage> {
  final _formKey = GlobalKey<FormState>();
  bool _processing = false;
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

  Future validateThenSubmit() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _processing = !_processing;
        });
        showNotice(context, "Editing car..");
        await submit();
      }
    } catch (e) {
      if (kDebugMode) print(e);
      setState(() {
        _processing = !_processing;
      });
      showNotice(context, e.toString());
    }
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
                  //heloo again!
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                        vertical: authBtnVerticalPadding),
                    child: Text(
                      widget.car.name,
                      style: GoogleFonts.bebasNeue(fontSize: 36),
                    ),
                  ),

                  //email textfield
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: authBtnHorizontalPadding,
                          vertical: authBtnVerticalPadding),
                      child: TextInput(
                        enabled: !_processing,
                        controller: _nameController,
                        // validator: validateEmail,
                        hintText: "Car name",
                        prefixIcon: const Icon(Icons.car_repair_outlined),
                        required: true,
                      )),
                  //password textfield
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                      ),
                      child: TextInput(
                          prefixIcon: const Icon(Icons.gps_fixed),
                          enabled: !_processing,
                          controller: _trackerIdController,
                          required: true,
                          // validator: (value) => validatePassword(value),
                          hintText: "Tracker id")),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 30),
                      // backgroundColor: Theme.of(context).primaryColor, //<-- SEE HERE
                    ),
                    onPressed: _processing ? null : validateThenSubmit,
                    child: const Text(
                      "Save",
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
