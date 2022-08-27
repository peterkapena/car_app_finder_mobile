import 'package:car_app_finder_mobile/widget/auth_button.dart';
import 'package:car_app_finder_mobile/widget/text_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                        controller: _emailController,
                        hintText: "Email",
                        required: true,
                      )),
                  //password textfield
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: authBtnHorizontalPadding,
                          vertical: authBtnVerticalPadding),
                      child: TextInput(
                          controller: _passwordController,
                          required: true,
                          hintText: "Password",
                          obscureText: true)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                        vertical: authBtnVerticalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              widget.toggleScreen(EAuthPage.forgotPassword),
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  //sign in button
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: authBtnHorizontalPadding,
                          vertical: authBtnVerticalPadding),
                      child: AuthButon(
                        onTap: signIn,
                        text: "LOG IN",
                      )),

                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Not a member? ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => widget.toggleScreen(EAuthPage.register),
                        child: const Text(
                          " Register now",
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
      ),
    );
  }

  Future signIn() async {
    try {
      if (_formKey.currentState!.validate()) {
        showLoading(context);
        await Future.delayed(const Duration(seconds: 1));
        // await FirebaseAuth.instance
        //     .signInWithEmailAndPassword(
        //         email: _emailController.text.trim(),
        //         password: _passwordController.text.trim())
        //     .then((value) => Navigator.of(context).pop());

        if (!mounted) return;
        hideSnackBar(context);
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      showNotice(context, e.toString());
    }
  }
}
