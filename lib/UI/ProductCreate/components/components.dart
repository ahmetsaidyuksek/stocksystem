import 'package:flutter/material.dart';

class ProductCreateComponents {
  AppBar appBar({required BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.teal.shade300,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
      ),
      title: const Text(
        "Product Create",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
