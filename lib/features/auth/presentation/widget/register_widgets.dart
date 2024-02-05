import 'package:flutter/material.dart';

Widget createFormFields(String label, TextEditingController controller,
    bool obscureText, IconData ico, FormFieldValidator<String> validator) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(ico),
      labelStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2.0),
      ),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 2.0)),
    ),
    validator: validator,
  );
}
