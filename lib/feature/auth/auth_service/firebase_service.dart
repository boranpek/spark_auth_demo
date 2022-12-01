import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/extensions/context_extensions.dart';
import 'package:spark_auth_demo/core/init/app_state/app_state.dart';
import 'package:spark_auth_demo/feature/forgot_password/cubit/forgot_password_cubit.dart';

import '../../../core/constants/texts/texts.dart';
import '../../login/cubit/login_cubit.dart';
import '../../signup/cubit/signup_cubit.dart';
import '../model/user_request_model.dart';

class FirebaseService {
  static FirebaseService? _instance;
  static FirebaseService get instance {
    return _instance ??= FirebaseService.init();
  }

  FirebaseService.init();

  //Login
  Future login({
    required BuildContext context,
    required LoginState state,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    if (state.isEmailChecked && state.isPasswordChecked) {
      context.loadingDialog();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        await loggedUser(readUser());
        navigatorPop;
        context.showSnackBar(
            '${AppStateManager.instance.user.name} ${AppTexts.userLoggedIn}');
      } on FirebaseAuthException {
        navigatorPop;
        context.customShowDialog(title: AppTexts.errorWrongEmailOrPassword);
      }
    } else {
      context.customShowDialog(title: AppTexts.errorPleaseFillAll);
    }
  }

  Future<String> loggedUser(Stream<List<UserRequestModel>> stream) async {
    String name = '';
    await for (final users in stream) {
      for (final user in users) {
        if (FirebaseAuth.instance.currentUser!.email == user.email) {
          name = user.name!;
          AppStateManager.instance.user = user;
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

  //Signup
  Future signUp({
    required SignupState state,
    required BuildContext context,
    required TextEditingController confirmPasswordController,
    required TextEditingController passwordController,
    required TextEditingController emailController,
    required TextEditingController nameController,
  }) async {
    if (state.isConfirmPasswordChecked &&
        state.isEmailChecked &&
        state.isNameChecked &&
        state.isPasswordChecked) {
      if (confirmPasswordController.text != passwordController.text) {
        context.customShowDialog(title: AppTexts.passwordsAreNotMatched);
      } else if (!state.isPrivacyPolicyChecked) {
        context.customShowDialog(title: AppTexts.errorPleaseCheckPrivacy);
      } else {
        context.loadingDialog();
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
          await createUser(
            nameController: nameController,
            passwordController: passwordController,
            emailController: emailController,
            state: state,
          );
          navigatorPop;
          context.showSnackBar(AppTexts.userRegistered);
        } on FirebaseAuthException {
          navigatorPop;
          context.customShowDialog();
        }
      }
    } else {
      context.customShowDialog(title: AppTexts.fillRequiredFields);
    }
  }

  Future createUser({
    required TextEditingController nameController,
    required TextEditingController passwordController,
    required TextEditingController emailController,
    required SignupState state,
  }) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final user = UserRequestModel(
      id: docUser.id,
      name: nameController.text,
      birthYear: state.birth,
      email: emailController.text,
      gender: state.gender,
      password: passwordController.text,
    );
    final json = user.toJson();
    await docUser.set(json);
  }

  //Forgot Password
  Future resetPassword({
    required ForgotPasswordState state,
    required BuildContext context,
    required TextEditingController emailController,
    required Function navigateToLogin,
  }) async {
    if (state.isButtonActive) {
      context.loadingDialog();
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);
        navigatorPop;
        context.showSnackBar(AppTexts.emailIsSent);
        await Future.delayed(const Duration(seconds: 2));
        navigateToLogin();
      } on FirebaseAuthException {
        navigatorPop;
        context.customShowDialog(title: AppTexts.errorWrongEmail);
      }
    } else {
      context.customShowDialog(title: AppTexts.pleaseEnterYourEmail);
    }
  }

  void navigatorPop(BuildContext context) async {
    Navigator.of(context).pop();
  }
}
