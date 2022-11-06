import 'package:flutter/material.dart';

extension StringColorExtension on String {
  Color get color => Color(int.parse('0xff$this'));
}
