import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:spark_auth_demo/core/base/cubit/base_cubit.dart';
import 'package:spark_auth_demo/core/constants/texts/texts.dart';
import 'package:spark_auth_demo/core/extensions/context_extensions.dart';
import 'package:spark_auth_demo/feature/auth/model/user_request_model.dart';

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

  Future createUser() async {
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

  selectGender({required String gender}) {
    emit(state.copyWith(gender: gender));
  }

  selectBirth({required String birth}) {
    emit(state.copyWith(birth: birth));
  }

  Future signUp() async {
    if (state.isConfirmPasswordChecked &&
        state.isEmailChecked &&
        state.isNameChecked &&
        state.isPasswordChecked &&
        state.isPrivacyPolicyChecked) {
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
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        await createUser();
        Navigator.pop(context!);
        context!.showSnackBar('User is registered');
      } on FirebaseAuthException {
        Navigator.pop(context!);
        showDialog(
          context: context!,
          builder: (ctx) => AlertDialog(
            title: Text(
              'Something is wrong',
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
    } else if (confirmPasswordController.text != passwordController.text) {
      showDialog(
        context: context!,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Passwords are not matched',
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
    } else if (!state.isPrivacyPolicyChecked) {
      showDialog(
        context: context!,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Please check privacy policy',
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
    } else {
      showDialog(
        context: context!,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Please fill the required fields',
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
}
