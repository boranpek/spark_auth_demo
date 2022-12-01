import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/base/cubit/base_cubit.dart';
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

  login() {
    firebaseService.login(
      context: context!,
      state: state,
      emailController: emailController,
      passwordController: passwordController,
    );
  }
}
