import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/color_constant.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({
    super.key,
    required this.icon,
    required this.onTap,
    this.margin,
  });

  final String icon;
  final Function() onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        width: 32,
        height: 32,
        padding: const EdgeInsets.all(6),
        margin: margin ?? const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AutilabColor.bb,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SvgPicture.asset(
          icon,
        ),
      ),
    );
  }
}
