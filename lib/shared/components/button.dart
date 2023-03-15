import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String textButton;
  final double heigth;
  final double margin;
  const MyButton(
      {super.key,
      required this.onTap,
      required this.textButton,
      required this.heigth, required this.margin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(heigth),
        margin:  EdgeInsets.symmetric(
          horizontal: margin,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Center(
          child: Text(
            textButton,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
