import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/base/cubit/base_cubit.dart';

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
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
