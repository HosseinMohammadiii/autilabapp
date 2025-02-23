//Widget for display Icons to SignUp Account
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/color_constant.dart';

Widget circularWidgetSignUp({
  required String image,
  required Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 52,
      height: 52,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AutilabColor.lightGray,
        border: Border.all(
          color: AutilabColor.blue,
          width: 0.5,
        ),
      ),
      child: SvgPicture.asset(image),
    ),
  );
}
