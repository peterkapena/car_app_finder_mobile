import 'package:car_app_finder_mobile/auth_change_modifier.dart';
import 'package:car_app_finder_mobile/models/car.dart';
import 'package:car_app_finder_mobile/models/response_error.dart';
import 'package:car_app_finder_mobile/models/user.dart';
import 'package:car_app_finder_mobile/services/car_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../common.dart';
import '../widget/text_input.dart';

class AddAcarPage extends StatefulWidget {
  const AddAcarPage({super.key});

  @override
  State<AddAcarPage> createState() => _AddAcarPageState();
}

class _AddAcarPageState extends State<AddAcarPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _trackerIdController = TextEditingController();
  bool _processing = false;
  User? _user;
  CarApiService carApiService = CarApiService();

  @override
  void initState() {
    _setUser();
    super.initState();
  }

  _setUser() {
    _user = Provider.of<AuthNotifier>(context, listen: false).user;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _trackerIdController.dispose();
    super.dispose();
  }

  Future submit() async {
    var car = Car(
        trackerSerialNumber: _trackerIdController.text.trim(),
        name: _nameController.text.trim(),
        userId: _user?.id ?? "");
    car = await carApiService.addCar(car);

    if (mounted) showNotice(context, "The car has been added");
  }

  Future validateThenSubmit() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _processing = !_processing;
        });
        showNotice(context, "Adding car..");
        await submit();
      }
    } on ServiceValidationException catch (e) {
      if (kDebugMode) print(e);
      setState(() {
        _processing = !_processing;
      });
      showNotice(context, e.toString());
    } catch (e) {
      showNotice(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add a new car"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.car_repair,
                    size: 100,
                  ),
                  //heloo again!
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                        vertical: authBtnVerticalPadding),
                    child: Text(
                      "Add a new car",
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
                      "Submit",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
