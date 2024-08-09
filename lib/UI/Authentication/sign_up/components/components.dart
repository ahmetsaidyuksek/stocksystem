import 'package:flutter/material.dart';

class SignUpComponents {
  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      title: const Text("Sign Up"),
    );
  }

  TextFormField textFormField({
    required TextEditingController textEditingController,
    required String hintText,
    required String label,
    required bool obscureText,
    required bool autofocus,
    required TextInputAction textInputAction,
    required TextInputType textInputType,
  }) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscureText,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.always,
      autofocus: autofocus,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        label: Text(label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
