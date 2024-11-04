import 'package:flutter/material.dart';

InputDecoration inputDecoration(String hint, String label, TextEditingController controller) {
  return InputDecoration(
    labelStyle: const TextStyle(
        color: Colors.white
    ),
    hintStyle: const TextStyle(
        color: Colors.white
    ),
    hintText: hint,
    labelText: label,
  );
}

ButtonStyle buttonStyle(Color? color) {
  return ButtonStyle(
    padding: WidgetStateProperty.resolveWith((states) => const EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 15)),
      backgroundColor: WidgetStateProperty.resolveWith((states) => color),
      shape: WidgetStateProperty.resolveWith((states) =>
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))));
}
const editorTextStyle = TextStyle(
    fontSize: 18, color: Colors.black54, fontWeight: FontWeight.normal);
const hintTextStyle = TextStyle(
    fontSize: 18, color: Colors.teal, fontWeight: FontWeight.normal);