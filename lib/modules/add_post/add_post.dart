// ignore_for_file: camel_case_types, must_be_immutable

import 'package:firebase_social_app/modules/home/cubit/cubit.dart';
import 'package:firebase_social_app/modules/home/cubit/states.dart';
import 'package:firebase_social_app/shared/components/components.dart';
import 'package:firebase_social_app/shared/components/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class New_Post extends StatelessWidget {
  New_Post({super.key});

  var postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit, SocialHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          SocialHomeCubit cubit = SocialHomeCubit.get(context);

          var dateNow = DateTime.now();
          return Scaffold(
            appBar: defaultAppBar(
              title: "New Post",
              context: context,
              action: [
                defaultTextButton(
                  text: 'Post',
                  onTap: () {
                    if (cubit.postImage == null) {
                      cubit.createPost(
                          text: postController.text,
                          dateTime: dateNow.toString());
                    } else {
                      cubit.createNewPostImage(
                          dateTime: dateNow.toString(),
                          text: postController.text);
                    }
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is CreateNewPostLoadingState)
                    const LinearProgressIndicator(),
                  if (state is CreateNewPostLoadingState)
                    const SizedBox(height: 10.0),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                            NetworkImage('${cubit.userModel!.image}'),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Text(
                          '${cubit.userModel!.name}',
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: postController,
                      decoration: const InputDecoration(
                        hintText: 'what is your mind ...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (cubit.postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 200.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(cubit.postImage!)),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.removeImagePost();
                                },
                                icon: const CircleAvatar(
                                  radius: 16.0,
                                  child: Icon(
                                    IconBroken.Delete,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(width: 5),
                              Text('Add Photo')
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: TextButton(
                              onPressed: () {}, child: const Text('#tags')))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
