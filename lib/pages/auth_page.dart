import 'package:car_app_finder_mobile/pages/forgot_password_page.dart';
import 'package:car_app_finder_mobile/pages/register_page.dart';
import 'package:flutter/cupertino.dart';

import '../common.dart';
import 'login_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  void showRegisterPage() {}
  EAuthPage authPage = EAuthPage.login;
  bool showLoginPage = true;
  void toggleScreen(authPage) {
    setState(() {
      this.authPage = authPage;
      //   showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authPage) {
      case EAuthPage.login:
        return LoginPage(toggleScreen: toggleScreen);
      case EAuthPage.register:
        return RegisterPage(toggleScreen: toggleScreen);
      case EAuthPage.forgotPassword:
        return ForgotPasswordPage(toggleScreen: toggleScreen);
      default:
        throw Exception("No auth page specified");
    }
  }
}
