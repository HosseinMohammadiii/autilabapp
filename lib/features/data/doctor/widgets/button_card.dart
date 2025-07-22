import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/color_constant.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({
    super.key,
    this.isMobile = true,
    required this.icon,
    required this.onTap,
    this.margin,
  });
  final bool isMobile;
  final String icon;
  final Function() onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isMobile ? 32 : 68,
        height: isMobile ? 32 : 68,
        padding: EdgeInsets.all(isMobile ? 6 : 15),
        margin: margin ?? const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AutilabColor.bb,
          borderRadius: BorderRadius.circular(isMobile ? 12 : 24),
        ),
        child: SvgPicture.asset(
          icon,
        ),
      ),
    );
  }
}
