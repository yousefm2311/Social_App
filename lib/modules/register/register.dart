// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_social_app/modules/register/cubit/cubit.dart';
import 'package:firebase_social_app/modules/register/cubit/states.dart';
import 'package:firebase_social_app/shared/components/button.dart';
import 'package:firebase_social_app/shared/components/square_tile.dart';
import 'package:firebase_social_app/shared/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          builder: (context, state) {
        RegisterCubit cubit = RegisterCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[300],
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  const Icon(
                    Icons.lock,
                    size: 120,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  MyTextField(
                    padding: 25.0,
                    maxLines: 1,
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    padding: 25.0,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    padding: 25.0,
                    maxLines: 1,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    hintText: 'Phone',
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    padding: 25.0,
                    maxLines: 1,
                    hintText: 'Password',
                    controller: passwordController,
                    obscureText: cubit.isVisibility,
                    keyboardType: TextInputType.visiblePassword,
                    sufficIcon: IconButton(
                        onPressed: () {
                          cubit.changeVisibility();
                        },
                        icon: cubit.isVisibility
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ConditionalBuilder(
                    condition: state is! RegisterLoadingState,
                    builder: (context) {
                      return MyButton(
                        margin: 25.0,
                        heigth: 22.0,
                        onTap: () {
                          cubit.registerMethod(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                          );
                        },
                        textButton: 'Sigin Up',
                      );
                    },
                    fallback: (context) =>const CircularProgressIndicator(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        imagePath: "assets/images/google.png",
                        onTap: () {},
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
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Really an email?',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14.0),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is CreateUserSuccessState) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('homepage', (route) => false);
        }
      }),
    );
  }
}
