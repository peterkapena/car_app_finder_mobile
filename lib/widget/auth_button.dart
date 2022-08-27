import 'package:flutter/material.dart';

class AuthButon extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool enabled;
  const AuthButon(
      {super.key,
      required this.onTap,
      required this.text,
      required this.enabled});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 30),
        // backgroundColor: Theme.of(context).primaryColor, //<-- SEE HERE
      ),
      onPressed: enabled ? onTap : null,
      child: Text(
        text,
      ),
    );
  }
}
