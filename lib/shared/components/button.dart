import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final textButton;
  MyButton({super.key, required this.onTap,required this.textButton});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child:  Center(
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
