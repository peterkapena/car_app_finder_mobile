import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future register() async {
    try {
      showLoading(context);

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) => Navigator.of(context).pop());

      if (!mounted) return;

      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      showNotice(context, e.toString());
    }
  }

  bool passwordConfirmed() {
    return _confirmPasswordController.text.trim() ==
        _passwordController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: authBtnHorizontalPadding,
                      vertical: authBtnVerticalPadding),
                  child: TextInput(
                    controller: _emailController,
                    hintText: "Email",
                    required: true,
                  ),
                ),
                //password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: authBtnHorizontalPadding,
                      vertical: authBtnVerticalPadding),
                  child: TextInput(
                    controller: _passwordController,
                    hintText: "Password",
                    obscureText: true,
                    required: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: authBtnHorizontalPadding,
                      vertical: authBtnVerticalPadding),
                  child: TextInput(
                    controller: _confirmPasswordController,
                    hintText: "Confirm password",
                    obscureText: true,
                    required: true,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                        vertical: authBtnVerticalPadding),
                    child: AuthButon(
                      onTap: register,
                      text: "REGISTER",
                    )),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already registered? ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => widget.toggleScreen(EAuthPage.login),
                      child: const Text(
                        " Log in now",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
