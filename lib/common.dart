import 'package:flutter/material.dart';

const authBtnHorizontalPadding = 25.0;
const authBtnVerticalPadding = 10.0;

enum EAuthPage { login, register, forgotPassword }

void showNotice(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (bui) {
        return Center(child: Text(message));
      });
}

void showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (bui) {
        return const Center(child: CircularProgressIndicator());
      });
}
