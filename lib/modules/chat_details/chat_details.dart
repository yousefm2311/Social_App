// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_social_app/models/chat_model.dart';
import 'package:firebase_social_app/models/user_model.dart';
import 'package:firebase_social_app/modules/home/cubit/cubit.dart';
import 'package:firebase_social_app/modules/home/cubit/states.dart';
import 'package:firebase_social_app/shared/components/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetails extends StatelessWidget {
  SocialUserModel? model;
  ChatDetails({super.key, this.model});

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialHomeCubit.get(context).getMessages(receiverId: model!.uId!);
      return BlocConsumer<SocialHomeCubit, SocialHomeState>(
        builder: (context, index) {
          SocialHomeCubit cubit = SocialHomeCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(IconBroken.Call))
                ],
                titleSpacing: 0.0,
                title: Row(children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${model!.image}'),
                  ),
                  const SizedBox(width: 15.0),
                  Text('${model!.name}')
                ]),
              ),
              body: ConditionalBuilder(
                condition: cubit.messages.isNotEmpty,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          controller: cubit.scrollController,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message = cubit.messages[index];
                            if (cubit.userModel!.uId == message.senderId) {
                              return buildSenderChat(message);
                            }
                            return buildReceiverChat(message);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                          itemCount: cubit.messages.length,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: textController,
                              onFieldSubmitted: (value) {
                                cubit.sendMessage(
                                    text: textController.text,
                                    receiverId: '${model!.uId}',
                                    dateTime: DateTime.now().toString());
                                cubit.scrollToBottom();
                                textController.text = '';
                              },
                              decoration: InputDecoration(
                                hintText: 'type your message here...',
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        child: const Icon(IconBroken.Image),
                                        onTap: () {},
                                      ),
                                      const SizedBox(width: 8.0),
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          IconBroken.Camera,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 1.0, color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 1.0, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Container(
                            height: 57,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                                cubit.sendMessage(
                                    text: textController.text,
                                    receiverId: '${model!.uId}',
                                    dateTime: DateTime.now().toString());
                                cubit.scrollToBottom();
                                textController.text = '';
                                cubit.sendNotification();
                              },
                              minWidth: 1,
                              child: const Icon(IconBroken.Send),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ));
        },
        listener: (context, state) {},
      );
    });
  }

  Widget buildReceiverChat(ChatModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              )),
          child: Text('${model.text}'),
        ),
      );
  Widget buildSenderChat(ChatModel model) {
    DateTime now = DateTime.now();
    DateTime messageTime = DateTime.parse(model.dateTime!);
    Duration difference = now.difference(messageTime);
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(.7),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                )),
            child: Text('${model.text}'),
          ),
          Text(
            "${difference.inDays} days ago",
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
