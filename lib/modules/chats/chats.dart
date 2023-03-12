// ignore_for_file: camel_case_types

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_social_app/models/chat_model.dart';
import 'package:firebase_social_app/models/user_model.dart';
import 'package:firebase_social_app/modules/chat_details/chat_details.dart';
import 'package:firebase_social_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/cubit/cubit.dart';
import '../home/cubit/states.dart';

class Chat_Screen extends StatelessWidget {
  const Chat_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit, SocialHomeState>(
      builder: (context, state) {
        SocialHomeCubit cubit = SocialHomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.allUser.isNotEmpty,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buidChatItem(cubit.allUser[index], context),
              separatorBuilder: (context, index) => const Divider(
                    endIndent: 20,
                    indent: 20,
                  ),
              itemCount: cubit.allUser.length),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buidChatItem(SocialUserModel model, context) => InkWell(
        onTap: () {
          navigatTo(
              context,
              ChatDetails(
                model: model,
              ));
        },
        child: Padding(
          padding:
              const EdgeInsets.only(top: 5, bottom: 5, right: 20, left: 20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              const SizedBox(width: 15.0),
              Text(
                ' ${model.name}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      );
}
