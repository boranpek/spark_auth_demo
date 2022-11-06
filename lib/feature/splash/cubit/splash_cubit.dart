import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/base/cubit/base_cubit.dart';
import '../../../core/constants/navigation/navigation_constants.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> with BaseCubit {
  SplashCubit() : super(SplashInitial());

  @override
  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    navigateToPages();
  }

  @override
  void setContext(BuildContext context) => this.context = context;

  Future<void> navigateToPages() async {
    await navigation.navigateToPageClear(path: NavigationConstants.SIGNUP);
  }
}
