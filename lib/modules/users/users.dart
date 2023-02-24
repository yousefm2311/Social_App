// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Profile_Screen extends StatelessWidget {
  const Profile_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Profile Screen",style:Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}