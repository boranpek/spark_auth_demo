import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:spark_auth_demo/core/base/cubit/base_cubit.dart';
import 'package:spark_auth_demo/core/constants/texts/texts.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> with BaseCubit {
  SignupCubit() : super(const SignupState());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  List<String> hintTexts = [
    AppTexts.nameHintText,
    AppTexts.birthHintText,
    AppTexts.genderHintText,
    AppTexts.emailHintText,
    AppTexts.passwordHintText,
    AppTexts.confirmPassHintText,
  ];

  List<List<String>> dropdownItems = [
    [],
    ['Male', 'Female', 'Other']
  ];

  List<TextEditingController> controllers = [];

  @override
  void init() {
    addYearsToDropdownItems();
    initializeControllers();
  }

  @override
  void setContext(BuildContext context) => this.context = context;

  addYearsToDropdownItems() {
    int maxYear = 2023;
    int minYear = 1960;
    for (int i = maxYear; i > minYear; i--) {
      dropdownItems[0].add(i.toString());
    }
  }

  initializeControllers() {
    controllers.add(nameController);
    controllers.add(emailController);
    controllers.add(passwordController);
    controllers.add(confirmPasswordController);
  }

  tooglePrivacyPolicy() {
    emit(state.copyWith(isPrivacyPolicyChecked: !state.isPrivacyPolicyChecked));
  }
}
