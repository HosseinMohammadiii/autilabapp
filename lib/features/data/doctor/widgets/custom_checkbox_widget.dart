import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';

class CustomCheckbox extends StatelessWidget {
  final String title;
  final int index;
  final ValueNotifier<bool?> selectedIndexNotifier;
  final Function(bool? value) onChanged;
  final TextStyle? textStyle;
  final OutlinedBorder? shape;

  const CustomCheckbox({
    super.key,
    required this.title,
    required this.index,
    required this.onChanged,
    required this.selectedIndexNotifier,
    this.textStyle,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool?>(
      valueListenable: selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        return Row(
          children: [
            SizedBox(
              height: 45,
              width: 30,
              child: Checkbox(
                activeColor: AutilabColor.blue,
                checkColor: AutilabColor.white,
                side: const BorderSide(width: 0.5),
                splashRadius: 0,
                shape: shape,
                value: selectedIndexNotifier.value ?? false,
                onChanged: (value) {
                  onChanged(value);
                },
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                title,
                style: textStyle ?? AutilabTextStyle.small14_400,
              ),
            ),
          ],
        );
      },
    );
  }
}
