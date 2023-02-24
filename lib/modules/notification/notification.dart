// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Notification_Screen extends StatelessWidget {
  const Notification_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Notification Screen",style:Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}