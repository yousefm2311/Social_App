import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_social_app/models/user_model.dart';
import 'package:firebase_social_app/modules/register/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isVisibility = true;
  void changeVisibility() {
    isVisibility = !isVisibility;
    emit(RegisterVisibilityState());
  }

  void registerMethod({
    required email,
    required password,
    required name,
    required phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // ignore: avoid_print
      print(value.user!.uid);
      userCreate(email: email, uId: value.user!.uid, name: name, phone: phone);
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required email,
    required uId,
    required name,
    required phone,
  }) {
    SocialUserModel model = SocialUserModel(
      email: email,
      uId: uId,
      name: name,
      phone: phone,
      isVerified: false
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }
}
