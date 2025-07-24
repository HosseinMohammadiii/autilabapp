import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';

class TextFieldBoxEnterDescription extends StatelessWidget {
  const TextFieldBoxEnterDescription({
    super.key,
    required this.textStyle,
    required this.descriptionController,
    required this.descriptionFocusNode,
    this.isEnable,
    required this.hintText,
    this.bordeColor,
    this.borderRadius,
    this.maxLine,
  });
  final TextStyle? textStyle;
  final TextEditingController descriptionController;
  final FocusNode descriptionFocusNode;
  final bool? isEnable;
  final String hintText;
  final Color? bordeColor;
  final double? borderRadius;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: descriptionController,
      focusNode: descriptionFocusNode,
      enabled: isEnable,
      cursorColor: Colors.black,
      maxLines: maxLine ?? 6,
      style: textStyle,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textStyle ??
            AutilabTextStyle.small14_400.copyWith(
              color: AutilabColor.gray,
            ),
        fillColor: AutilabColor.primary,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 24),
          borderSide: const BorderSide(
            color: AutilabColor.gray,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 24),
          borderSide: BorderSide(
            color: bordeColor ?? AutilabColor.gray,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 24),
          borderSide: BorderSide(
            color: bordeColor ?? AutilabColor.gray,
            width: 1,
          ),
        ),
      ),
      onChanged: (value) {},
      onTapOutside: (event) {
        //Unfocus TextField
        descriptionFocusNode.unfocus();
      },
    );
  }
}
