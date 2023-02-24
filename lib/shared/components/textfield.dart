// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Function(String)? onSubmit;
  final sufficIcon;
  final double padding;
  int? maxLines;
  Widget? perfexIcon;
  TextInputType? keyboardType;
  MyTextField(
      {this.keyboardType,
      this.onSubmit,
      this.maxLines,
      super.key,
      this.perfexIcon,
      this.controller,
      required this.hintText,
      required this.obscureText,
      this.sufficIcon,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextFormField(
        onFieldSubmitted: onSubmit,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: sufficIcon,
          prefixIcon: perfexIcon,
          hintStyle: TextStyle(color: Colors.grey[500]),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
      ),
    );
  }
}
