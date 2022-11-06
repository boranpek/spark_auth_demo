import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/base/cubit/base_cubit.dart';
import 'package:spark_auth_demo/core/extensions/context_extensions.dart';

import '../../../core/constants/navigation/navigation_constants.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> with BaseCubit {
  ForgotPasswordCubit() : super(const ForgotPasswordState());

  TextEditingController emailController = TextEditingController();

  @override
  void init() {}

  @override
  void setContext(BuildContext context) => this.context = context;

  Future<void> navigateToLogin() async {
    await navigation.navigateToPageClear(path: NavigationConstants.LOGIN);
  }

  Future resetPassword() async {
    if (state.isButtonActive) {
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
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);
        Navigator.pop(context!);
        context!.showSnackBar('Email is sent');
        await Future.delayed(const Duration(seconds: 2));
        navigateToLogin();
      } on FirebaseAuthException {
        Navigator.pop(context!);
        showDialog(
          context: context!,
          builder: (ctx) => AlertDialog(
            title: Text(
              'Wrong email',
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
              'Please enter your email',
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

  isButtonActive(bool isError) {
    emit(state.copyWith(isButtonActive: !isError));
  }
}
