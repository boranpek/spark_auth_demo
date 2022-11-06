import 'package:lottie/lottie.dart';
import 'package:spark_auth_demo/core/constants/image/image_constants.dart';

import 'package:spark_auth_demo/feature/splash/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';

import '../../../core/base/view/base_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashCubit>(
      cubit: SplashCubit(),
      onCubitReady: (cubit) {
        cubit.setContext(context);
        cubit.init();
      },
      onPageBuilder: (SplashCubit cubit) => Scaffold(
        body: Center(
          child: Lottie.asset(ImageConstants.instance.splash),
        ),
      ),
    );
  }
}
