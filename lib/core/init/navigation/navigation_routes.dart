import 'package:flutter/material.dart';
import 'package:spark_auth_demo/feature/sample/view/sample_view.dart';
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
      case NavigationConstants.SAMPLE:
        return normalNavigate(const SampleView());
      default:
        return normalNavigate(const SizedBox());
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
