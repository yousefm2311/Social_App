// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:firebase_social_app/shared/components/components.dart';
import 'package:firebase_social_app/shared/components/icon_broken.dart';
import 'package:flutter/material.dart';

class Feeds_Screen extends StatelessWidget {
  const Feeds_Screen({super.key});

  @override
  Widget build(BuildContext context) {
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
            physics:const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return buildPostItem(context);
            },
            itemCount: 4,
            separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget buildPostItem(context) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        'https://www.incimages.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg'),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Yousef Mohamed',
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              size: 20.0,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        Text(
                          'January 21, 2023 at 10:30 AM',
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
                color: Colors.grey[800],
              ),
              Text(
                'Aute et consectetur laboris labore id sunt sit eu occaecat nulla ad adipisicing sit quis. Est pariatur aute aliqua aute amet laboris quis tempor tempor esse minim ad. Voluptate ex ex qui exercitation aliquip.',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: [
                    defalutTages(onTap: () {}, text: '#software'),
                    defalutTages(onTap: () {}, text: '#hardware'),
                    defalutTages(onTap: () {}, text: '#software'),
                    defalutTages(onTap: () {}, text: '#computer'),
                    defalutTages(onTap: () {}, text: '#flutter'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 170.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://www.incimages.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg',
                    ),
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
                          children: const [
                            Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                              size: 25.0,
                            ),
                            SizedBox(width: 5.0),
                            Text('1200')
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
                          children: const [
                            Icon(
                              IconBroken.Chat,
                              color: Colors.amber,
                              size: 25.0,
                            ),
                            SizedBox(width: 5.0),
                            Text('512 comments')
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.grey[800],
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2017/06/20/22/14/man-2425121_960_720.jpg'),
                          ),
                          const SizedBox(width: 10.0),
                          Text('write a comment ...',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
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
