// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Chat_Screen extends StatelessWidget {
  const Chat_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Chat Screen",style:Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}