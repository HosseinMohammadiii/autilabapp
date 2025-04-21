import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class AutilabTheme {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AutilabColor.white,
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: AutilabColor.white),
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

class AutilabMargin {
  static const EdgeInsets marginFullScreen =
      EdgeInsets.symmetric(horizontal: 20);

  static const EdgeInsets marginVertical_48 =
      EdgeInsets.symmetric(vertical: 48);
}

class AutilabTextStyle {
  static const TextStyle medium12_500 = TextStyle(
    fontFamily: 'Fredoka-Medium',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle medium14_500 = TextStyle(
    fontFamily: 'Fredoka-Medium',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle medium16_400 = TextStyle(
    fontFamily: 'Fredoka-Medium',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle medium16_500 = TextStyle(
    fontFamily: 'Fredoka-Medium',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle medium18_400 = TextStyle(
    fontFamily: 'Fredoka-Medium',
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle medium18_500 = TextStyle(
    fontFamily: 'Fredoka-Medium',
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle medium20_500 = TextStyle(
    fontFamily: 'Fredoka-Medium',
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle medium24_500 = TextStyle(
    fontFamily: 'Fredoka-Medium',
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle small10_400 = TextStyle(
    fontFamily: 'Fredoka-Regular',
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle small12_400 = TextStyle(
    fontFamily: 'Fredoka-Regular',
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle small14_400 = TextStyle(
    fontFamily: 'Fredoka-Regular',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle small14_500 = TextStyle(
    fontFamily: 'Fredoka-Regular',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle small16_400 = TextStyle(
    fontFamily: 'Fredoka-Regular',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle small18_400 = TextStyle(
    fontFamily: 'Fredoka-Regular',
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle small20_400 = TextStyle(
    fontFamily: 'Fredoka-Regular',
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle small24_400 = TextStyle(
    fontFamily: 'Fredoka-Regular',
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );
}
