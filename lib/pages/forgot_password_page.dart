import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common.dart';
import '../widget/auth_button.dart';
import '../widget/text_input.dart';

class ForgotPasswordPage extends StatefulWidget {
  final void Function(EAuthPage) toggleScreen;

  const ForgotPasswordPage({
    super.key,
    required this.toggleScreen,
  });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  Future passwordReset() async {
    try {
      showLoading(context);

      await FirebaseAuth.instance
          .sendPasswordResetEmail(
            email: _emailController.text.trim(),
          )
          .then((value) => Navigator.of(context).pop());

      if (!mounted) return;

      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      showNotice(context, e.toString());
    }
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
                  Icons.password,
                  size: 100,
                ),
                //heloo again!
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: authBtnHorizontalPadding,
                      vertical: authBtnVerticalPadding),
                  child: Text(
                    "Welcome!",
                    style: GoogleFonts.bebasNeue(fontSize: 36),
                  ),
                ),
                const Text(
                  "Enter your email and we will send a password reset link!",
                  textAlign: TextAlign.center,
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
                    required: true,
                    controller: _emailController,
                    hintText: "Email",
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                        vertical: authBtnVerticalPadding),
                    child: AuthButon(
                      onTap: passwordReset,
                      text: "RESET PASSWORD",
                    )),
                GestureDetector(
                  onTap: () => widget.toggleScreen(EAuthPage.login),
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
