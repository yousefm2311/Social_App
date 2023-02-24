// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Search_Screen extends StatelessWidget {
  const Search_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Search Screen",style:Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}