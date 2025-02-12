import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.onTap,
    this.width,
    required this.height,
    this.margin,
    required this.color,
    this.borderRadius,
    required this.text,
    required this.textStyle,
  });
  final Function() onTap;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? margin;
  final Color color;
  final double? borderRadius;
  final String text;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        margin:
            margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
