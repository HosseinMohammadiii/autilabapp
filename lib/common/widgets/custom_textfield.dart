import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.label,
    this.padding,
    this.maxLines,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.textInputType,
    this.isObscureText,
    this.lblColor,
    this.borderColor,
  });
  final String label;
  final EdgeInsetsGeometry? padding;
  final int? maxLines;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool? isObscureText;
  final Color? lblColor;
  final Color? borderColor;
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
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(label),
          ),
          hintText: label,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: lblColor ?? Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              color: borderColor ??
                  Colors.grey, // Change this to your desired color
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              color: borderColor ??
                  Colors.grey, // Change this to your desired color
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            gapPadding: 0,
            borderSide: BorderSide(
              color: borderColor ??
                  Colors.grey, // Change this to your desired color
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
