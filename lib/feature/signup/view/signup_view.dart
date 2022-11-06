import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/components/button/extendable_button.dart';
import 'package:spark_auth_demo/core/components/dropdown/dropdown.dart';
import 'package:spark_auth_demo/core/constants/texts/texts.dart';
import 'package:spark_auth_demo/core/extensions/context_extensions.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/components/textfield/custom_textfield.dart';
import '../components/privacy_policy.dart';
import '../cubit/signup_cubit.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SignupCubit>(
      cubit: SignupCubit(),
      onCubitReady: (cubit) {
        cubit.setContext(context);
        cubit.init();
      },
      onPageBuilder: (SignupCubit cubit) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTexts.registerScreenHeader,
                  style: context.textTheme.headline1,
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 28),
                    itemCount: cubit.hintTexts.length + 1,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return (index == 1 || index == 2)
                          ? DropDown(
                              items: cubit.dropdownItems[index - 1],
                              title: cubit.hintTexts[index],
                              cubit: cubit,
                              isGender: index == 2,
                            )
                          : index == 6
                              ? PrivacyPolicy(
                                  cubit: cubit,
                                )
                              : CustomTextField(
                                  title: cubit.hintTexts[index],
                                  isCapitalized: index == 0,
                                  isObscure: index > 3,
                                  controller: cubit
                                      .controllers[index > 2 ? index - 2 : 0],
                                );
                    },
                  ),
                ),
                ExtendableButton(
                  text: AppTexts.saveButton,
                  buttonColor: context.appColors.primaryButtonColor,
                  onPress: cubit.createUser,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      AppTexts.alreadyHaveProfile,
                      style: context.textTheme.bodyText2,
                    ),
                    GestureDetector(
                      onTap: cubit.navigateToLogin,
                      child: Text(
                        AppTexts.loginButton,
                        style: context.textTheme.bodyText2!
                            .copyWith(color: context.appColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
