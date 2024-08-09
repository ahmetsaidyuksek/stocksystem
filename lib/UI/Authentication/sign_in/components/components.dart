import 'package:flutter/material.dart';

class SignInComponents {
  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("Sign In"),
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

  FloatingActionButton floatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed((context), "sign_up");
      },
      icon: const Icon(Icons.person_add_alt_rounded),
      label: const Text("Create Account"),
    );
  }
}
