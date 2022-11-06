import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark_auth_demo/core/extensions/context_extensions.dart';
import 'package:spark_auth_demo/feature/signup/cubit/signup_cubit.dart';

import '../../../core/constants/texts/texts.dart';

class PrivacyPolicy extends StatelessWidget {
  final SignupCubit cubit;
  const PrivacyPolicy({
    Key? key, required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: cubit.tooglePrivacyPolicy,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 15.0,
                  height: 15.0,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      width: 2,
                      color: context.appColors.primaryColor,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: state.isPrivacyPolicyChecked ? context.appColors.primaryColor : Colors.transparent,
                    border: Border.all(
                      width: 2,
                      color: context.appColors.primaryColor,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              AppTexts.privacyPolicyText,
              style: context.textTheme.bodyText2,
            ),
          ),
        ],
      );
    });
  }
}
