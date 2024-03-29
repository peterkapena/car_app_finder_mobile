import 'package:car_app_finder_mobile/auth_change_modifier.dart';
import 'package:car_app_finder_mobile/models/user.dart';
import 'package:car_app_finder_mobile/services/user_service.dart';
import 'package:car_app_finder_mobile/widget/auth_button.dart';
import 'package:car_app_finder_mobile/widget/text_input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../common.dart';

class LoginPage extends StatefulWidget {
  final void Function(EAuthPage) toggleScreen;
  const LoginPage({super.key, required this.toggleScreen});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _processing = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future login() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _processing = !_processing;
        });
        showLoading(context, "Signing in..");

        var user = Provider.of<AuthNotifier>(context, listen: false).user;

        if (user != null) {
          await gotoHomePage(user);
          return;
        }

        user = await UserApiService().login(User(
          password: _passwordController.text.trim(),
          email: _emailController.text.trim(),
        ));

        if (user != null) {
          await gotoHomePage(user);
        } else if (mounted) {
          showNotice(
              context, "Log in failed. Please contact support for help.");
        }
      }
    } catch (e) {
      if (kDebugMode) print(e);
      setState(() {
        _processing = !_processing;
      });
      showNotice(context, e.toString());
    }
  }

  Future<void> gotoHomePage(User user) async {
    if (mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      await Provider.of<AuthNotifier>(context, listen: false).setAuth(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.phone_android,
                    size: 100,
                  ),
                  //heloo again!
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                        vertical: authBtnVerticalPadding),
                    child: Text(
                      "Hello Again",
                      style: GoogleFonts.bebasNeue(fontSize: 36),
                    ),
                  ),
                  const Text(
                    "Welcome back!",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //email textfield
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: authBtnHorizontalPadding,
                          vertical: authBtnVerticalPadding),
                      child: TextInput(
                        enabled: !_processing,
                        controller: _emailController,
                        validator: validateEmail,
                        hintText: "Email",
                        required: true,
                      )),
                  //password textfield
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                      ),
                      child: TextInput(
                          enabled: !_processing,
                          controller: _passwordController,
                          required: true,
                          validator: (value) => validatePassword(value),
                          hintText: "Password",
                          obscureText: true)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          // style:
                          //     TextButton.styleFrom(padding: EdgeInsets.all(0)),
                          onPressed: () =>
                              widget.toggleScreen(EAuthPage.forgotPassword),
                          child: const Text(
                            "Forgot password",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  AuthButon(
                    enabled: !_processing,
                    onTap: login,
                    text: "Log in",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Not a member? ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () =>
                              widget.toggleScreen(EAuthPage.register),
                          child: const Text(
                            "Register now",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
