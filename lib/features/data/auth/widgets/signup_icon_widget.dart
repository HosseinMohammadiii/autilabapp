//Widget for display Icons to SignUp Account
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/color_constant.dart';

Widget circularWidgetSignUp({
  required String image,
  required Function() onTap,
  required bool isMobile,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: isMobile ? 52 : 80,
      height: isMobile ? 52 : 80,
      padding: EdgeInsets.all(isMobile ? 8 : 12),
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
