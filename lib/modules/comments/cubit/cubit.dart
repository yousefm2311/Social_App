// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_social_app/modules/comments/cubit/states.dart';
import 'package:firebase_social_app/modules/home/cubit/cubit.dart';
import 'package:firebase_social_app/shared/endPoints/list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../models/comments_model.dart';

class SocialCubit extends Cubit<SocialAppCommentState> {
  SocialCubit() : super(InitialCommentState());
  static SocialCubit get(context) => BlocProvider.of(context);

  File? commentImage;
  var picker = ImagePicker();
  Future getCommentImage() async {
    final pickerFile = await picker.getImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      commentImage = File(pickerFile.path);
      emit(PackImageSuccessState());
    } else {
      print("No image selected");
      emit(PackImageErrorState());
    }
  }

  void addComments(
      {String? text,
      required String postId,
      required String dateTime,
      commentImage,
      context}) {
    CommentModel model = CommentModel(
      dateTime: dateTime,
      image: commentImage ?? '',
      imageUser: SocialHomeCubit.get(context).userModel!.image,
      name: SocialHomeCubit.get(context).userModel!.name,
      text: text ?? '',
      uId: SocialHomeCubit.get(context).userModel!.uId,
    );
    emit(AddCommentLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toJson())
        .then((value) {
      emit(AddCommentSuccessState());
      // getComments(postId);
    }).catchError((error) {
      emit(AddCommentErrorState(error.toString()));
    });
  }


  List<CommentModel> comments = [];
  void getComments(postId) {
    emit(GetCommentsDataLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get()
        .then((value) {
      for (var element in value.docs) {
        comments.add(CommentModel.fromJson(element.data()));
      }
      emit(GetCommentsDataSuccessState());
    }).catchError((error) {
      emit(GetCommentsDataErrorState(error.toString()));
    });
  }

  void removeImageComment() {
    commentImage = null;
    emit(RemoveCommentImageState());
  }

  void createComment({
    required String dateTime,
    String? text,
    postId,
    context,
  }) {
    emit(AddCommentImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("comments/${Uri.file(commentImage!.path).pathSegments.last}")
        .putFile(commentImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        addComments(
          context: context,
          postId: postId,
          dateTime: dateTime,
          commentImage: value,
          text: text,
        );
      }).catchError((error) {
        print(error.toString());
        emit(AddCommentImageErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(AddCommentImageErrorState(error.toString()));
    });
  }
}
