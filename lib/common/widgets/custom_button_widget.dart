import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    this.isMobile = true,
    required this.onTap,
    this.width,
    required this.height,
    this.margin,
    this.padding,
    required this.color,
    this.bordeColor,
    this.borderRadius,
    required this.text,
    required this.textStyle,
    this.boxShadow,
  });
  final bool isMobile;
  final Function() onTap;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color color;
  final Color? bordeColor;
  final double? borderRadius;
  final String text;
  final TextStyle textStyle;
  final List<BoxShadow>? boxShadow;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: isMobile ? 40 : 46,
        margin:
            margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: boxShadow,
          color: color,
          border: Border.all(color: bordeColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(isMobile ? 14 : 18),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AutilabTextStyle.small18_400.copyWith(
              fontSize: isMobile ? 16 : 22,
            ),
          ),
        ),
      ),
    );
  }
}
