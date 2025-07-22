import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class TextFieldCardInfo extends StatelessWidget {
  const TextFieldCardInfo({
    super.key,
    this.isMobile = true,
    required this.title,
    required this.width,
    required this.textEditingController,
    required this.focusNode,
    this.maxLength,
    required this.hint,
    required this.keyboardType,
    this.textInputFormat,
  });
  final bool isMobile;
  final String title;

  final double width;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final int? maxLength;
  final String hint;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? textInputFormat;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AutilabTextStyle.small16_400.copyWith(
            fontSize: isMobile ? 16 : 20,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: isMobile ? 55 : 68,
          width: width,
          child: TextField(
            controller: textEditingController,
            focusNode: focusNode,
            cursorColor: Colors.black,
            keyboardType: keyboardType,
            inputFormatters: textInputFormat,
            maxLength: maxLength,
            buildCounter: (context,
                {required currentLength,
                required isFocused,
                required maxLength}) {
              return const SizedBox();
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              hintText: hint,
              hintStyle: AutilabTextStyle.small12_400.copyWith(
                color: AutilabColor.gray,
                fontSize: isMobile ? 12 : 18,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AutilabColor.black,
                  width: isMobile ? 0.5 : 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AutilabColor.black,
                  width: isMobile ? 0.5 : 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AutilabColor.black,
                  width: isMobile ? 0.5 : 1.5,
                ),
              ),
            ),
            onChanged: (value) {
              value.replaceAll(" ", "");
            },
            onTapOutside: (event) {
              //Unfocus TextField
              focusNode.unfocus();
            },
          ),
        ),
      ],
    );
  }
}
