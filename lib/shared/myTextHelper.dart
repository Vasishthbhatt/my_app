import 'package:flutter/material.dart';

class MyTextHelper {
  static myTextButtonText(String text) {
    return Text(
      text,
      style: const TextStyle(decoration: TextDecoration.underline),
    );
  }

  static loginSignUpHeadinText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 50,
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 21, 107, 255)),
    );
  }
}
