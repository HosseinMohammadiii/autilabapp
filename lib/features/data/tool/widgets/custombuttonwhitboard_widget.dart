import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/theme_constant.dart';

class CustomButtonWhiteBoardWidget extends StatelessWidget {
  const CustomButtonWhiteBoardWidget({
    super.key,
    required this.onTap,
    this.width,
    required this.height,
    required this.color,
    required this.icon,
    required this.title,
  });
  final Function() onTap;
  final double? width;
  final double height;
  final Color color;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/$icon'),
            Text(
              title,
              style: AutilabTextStyle.small12_400,
            ),
          ],
        ),
      ),
    );
  }
}
