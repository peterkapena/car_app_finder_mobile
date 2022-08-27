import 'package:flutter/material.dart';

const authBtnHorizontalPadding = 25.0;
const authBtnVerticalPadding = 10.0;
const textFontSize = 19.0;

enum EAuthPage { login, register, forgotPassword }

void showNotice(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        action: SnackBarAction(
          label: 'Undo',
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
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        duration: const Duration(seconds: 10),
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

void hideSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
