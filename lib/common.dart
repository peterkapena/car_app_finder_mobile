import 'package:flutter/material.dart';

const authBtnHorizontalPadding = 25.0;
const authBtnVerticalPadding = 10.0;
const textFontSize = 19.0;
const testWebViewUrl =
    "https://carfinderapp-22596.web.app/?from0=-33.90898033883036&from1=18.54119705730616&to0=-33.917434553566565&to1=18.544792574809094";

enum EAuthPage { login, register, forgotPassword }

void showNotice(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        duration: const Duration(seconds: 10),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: const TextStyle(fontSize: 20),
          ),
        )),
  );
}

void showLoading(BuildContext context, [String message = "loading"]) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        duration: const Duration(hours: 1),
        content: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: const TextStyle(fontSize: 20),
            ),
          )
        ])),
  );
}

bool _isValidEmail(String? email) =>
    RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email!);

String? validatePassword(String? value, [dynamic passwordControllers]) {
  if (passwordControllers != null) {
    var passwords = (passwordControllers as List<TextEditingController>);
    if (passwords[0].text.trim() != passwords[1].text.trim()) {
      return "Passwords do not match";
    }
  }

  var length = value?.length;

  if (length != null && length <= 6) {
    return "Passwords should be 6 characters or more";
  }

  return null;
}

String? validateEmail(String? value) {
  if (!_isValidEmail(value)) return "Invalid email";
  return null;
}

Future simulate() async {
  await Future.delayed(const Duration(seconds: 5));
}
