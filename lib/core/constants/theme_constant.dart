import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class AutilabTheme {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AutilabColor.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AutilabColor.white,
      scrolledUnderElevation: 0,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontFamily: 'Fredoka-Medium',
      ),
      bodySmall: TextStyle(
        fontFamily: 'Fredoka-Regular',
      ),
    ),
  );
}
