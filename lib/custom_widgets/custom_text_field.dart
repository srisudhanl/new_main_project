import 'package:flutter/material.dart';

Widget buildTextField({
  required String labelText,
  required String hintText,
  void onChanged(value)?,
  required TextInputType textInputType,
  TextEditingController? textEditingController,
  Icon? prefixIcon,
  bool isPassword = false,
}) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.grey[200],
    ),
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: TextField(
      controller: textEditingController,
      obscureText: isPassword,
      keyboardType: textInputType,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: prefixIcon,
          hintStyle: TextStyle(color: Colors.grey.shade500)),
      onChanged: onChanged,
    ),
  );
}
