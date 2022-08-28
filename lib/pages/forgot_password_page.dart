import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
  bool _processing = false;
  final _formKey = GlobalKey<FormState>();

  Future passwordReset() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _processing = !_processing;
        });
        showLoading(context);
        await Future.delayed(const Duration(seconds: 1));
        await FirebaseAuth.instance
            .sendPasswordResetEmail(
              email: _emailController.text.trim(),
            )
            .then((value) => {
                  if (mounted)
                    ScaffoldMessenger.of(context).hideCurrentSnackBar()
                });
      }
    } catch (e) {
      if (kDebugMode) print(e);
      setState(() {
        _processing = !_processing;
      });
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
                    enabled: !_processing,
                    hintText: "Email",
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: authBtnHorizontalPadding,
                        vertical: authBtnVerticalPadding),
                    child: AuthButon(
                      enabled: !_processing,
                      onTap: passwordReset,
                      text: "Send",
                    )),
                TextButton(
                    onPressed: () => widget.toggleScreen(EAuthPage.login),
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
