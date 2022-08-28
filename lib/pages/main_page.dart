import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_change_modifier.dart';
import '../common.dart';
import '../pages/home_page.dart';
import 'forgot_password_page.dart';
import 'login_page.dart';
import 'register_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthNotifier>(
          builder: ((context, value, child) =>
              value.isLoggedIn ? const HomePage() : const AuthPage())),
    );
  }
}

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
