import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/init/theme/text_theme/text_theme.dart';

import 'app_theme.dart';

class AppThemeManager extends AppTheme {
  static AppThemeManager? _instance;
  static AppThemeManager get instance {
    return _instance ??= AppThemeManager._init();
  }

  AppThemeManager._init();

  @override
  ThemeData get lightTheme =>
      ThemeData(textTheme: TextThemeManager.instance.textTheme(), brightness: Brightness.light);

  @override
  ThemeData get darkTheme =>
      ThemeData(textTheme: TextThemeManager.instance.textTheme(isDark: true), brightness: Brightness.dark);
}
