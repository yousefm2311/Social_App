// ignore_for_file: must_be_immutable, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_social_app/models/comments_model.dart';
import 'package:firebase_social_app/modules/comments/cubit/cubit.dart';
import 'package:firebase_social_app/modules/comments/cubit/states.dart';
import 'package:firebase_social_app/modules/home/cubit/cubit.dart';
import 'package:firebase_social_app/shared/components/icon_broken.dart';
import 'package:firebase_social_app/shared/components/textfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsPage extends StatelessWidget {
  CommentsPage({super.key, required this.index});

  final int index;
  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()
        ..getComments(SocialHomeCubit.get(context).postId[index]),
      child: BlocConsumer<SocialCubit, SocialAppCommentState>(
          builder: ((context, state) {
            SocialCubit cubit = SocialCubit.get(context);
            var dateNow = DateTime.now();
            return Scaffold(
              appBar: AppBar(
                title: const Text("Comments"),
                actions: [
                  Text(
                    "${cubit.comments.length}",
                    style: const TextStyle(color: Colors.black),
                  )
                ],
              ),
              body: ConditionalBuilder(
                condition: cubit.comments.isNotEmpty &&
                    state is! GetCommentsDataLoadingState,
                builder: (context) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return buildComments(
                                  cubit.comments[index], context);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10.0,
                                ),
                            itemCount: cubit.comments.length),
                      ),
                      const SizedBox(height: 80.0),
                    ],
                  );
                },
                fallback: (context) => cubit.comments.isEmpty
                    ? const Center(
                        child: Text(
                        'No Comments 😢',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ))
                    : const Center(child: CircularProgressIndicator()),
              ),
              bottomSheet: Container(
                width: double.infinity,
                height: cubit.commentImage != null ? 200 : 80,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      if (cubit.commentImage != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            SizedBox(
                              height: 120.0,
                              child: Image(
                                height: 100.0,
                                image: FileImage(
                                  cubit.commentImage!,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                cubit.removeImageComment();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white70,
                                radius: 11,
                                child: Icon(
                                  IconBroken.Delete,
                                  size: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              controller: commentController,
                              hintText: 'write comment',
                              obscureText: false,
                              padding: 10,
                              sufficIcon: IconButton(
                                onPressed: () {
                                  cubit.getCommentImage();
                                },
                                icon: const Icon(IconBroken.Camera),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (cubit.commentImage == null) {
                                try {
                                  cubit.addComments(
                                    postId: SocialHomeCubit.get(context)
                                        .postId[index],
                                    dateTime: dateNow.toString(),
                                    context: context,
                                    text: commentController.text,
                                  );
                                  cubit.comments = [];
                                  cubit.getComments(SocialHomeCubit.get(context)
                                      .postId[index]);
                                  commentController.text = '';
                                } catch (e) {
                                  print(e.toString());
                                }
                              } else {
                                try {
                                  cubit.createComment(
                                      context: context,
                                      dateTime: dateNow.toString(),
                                      postId: SocialHomeCubit.get(context)
                                          .postId[index],
                                      text: commentController.text);
                                  cubit.comments = [];
                                  Future.delayed(
                                      const Duration(
                                        seconds: 3,
                                      ), () {
                                    return cubit.getComments(
                                        SocialHomeCubit.get(context)
                                            .postId[index]);
                                  });
                                  commentController.text = '';
                                  cubit.removeImageComment();
                                } catch (e) {
                                  print(e.toString());
                                }
                              }
                            },
                            icon: const Icon(IconBroken.Send),
                          ),
                          const SizedBox(width: 10.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          listener: (context, state) {}),
    );
  }

  Widget buildComments(CommentModel model, context) => Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22.0,
              backgroundImage: NetworkImage('${model.imageUser}'),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 300.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(8.0),
                      // image: model.image != ''
                      //     ? DecorationImage(
                      //         image: NetworkImage('${model.image}'),
                      //       )
                      //     : null,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${model.name}",
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8.0),
                          if (model.text != '')
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, bottom: 8.0),
                              child: Text("${model.text}"),
                            ),
                          if (model.image != '')
                            ConditionalBuilder(
                              condition: model.image!.isNotEmpty,
                              builder: (context) {
                                return Image(
                                  height: 200.0,
                                  image: NetworkImage('${model.image}'),
                                );
                              },
                              fallback: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        const Text(
                          "Like",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        const Text(
                          "Reply",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 150.0),
                        Text(
                            '${DateTime.parse(model.dateTime as String).hour} h'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
