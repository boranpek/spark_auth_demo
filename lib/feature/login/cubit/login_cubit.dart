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
      showDialog(
        context: context!,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Please wait...',
            textAlign: TextAlign.center,
            style: context!.textTheme.headline2,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CircularProgressIndicator(
                    color: context!.appColors.primaryColor),
              ),
            ],
          ),
        ),
      );
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        await loggedUser(readUser());
        Navigator.pop(context!);
        context!.showSnackBar('${appStateManager.user.name} logged in');
      } on FirebaseAuthException {
        Navigator.pop(context!);
        showDialog(
          context: context!,
          builder: (ctx) => AlertDialog(
            title: Text(
              'Password or Email is wrong',
              textAlign: TextAlign.center,
              style: context!.textTheme.headline2,
            ),
            actions: <Widget>[
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'OK',
                    textAlign: TextAlign.center,
                    style: context!.textTheme.bodyText1,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context!,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Please fill the fields',
            textAlign: TextAlign.center,
            style: context!.textTheme.headline2,
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'OK',
                  textAlign: TextAlign.center,
                  style: context!.textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      );
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
