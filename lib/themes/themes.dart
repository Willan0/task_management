import 'package:flutter/material.dart';
import 'package:task_management/constant/color.dart';

class Themes {
  static final light = ThemeData(
      colorScheme: const ColorScheme.light(),
      primaryColor: primaryColor,
      brightness: Brightness.light);
  static final dark = ThemeData(
      colorScheme: const ColorScheme.dark(),
      primaryColor: darkColor,
      brightness: Brightness.dark);
}
