// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
showFLutterToast(String error, {required color,required String  text}) {
  Fluttertoast.showToast(
      msg: "${text}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:chooseColor(color),
      textColor: Colors.white,
      fontSize: 16.0);
}


enum ToastColor { SUCCESS, ERROR, WANING }

Color chooseColor(ToastColor state) {
  Color color;
  switch (state) {
    case ToastColor.SUCCESS:
      color = Colors.green;
      break;
    case ToastColor.ERROR:
      color = Colors.redAccent;
      break;
    case ToastColor.WANING:
      color = Colors.red;
      break;
  }
  return color;
}
