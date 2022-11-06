import 'package:spark_auth_demo/core/init/app_state/app_state.dart';
import 'package:spark_auth_demo/core/init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';

abstract class BaseCubit {
  BuildContext? context;
  NavigationService navigation = NavigationService.instance;
  AppStateManager appStateManager = AppStateManager.instance;
  void setContext(BuildContext context);
  void init();
}
