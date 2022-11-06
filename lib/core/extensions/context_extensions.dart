import 'package:spark_auth_demo/core/init/theme/color/app_colors.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  Brightness get brightness => theme.brightness;
}

extension ColorExtension on BuildContext {
  AppColors get appColors =>
      brightness == Brightness.dark ? DarkColors() : LightColors();
}

extension SnackBarExtension on BuildContext {
  dynamic showSnackBar(String text) => ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(text, style: textTheme.bodyText1),
          backgroundColor: Colors.teal,
        ),
      );
}
