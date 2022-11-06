import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/components/button/extendable_button.dart';
import 'package:spark_auth_demo/core/components/textfield/custom_textfield.dart';
import 'package:spark_auth_demo/core/constants/texts/texts.dart';
import 'package:spark_auth_demo/core/extensions/context_extensions.dart';

import '../../../core/base/view/base_view.dart';
import '../cubit/forgot_password_cubit.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordCubit>(
      cubit: ForgotPasswordCubit(),
      onCubitReady: (cubit) {
        cubit.setContext(context);
        cubit.init();
      },
      onPageBuilder: (ForgotPasswordCubit cubit) => Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTexts.forgotPassScreenHeader,
                style: context.textTheme.headline1,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppTexts.fotgotPassDescription,
                style: context.textTheme.bodyText1,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                showError: (isError) {
                  cubit.isButtonActive(isError);
                  print(isError);
                },
                title: AppTexts.emailHintText,
                controller: cubit.emailController,
              ),
              const SizedBox(
                height: 25,
              ),
              ExtendableButton(
                text: AppTexts.continueButton,
                buttonColor: context.appColors.primaryButtonColor,
                onPress: cubit.resetPassword,
              ),
              const SizedBox(
                height: 25,
              ),
              ExtendableButton(
                text: AppTexts.cancelButton,
                buttonColor: context.appColors.secondaryButtonColor,
                onPress: cubit.navigateToLogin,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
