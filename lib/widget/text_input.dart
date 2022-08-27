import 'package:flutter/material.dart';

import '../common.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final int maxLength;
  final int maxLines;
  final bool required;

  const TextInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.maxLength = 200,
    this.maxLines = 1,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      style: const TextStyle(
        fontSize: textFontSize,
      ),
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Theme.of(context).splashColor),
      validator: (value) {
        if (required && (value == null || value.isEmpty)) {
          return 'Please enter some text';
        }
        if (validator != null) validator!(value);
        return null;
      },
    );
  }
}
