import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/extensions/context_extensions.dart';
import 'package:spark_auth_demo/feature/login/cubit/login_cubit.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/components/button/extendable_button.dart';
import '../../../core/components/textfield/custom_textfield.dart';
import '../../../core/constants/texts/texts.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginCubit>(
      cubit: LoginCubit(),
      onCubitReady: (cubit) {
        cubit.setContext(context);
        cubit.init();
      },
      onPageBuilder: (LoginCubit cubit) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTexts.loginScreenHeader,
                  style: context.textTheme.headline1,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  title: cubit.hintTexts[0],
                  controller: cubit.emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  title: cubit.hintTexts[1],
                  controller: cubit.passwordController,
                  isObscure: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                ExtendableButton(
                  text: AppTexts.letsGoButton,
                  buttonColor: context.appColors.primaryButtonColor,
                  onPress: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: cubit.navigateToForgotPassword,
                  child: Text(
                    AppTexts.forgotYourPassword,
                    style: context.textTheme.bodyText2,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  AppTexts.dontHaveAccount,
                  style: context.textTheme.headline2,
                ),
                const SizedBox(
                  height: 20,
                ),
                ExtendableButton(
                  text: AppTexts.registerButton,
                  buttonColor: context.appColors.primaryButtonColor,
                  onPress: cubit.navigateToSignup,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
