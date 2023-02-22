// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_social_app/modules/home/cubit/cubit.dart';
import 'package:firebase_social_app/modules/home/cubit/states.dart';
import 'package:firebase_social_app/modules/home/home.dart';

import 'package:firebase_social_app/modules/login/login.dart';
import 'package:firebase_social_app/modules/register/register.dart';
import 'package:firebase_social_app/shared/network/constant/constant.dart';
import 'package:firebase_social_app/shared/network/local/cahce_helper.dart';
import 'package:firebase_social_app/shared/observer/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Cache_Helper.init();
  Widget? widget;
  uId = Cache_Helper.getData(key: 'uId');
  await Firebase.initializeApp();
  if (uId != null) {
    widget = const HomePage();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});
  final Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) =>
                  SocialHomeCubit()..getUserData())
        ],
        child: BlocConsumer<SocialHomeCubit, SocialHomeState>(
          builder: (context, state) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: 'start',
            routes: {
              'start': (context) => startWidget,
              'login': (context) => LoginScreen(),
              'register': (context) => RegisterScreen(),
              'homepage': (context) => const HomePage(),
            },
          ),
          listener: (context, state) {},
        ));
  }
}
