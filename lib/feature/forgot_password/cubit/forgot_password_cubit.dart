import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

  resetPassword() {
    firebaseService.resetPassword(
      state: state,
      context: context!,
      emailController: emailController,
      navigateToLogin: navigateToLogin,
    );
  }

  isButtonActive(bool isError) {
    emit(state.copyWith(isButtonActive: !isError));
  }
}
