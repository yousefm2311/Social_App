// ignore_for_file: camel_case_types

import 'package:firebase_social_app/modules/home/cubit/cubit.dart';
import 'package:firebase_social_app/modules/home/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile_Screen extends StatelessWidget {
  const Profile_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit, SocialHomeState>(
      builder: (context, state) {
        // ignore: unused_local_variable
        SocialHomeCubit cubit = SocialHomeCubit.get(context);
        return Scaffold(
          body: Column(
            children: [
              Row(
                children: const [
                  CircleAvatar(
                    radius: 30.0,
                  ),
                  
                ],
              )
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
