import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/extensions/string_extensions.dart';

abstract class AppColors {
  //Unique Colors
  Color white = 'FFFFFF'.color;
  Color nasuPurple = '6624CB'.color;
  Color periwinkle = '8C7BFF'.color;
  Color slaaneshGrey = 'DCD4E7'.color;
  Color trumpeter = '8D7AAA'.color;

  //Overrided Colors
  late Color primaryColor;
  late Color primaryButtonColor;
  late Color secondaryButtonColor;
  late Color borderColor;
  late Color textColor;
}

class LightColors extends AppColors {
  @override
  Color get primaryColor => nasuPurple;
  @override
  Color get primaryButtonColor => nasuPurple;
  @override
  Color get secondaryButtonColor => periwinkle;
  @override
  Color get borderColor => slaaneshGrey;
  @override
  Color get textColor => trumpeter;
}

class DarkColors extends AppColors {
  @override
  Color get primaryColor => nasuPurple;
  @override
  Color get primaryButtonColor => nasuPurple;
  @override
  Color get secondaryButtonColor => periwinkle;
  @override
  Color get borderColor => slaaneshGrey;
  @override
  Color get textColor => trumpeter;
}
