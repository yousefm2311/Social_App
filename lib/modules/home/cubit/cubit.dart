// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_social_app/models/chat_model.dart';
import 'package:firebase_social_app/models/post_model.dart';
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
    'Users',
    'Settings',
  ];

  List<Widget> getWidgets = [
    const Feeds_Screen(),
    const Chat_Screen(),
    New_Post(),
    const Profile_Screen(),
    const Settings_Screen(),
  ];
  int currentIndex = 0;
  void changeCurrentIndex(value) {
    if (value == 1) {
      getAllUsers();
    }
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

  File? postImage;
  Future<void> getPostImage() async {
    final pickerFile = await picker.getImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      postImage = File(pickerFile.path);
      emit(GetPostImagePickerSuccess());
    } else {
      print("No image selected");
      emit(GetPostImagePickerError());
    }
  }

  void removeImagePost() {
    postImage = null;
    emit(RemovePostImagePicker());
  }

  void createNewPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreateNewPostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(text: text, dateTime: dateTime, postImage: value);
      }).catchError((error) {
        print(error.toString());
        emit(CreateNewPostErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(CreateNewPostErrorState(error.toString()));
    });
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(CreateNewPostLoadingState());
    NewPostModel model = NewPostModel(
        name: userModel!.name,
        uId: userModel!.uId,
        image: userModel!.image,
        dateTime: dateTime,
        imagePost: postImage ?? "",
        text: text);
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreateNewPostSuccessState());
    }).catchError((error) {
      emit(CreateNewPostErrorState(error.toString()));
    });
  }

  List<NewPostModel> postModel = [];
  List<String> postId = [];
  List<dynamic> likes = [];
  List<dynamic> comments = [];
  void getPosts() {
    emit(GetPostDataLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
        }).catchError((error) {});
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          postModel.add(NewPostModel.formJson(element.data()));
          emit(AddLikesLenght());
        }).catchError((error) {});
      }
      emit(GetPostDataSuccessState());
    }).catchError((error) {
      emit(GetPostDataErrorState(error.toString()));
    });
  }

  void addLike(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(AddLikeSuccessState());
    }).catchError((error) {
      emit(AddLikeErrorState(error));
    });
  }

  List<SocialUserModel> allUser = [];

  void getAllUsers() {
    emit(GetAllUsersLoadingState());
    if (allUser.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel!.uId) {
            allUser.add(SocialUserModel.formJson(element.data()));
          }
        }
        emit(GetAllUsersSuccessState());
      }).catchError((error) {
        emit(GetAllUsersErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String text,
    required String receiverId,
    required String dateTime,
  }) {
    ChatModel model = ChatModel(
        text: text,
        receiverId: receiverId,
        senderId: userModel!.uId,
        dateTime: dateTime);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(AddChatSuccessState());
    }).catchError((error) {
      emit(AddChatErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(AddChatSuccessState());
    }).catchError((error) {
      emit(AddChatErrorState(error.toString()));
    });
  }

  List<ChatModel> messages = [];

  final scrollController = ScrollController();
  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 60), curve: Curves.easeOut);
    }
  }

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      scrollToBottom();
      for (var element in event.docs) {
        messages.add(ChatModel.formJson(element.data()));
      }
      emit(GetChatSuccessState());
      scrollToBottom();
    });
  }

  // File? commentImage;
  // Future<void> getCommentImage() async {
  //   final pickerFile = await picker.getImage(source: ImageSource.gallery);
  //   if (pickerFile != null) {
  //     commentImage = File(pickerFile.path);
  //     emit(GetPostImagePickerSuccess());
  //   } else {
  //     print("No image selected");
  //     emit(GetPostImagePickerError());
  //   }
  // }

  // void addComments({
  //   required String text,
  //   required String postId,
  //   required String dateTime,
  //   String? commentImage,
  // }) {
  //   CommentModel model = CommentModel(
  //     dateTime: dateTime,
  //     image: commentImage ?? '',
  //     imageUser: userModel!.image,
  //     name: userModel!.name,
  //     text: text,
  //     uId: userModel!.uId,
  //   );
  //   emit(AddCommentLoadingState());
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postId)
  //       .collection('comments')
  //       .add(model.toJson())
  //       .then((value) {
  //     emit(AddCommentSuccessState());
  //     getComments(postId);
  //   }).catchError((error) {
  //     emit(AddCommentErrorState(error.toString()));
  //   });
  // }

  // List<CommentModel> comments = [];

  // void getComments(postId) {
  //   emit(GetCommentsDataLoadingState());
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postId)
  //       .collection('comments')
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       comments.add(CommentModel.fromJson(element.data()));
  //     });
  //     emit(GetCommentsDataSuccessState());
  //   }).catchError((error) {
  //     emit(GetCommentsDataErrorState(error.toString()));
  //   });
  // }
}
