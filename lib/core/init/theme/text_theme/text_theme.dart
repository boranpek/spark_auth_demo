import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spark_auth_demo/core/init/theme/color/app_colors.dart';

class TextThemeManager {
  static TextThemeManager? _instance;
  static TextThemeManager get instance {
    return _instance ??= TextThemeManager.init();
  }

  TextThemeManager.init();

  TextTheme textTheme({isDark = false}) {
    return TextTheme(
      headline1: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: isDark ? DarkColors().primaryColor : LightColors().primaryColor,
      ),
      headline2: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: isDark ? DarkColors().primaryColor : LightColors().primaryColor,
      ),
      bodyText1: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: isDark ? DarkColors().textColor : LightColors().textColor,
      ),
      bodyText2: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isDark ? DarkColors().textColor : LightColors().textColor,
      ),
    );
  }
}
