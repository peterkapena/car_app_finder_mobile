import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common.dart';

var digitsOnly = FilteringTextInputFormatter.digitsOnly;

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLength;
  final int maxLines;
  final bool required;
  final bool enabled;

  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

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
    this.enabled = true,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(
        fontSize: textFontSize,
      ),
      enabled: enabled,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hintText,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Theme.of(context).splashColor),
      validator: (value) {
        if (required && (value == null || value.isEmpty)) {
          return 'Please enter some text';
        }
        if (validator != null) return validator!(value);
        return null;
      },
    );
  }
}
