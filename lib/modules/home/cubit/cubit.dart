// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_social_app/models/user_model.dart';
import 'package:firebase_social_app/modules/add_post/add_post.dart';
import 'package:firebase_social_app/modules/chats/chats.dart';
import 'package:firebase_social_app/modules/feeds/feeds.dart';
import 'package:firebase_social_app/modules/home/cubit/states.dart';
import 'package:firebase_social_app/modules/settings/settings.dart';
import 'package:firebase_social_app/modules/users/users.dart';
import 'package:firebase_social_app/shared/network/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialHomeCubit extends Cubit<SocialHomeState> {
  SocialHomeCubit() : super(SocialGetInitialState());

  static SocialHomeCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  void getUserData() {
    emit(SocialGetLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.formJson(value.data()!);
      emit(SocialGetSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetErrorState(error.toString()));
    });
  }

  List<String> titleAppbar = [
    'News Feed',
    'Chats',
    'Post',
    'Profile',
    'Settings',
  ];

  List<Widget> getWidgets = const [
    Feeds_Screen(),
    Chat_Screen(),
    New_Post(),
    Profile_Screen(),
    Settings_Screen(),
  ];
  int currentIndex = 0;
  void changeCurrentIndex(value) {
    if (value == 2) {
      emit(AddPostState());
    } else {
      currentIndex = value;
      emit(ChangeBottomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getImageProfile() async {
    final pickerFile = await picker.getImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      profileImage = File(pickerFile.path);
      emit(GetProfileImagePickerSuccess());
    } else {
      print("No image selected");
      emit(GetProfileImagePickerError());
    }
  }

  File? coverImage;
  Future<void> getImageCover() async {
    final pickerFile = await picker.getImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      coverImage = File(pickerFile.path);
      emit(GetCoverImagePickerSuccess());
    } else {
      print("No image selected");
      emit(GetCoverImagePickerError());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UpdateUserLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        print(error.toString());
        emit(UploadProfileImageError(error.toString()));
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadProfileImageError(error.toString()));
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UpdateUserLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        print(error.toString());
        emit(UploadCoverImageError(error.toString()));
      });
    }).catchError((error) {
      emit(UploadCoverImageError(error.toString()));
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    image,
    cover,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      uId: userModel!.uId,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateUserError(error.toString()));
    });
  }

  // File? addImage;

  // Future<void> getAddPhoto() async {
  //   final pickerFile = await picker.getImage(source: ImageSource.gallery);
  //   if (pickerFile != null) {
  //     addImage = File(pickerFile.path);
  //     emit(AddImagePickerSuccess());
  //     uploadAddImage();
  //   } else {
  //     print("No image selected");
  //     emit(AddImagePickerError());
  //   }
  // }


  // void uploadAddImage() {
  //   emit(UpdateUserLoading());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child("photo/${Uri.file(addImage!.path).pathSegments.last}")
  //       .putFile(addImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       emit(UploadAddImageSuccess());
  //     }).catchError((error) {
  //       print(error.toString());
  //       emit(UploadAddImageError());
  //     });
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(UploadAddImageError());
  //   });
  // }
}
