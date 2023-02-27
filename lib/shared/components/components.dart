// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, avoid_types_as_parameter_names

import 'package:firebase_social_app/shared/components/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showFLutterToast(String error, {required color, required String text}) {
  Fluttertoast.showToast(
      msg: "${text}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseColor(color),
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

Widget defalutTages({
  required String text,
  required Function() onTap,
}) =>
    Padding(
      padding: const EdgeInsetsDirectional.only(end: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );

defaultAppBar({
  required String title,
  required BuildContext context,
  List<Widget>? action,
}) =>
    AppBar(
      leading: IconButton(
        icon: const Icon(IconBroken.Arrow___Left_2),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(title),
      actions: action,
    );

Widget defaultTextButton({
  required String text,
  required Function() onTap,
}) =>
    TextButton(
      onPressed: onTap,
      child:  Text(text),
    );

void navigatTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void navigatAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Widget),
      ((Route<dynamic> route) => false),
    );
