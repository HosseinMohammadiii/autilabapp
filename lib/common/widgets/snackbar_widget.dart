import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';

void displaySnackBar(
  BuildContext context,
  String text,
  Color backgroundColor,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: AutilabTextStyle.medium18_400,
      ),
      backgroundColor: backgroundColor,
    ),
  );
}
