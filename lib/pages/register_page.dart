import 'package:car_app_finder_mobile/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../auth_change_modifier.dart';
import '../common.dart';
import '../widget/auth_button.dart';
import '../widget/text_input.dart';

class RegisterPage extends StatefulWidget {
  final void Function(EAuthPage) toggleScreen;
  const RegisterPage({
    super.key,
    required this.toggleScreen,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _processing = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> gotoHomePage() async {
    if (mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      await Provider.of<AuthNotifier>(context, listen: false).setAuth(true);
    }
  }

  Future register() async {
    try {
      if (_formKey.currentState!.validate()) {
        _processing = !_processing;
        showLoading(context);
        await Future.delayed(const Duration(seconds: 3));

        var user = UserApiService()
            .login(XUser(password: _passwordController.text.trim(),
            email: _emailController.text.trim(),
            tokenForAnonymous: ));

        if (user != null) {
          await gotoHomePage();
          return;
        } else if (mounted) {
          showNotice(
              context, "Registration failed. Please contact support for help.");
        }
      }
    } catch (e) {
      showNotice(context, e.toString());
      _processing = !_processing;
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
                    Icons.android,
                    size: 100,
                  ),
                  //heloo again!
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                        vertical: authBtnVerticalPadding),
                    child: Text(
                      "Hello There",
                      style: GoogleFonts.bebasNeue(fontSize: 36),
                    ),
                  ),
                  const Text(
                    "Register below with your details!",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                        vertical: authBtnVerticalPadding),
                    child: TextInput(
                      validator: validateEmail,
                      controller: _emailController,
                      hintText: "Email",
                      enabled: !_processing,
                      required: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                        vertical: authBtnVerticalPadding),
                    child: TextInput(
                      validator: (value) => validatePassword(value,
                          [_passwordController, _confirmPasswordController]),
                      controller: _passwordController,
                      hintText: "Password",
                      obscureText: true,
                      enabled: !_processing,
                      required: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                        vertical: authBtnVerticalPadding),
                    child: TextInput(
                      validator: (value) => validatePassword(value,
                          [_passwordController, _confirmPasswordController]),
                      controller: _confirmPasswordController,
                      hintText: "Confirm password",
                      obscureText: true,
                      required: true,
                      enabled: !_processing,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: authBtnHorizontalPadding,
                          vertical: authBtnVerticalPadding),
                      child: AuthButon(
                        enabled: !_processing,
                        onTap: register,
                        text: "Register",
                      )),

                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already registered? ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () => widget.toggleScreen(EAuthPage.login),
                          child: const Text(
                            "Log in now",
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
