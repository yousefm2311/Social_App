// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_social_app/modules/edit_profile/edit_profile.dart';
import 'package:firebase_social_app/modules/home/cubit/cubit.dart';
import 'package:firebase_social_app/modules/home/cubit/states.dart';
import 'package:firebase_social_app/shared/components/components.dart';
import 'package:firebase_social_app/shared/components/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings_Screen extends StatelessWidget {
  const Settings_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit, SocialHomeState>(
      builder: (context, state) {
        SocialHomeCubit cubit = SocialHomeCubit.get(context);
        return ConditionalBuilder(
          condition: state is! SocialGetLoadingState,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 270,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 220.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage("${cubit.userModel!.cover}"),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 110.0,
                          height: 110.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              color: Theme.of(context).scaffoldBackgroundColor),
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundImage:
                                NetworkImage('${cubit.userModel!.image}'),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${cubit.userModel!.name}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '${cubit.userModel!.bio}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: const [Text('100'), Text('Posts')],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: const [Text('250'), Text('Photos')],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: const [Text('10k'), Text('Follower')],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: const [Text('20'), Text('Following')],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("Add Photo"),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          navigatTo(context, EditProfile());
                        },
                        child: const Icon(
                          IconBroken.Edit,
                          size: 20.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
