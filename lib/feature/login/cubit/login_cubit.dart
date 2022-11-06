import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/base/cubit/base_cubit.dart';
import 'package:spark_auth_demo/core/extensions/context_extensions.dart';
import 'package:spark_auth_demo/feature/auth/model/user_request_model.dart';

import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/constants/texts/texts.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with BaseCubit {
  LoginCubit() : super(const LoginState());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String> hintTexts = [
    AppTexts.emailHintText,
    AppTexts.passwordHintText,
  ];

  @override
  void init() {}

  @override
  void setContext(BuildContext context) => this.context = context;

  Future<void> navigateToSignup() async {
    await navigation.navigateToPageClear(path: NavigationConstants.SIGNUP);
  }

  Future<void> navigateToForgotPassword() async {
    await navigation.navigateToPageClear(
        path: NavigationConstants.FORGOTPASSWORD);
  }

  isEmailChecked(bool isError) {
    emit(state.copyWith(isEmailChecked: !isError));
  }

  isPasswordChecked(bool isError) {
    emit(state.copyWith(isPasswordChecked: !isError));
  }

  Future login() async {
    if (state.isEmailChecked && state.isPasswordChecked) {
      context!.loadingDialog();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        await loggedUser(readUser());
        Navigator.pop(context!);
        context!.showSnackBar('${appStateManager.user.name} logged in');
      } on FirebaseAuthException {
        Navigator.pop(context!);
        context!.customShowDialog(title: 'Password or Email is wrong');
      }
    } else {
      context!.customShowDialog(title: 'Please fill the fields');
    }
  }

  Future<String> loggedUser(Stream<List<UserRequestModel>> stream) async {
    String name = '';
    await for (final users in stream) {
      for (final user in users) {
        if (FirebaseAuth.instance.currentUser!.email == user.email) {
          name = user.name!;
          appStateManager.user = user;
          return name;
        }
      }
    }
    return name;
  }

  Stream<List<UserRequestModel>> readUser() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((e) => UserRequestModel().fromJson(e.data()))
          .toList());
}
