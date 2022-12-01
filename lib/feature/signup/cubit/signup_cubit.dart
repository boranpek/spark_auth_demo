import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/base/cubit/base_cubit.dart';
import 'package:spark_auth_demo/core/constants/texts/texts.dart';
import '../../../core/constants/navigation/navigation_constants.dart';

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

  Future<void> navigateToLogin() async {
    await navigation.navigateToPageClear(path: NavigationConstants.LOGIN);
  }

  selectGender({required String gender}) {
    emit(state.copyWith(gender: gender));
  }

  selectBirth({required String birth}) {
    emit(state.copyWith(birth: birth));
  }

  isEmailChecked(bool isError) {
    emit(state.copyWith(isEmailChecked: !isError));
  }

  isPasswordChecked(bool isError) {
    emit(state.copyWith(isPasswordChecked: !isError));
  }

  isNameChecked(bool isError) {
    emit(state.copyWith(isNameChecked: !isError));
  }

  isConfirmPasswordChecked(bool isError) {
    emit(state.copyWith(isConfirmPasswordChecked: !isError));
  }

  signUp() {
    firebaseService.signUp(
      state: state,
      context: context!,
      confirmPasswordController: confirmPasswordController,
      passwordController: passwordController,
      emailController: emailController,
      nameController: nameController,
    );
  }
}
