import 'package:spark_auth_demo/core/init/theme/color/app_colors.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  double dynamicHeight(double multiplier) {
    return height * (multiplier / 812);
  }
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
          backgroundColor: appColors.white,
        ),
      );
}

extension DialogExtension on BuildContext {
  dynamic customShowDialog({String? title}) => showDialog(
        context: this,
        builder: (ctx) => AlertDialog(
          title: Text(
            title ?? 'Something is wrong',
            textAlign: TextAlign.center,
            style: textTheme.headline2,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [],
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'OK',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      );

  dynamic loadingDialog() => showDialog(
        context: this,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Please wait...',
            textAlign: TextAlign.center,
            style: textTheme.headline2,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CircularProgressIndicator(color: appColors.primaryColor),
              ),
            ],
          ),
        ),
      );
}
