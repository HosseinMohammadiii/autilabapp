import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class TextFieldCardInfo extends StatelessWidget {
  const TextFieldCardInfo({
    super.key,
    required this.title,
    required this.width,
    required this.textEditingController,
    required this.focusNode,
    this.maxLength,
    required this.hint,
    required this.keyboardType,
    this.textInputFormat,
  });
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
          style: AutilabTextStyle.small16_400,
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 55,
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
              hintStyle: AutilabTextStyle.small12_400
                  .copyWith(color: AutilabColor.gray),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AutilabColor.black,
                  width: 0.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AutilabColor.black,
                  width: 0.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AutilabColor.black,
                  width: 0.5,
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
