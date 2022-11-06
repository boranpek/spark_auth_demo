import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/base/cubit/base_cubit.dart';
import 'package:spark_auth_demo/core/constants/texts/texts.dart';
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
      context!.loadingDialog();
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);
        Navigator.pop(context!);
        context!.showSnackBar(AppTexts.emailIsSent);
        await Future.delayed(const Duration(seconds: 2));
        navigateToLogin();
      } on FirebaseAuthException {
        Navigator.pop(context!);
        context!.customShowDialog(title: AppTexts.errorWrongEmail);
      }
    } else {
      context!.customShowDialog(title: AppTexts.pleaseEnterYourEmail);
    }
  }

  isButtonActive(bool isError) {
    emit(state.copyWith(isButtonActive: !isError));
  }
}
