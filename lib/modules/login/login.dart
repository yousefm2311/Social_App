// ignore_for_file: must_be_immutable, unused_local_variable, unnecessary_null_comparison

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:firebase_social_app/modules/home/home.dart';
import 'package:firebase_social_app/modules/login/cubit/cubit.dart';
import 'package:firebase_social_app/modules/login/cubit/states.dart';
import 'package:firebase_social_app/shared/components/button.dart';
import 'package:firebase_social_app/shared/components/components.dart';
import 'package:firebase_social_app/shared/components/square_tile.dart';
import 'package:firebase_social_app/shared/components/textfield.dart';
import 'package:firebase_social_app/shared/network/local/cahce_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => LoginCubit()),
      child: BlocConsumer<LoginCubit, LoginStates>(
        builder: ((context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[300],
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    const Icon(
                      Icons.lock,
                      size: 100,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Welcome back you\'ve been missed! ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 25),
                    MyTextField(
                      maxLines: 1,
                      hintText: 'Email',
                      obscureText: false,
                      padding: 25.0,
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),
                    MyTextField(
                      maxLines: 1,
                      hintText: "Password",
                      padding: 25.0,
                      onSubmit: (value) {
                        cubit.loginMethod(
                            email: emailController.text,
                            password: passwordController.text);
                      },
                      obscureText: cubit.isVisibility,
                      controller: passwordController,
                      sufficIcon: IconButton(
                        onPressed: () {
                          cubit.setVisibility();
                        },
                        icon: cubit.isVisibility
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    ConditionalBuilder(
                      condition: state is! LoginLoadingState,
                      builder: (context) {
                        return MyButton(
                          heigth: 22.0,
                          margin: 25.0,
                          textButton: "Sign In",
                          onTap: () {
                            cubit.loginMethod(
                                email: emailController.text,
                                password: passwordController.text);
                          },
                        );
                      },
                      fallback: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.8,
                              color: Colors.grey[400],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text('Or continue with '),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.8,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(
                          imagePath: "assets/images/google.png",
                          onTap: () async {
                            var cred =
                                await cubit.signInWithGoogle().then((value) {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomePage();
                              }), (Route<dynamic> rout) => false);
                            });
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SquareTile(
                          imagePath: "assets/images/github.png",
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                'register', (route) => false);
                          },
                          child: const Text(
                            'Register now',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }),
        listener: (context, state) {
          if (state is LoginErrorState) {
            showFLutterToast(state.error.toString(),
                color: ToastColor.ERROR, text: state.error.toString());
          } else if (state is LoginSuccessState) {
            Cache_Helper.saveData(key: 'uId', value: state.uId).then((value) {
              showFLutterToast(state.toString(),
                color: ToastColor.SUCCESS, text: 'Success');
                Navigator.of(context).pushNamedAndRemoveUntil('homepage', (route) => false);
            });
          }
        },
      ),
    );
  }
}
