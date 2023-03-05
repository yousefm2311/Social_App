// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_social_app/models/post_model.dart';
import 'package:firebase_social_app/modules/comments/comments_page.dart';
import 'package:firebase_social_app/modules/comments/cubit/cubit.dart';
import 'package:firebase_social_app/modules/home/cubit/cubit.dart';
import 'package:firebase_social_app/modules/home/cubit/states.dart';
import 'package:firebase_social_app/shared/components/components.dart';
import 'package:firebase_social_app/shared/components/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Feeds_Screen extends StatelessWidget {
  const Feeds_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit, SocialHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialHomeCubit cubit = SocialHomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.postModel.isNotEmpty && cubit.userModel != null,
          builder: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 2.0,
                    margin: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        const Image(
                          image: NetworkImage(
                              'https://www.incimages.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg'),
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate with Friends',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildPostItem(
                          context, cubit.postModel[index], index);
                    },
                    itemCount: cubit.postModel.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            );
          },
          fallback: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }

  Widget buildPostItem(context, NewPostModel model, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Icon(
                              Icons.check_circle,
                              size: 20.0,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      IconBroken.More_Circle,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[400],
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(
                height: 10.0,
              ),
              // SizedBox(
              //   width: double.infinity,
              //   child: Wrap(
              //     children: [
              //       defalutTages(onTap: () {}, text: '#software'),
              //       defalutTages(onTap: () {}, text: '#hardware'),
              //       defalutTages(onTap: () {}, text: '#software'),
              //       defalutTages(onTap: () {}, text: '#computer'),
              //       defalutTages(onTap: () {}, text: '#flutter'),
              //     ],
              //   ),
              // ),
              if (model.imagePost != '')
                const SizedBox(
                  height: 10.0,
                ),
              if (model.imagePost != '')
                Container(
                  height: 170.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      image: model.imagePost != ''
                          ? NetworkImage(
                              '${model.imagePost}',
                            )
                          : '' as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                              size: 25.0,
                            ),
                            const SizedBox(width: 5.0),
                            Text('${SocialHomeCubit.get(context).likes[index]}')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              color: Colors.amber,
                              size: 25.0,
                            ),
                            const SizedBox(width: 5.0),
                            InkWell(
                              onTap: () {
                                navigatTo(
                                    context,
                                    CommentsPage(
                                      index: index,
                                    ));
                              },
                              child: Text(
                                  ' comments'),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.grey[400],
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        navigatTo(
                            context,
                            CommentsPage(
                              index: index,
                            ));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(
                                '${SocialHomeCubit.get(context).userModel!.image}'),
                          ),
                          const SizedBox(width: 10.0),
                          Text('write a comment ...',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialHomeCubit.get(context)
                          .addLike(SocialHomeCubit.get(context).postId[index]);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                          size: 25.0,
                        ),
                        SizedBox(width: 5.0),
                        Text('Like')
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
