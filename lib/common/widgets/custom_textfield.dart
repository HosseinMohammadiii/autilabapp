import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.label,
    this.textStyle,
    this.padding,
    this.maxLines,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.textInputType,
    this.isObscureText,
    this.lblColor,
    this.borderColor,
    this.backgroundColor,
    this.borderRaduis,
    this.suffixIcon,
    this.floatingLabelBehavior,
  });
  final String label;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final int? maxLines;
  final double? borderRaduis;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool? isObscureText;
  final Color? lblColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final Widget? suffixIcon;
  final FloatingLabelBehavior? floatingLabelBehavior;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        textAlign: TextAlign.justify,
        obscuringCharacter: '*',
        obscureText: isObscureText ?? false,
        maxLines: maxLines,
        cursorColor: Colors.black,
        style: textStyle ??
            AutilabTextStyle.small14_400.copyWith(
              color: AutilabColor.gray,
            ),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: backgroundColor ?? Colors.transparent,
          label: Text(label),
          labelStyle: AutilabTextStyle.small14_400.copyWith(
            color: lblColor ?? Colors.grey,
            fontSize: 18,
          ),
          floatingLabelBehavior: floatingLabelBehavior,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRaduis ?? 16),
            ),
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRaduis ?? 8),
            ),
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRaduis ?? 8),
            ),
            gapPadding: 4,
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey,
              width: 1,
            ),
          ),
        ),
        onTapOutside: (event) {
          //TextField unfocus
          focusNode?.unfocus();
        },
      ),
    );
  }
}
