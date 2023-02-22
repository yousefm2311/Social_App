import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_social_app/models/user_model.dart';
import 'package:firebase_social_app/modules/home/cubit/states.dart';
import 'package:firebase_social_app/shared/network/constant/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialHomeCubit extends Cubit<SocialHomeState> {
  SocialHomeCubit() : super(SocialGetInitialState());

  static SocialHomeCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;
  void getUserData() {
    emit(SocialGetLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {

      model = SocialUserModel.formJson(value.data()!);
      emit(SocialGetSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetErrorState(error.toString()));
    });
  }
}
