import 'package:flutter/material.dart';

import '../constants/app/app_constants.dart';

extension StringColorExtension on String {
  Color get color => Color(int.parse('0xff$this'));
  bool? get isValidEmail => contains(RegExp(AppConstants.EMAIL_REGEX));
}
