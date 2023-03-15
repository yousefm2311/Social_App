// ignore_for_file: unused_local_variable, use_build_context_synchronously, must_be_immutable

import 'package:firebase_social_app/modules/home/cubit/cubit.dart';
import 'package:firebase_social_app/modules/home/cubit/states.dart';
import 'package:firebase_social_app/shared/components/button.dart';
import 'package:firebase_social_app/shared/components/components.dart';
import 'package:firebase_social_app/shared/components/icon_broken.dart';
import 'package:firebase_social_app/shared/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit, SocialHomeState>(
        builder: (context, state) {
          SocialHomeCubit cubit = SocialHomeCubit.get(context);
          nameController.text = cubit.userModel!.name!;
          bioController.text = cubit.userModel!.bio!;
          phoneController.text = cubit.userModel!.phone!;
          return Scaffold(
            appBar: defaultAppBar(
              title: 'Edit Profile',
              context: context,
              action: [
                defaultTextButton(
                    text: 'UPDATE',
                    onTap: () {
                      cubit.updateUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text);
                    }),
                const SizedBox(
                  width: 15.0,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is UpdateUserLoading)
                      const LinearProgressIndicator(),
                    if (state is UpdateUserLoading)
                      const SizedBox(
                        height: 10.0,
                      ),
                    SizedBox(
                      height: 250,
                      child: Stack(
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
                                      image: cubit.coverImage == null
                                          ? NetworkImage(
                                              "${cubit.userModel!.cover}")
                                          : FileImage(cubit.coverImage!)
                                              as ImageProvider,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.getImageCover();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 16.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                width: 110.0,
                                height: 110.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                child: CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: cubit.profileImage == null
                                      ? NetworkImage(
                                          '${cubit.userModel!.image}')
                                      : FileImage(cubit.profileImage!)
                                          as ImageProvider,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.getImageProfile();
                                },
                                icon: const CircleAvatar(
                                  radius: 16.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (cubit.coverImage != null || cubit.profileImage != null)
                      const SizedBox(height: 25.0),
                    if (cubit.coverImage != null || cubit.profileImage != null)
                      Row(
                        children: [
                          if (cubit.profileImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  MyButton(
                                    onTap: () {
                                      cubit.uploadProfileImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    margin: 0.0,
                                    textButton: "UPLOAD PROFILE",
                                    heigth: 10,
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(width: 8.0),
                          if (cubit.coverImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  MyButton(
                                    onTap: () {
                                      cubit.uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    margin: 0.0,
                                    textButton: "UPLOAD COVER",
                                    heigth: 10,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    const SizedBox(height: 25.0),
                    MyTextField(
                      padding: 0.0,
                      hintText: 'Name',
                      obscureText: false,
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      perfexIcon: const Icon(IconBroken.Profile),
                    ),
                    const SizedBox(height: 15.0),
                    MyTextField(
                      padding: 0.0,
                      hintText: 'Phone',
                      obscureText: false,
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      perfexIcon: const Icon(IconBroken.Call),
                    ),
                    const SizedBox(height: 15.0),
                    MyTextField(
                      perfexIcon: const Icon(IconBroken.Info_Circle),
                      padding: 0.0,
                      hintText: 'Bio',
                      obscureText: false,
                      maxLines: 6,
                      controller: bioController,
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
