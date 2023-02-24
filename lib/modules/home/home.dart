// ignore_for_file: unnecessary_string_interpolations

import 'package:firebase_social_app/modules/add_post/add_post.dart';
import 'package:firebase_social_app/modules/home/cubit/cubit.dart';
import 'package:firebase_social_app/modules/home/cubit/states.dart';
import 'package:firebase_social_app/shared/components/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit, SocialHomeState>(
      builder: (context, state) {
        SocialHomeCubit cubit = SocialHomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("${cubit.titleAppbar[cubit.currentIndex]}"),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(IconBroken.Notification)),
              IconButton(onPressed: () {}, icon: const Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.getWidgets[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.changeCurrentIndex(value);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: "Feeds"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: "Chats"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: "Post"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.User1), label: "Users"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: "Settings"),
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state is AddPostState) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const New_Post()));
        }
      },
    );
  }
}
