import 'package:flutter/material.dart';
import 'package:spark_auth_demo/feature/forgot_password/view/forgot_password_view.dart';
import 'package:spark_auth_demo/feature/login/view/login_view.dart';
import 'package:spark_auth_demo/feature/signup/view/signup_view.dart';
import 'package:spark_auth_demo/feature/splash/view/splash_view.dart';
import '../../constants/navigation/navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.DEFAULT:
        return normalNavigate(const SplashView());
      case NavigationConstants.SIGNUP:
        return normalNavigate(const SignupView());
      case NavigationConstants.LOGIN:
        return normalNavigate(const LoginView());
      case NavigationConstants.FORGOTPASSWORD:
        return normalNavigate(const ForgotPasswordView());
      default:
        return normalNavigate(const SizedBox());
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
