import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';

class CustomCheckbox extends StatelessWidget {
  final String title;
  final int index;
  final ValueNotifier<int?> selectedIndexNotifier;
  final TextStyle? textStyle;
  final OutlinedBorder? shape;

  const CustomCheckbox({
    super.key,
    required this.title,
    required this.index,
    required this.selectedIndexNotifier,
    this.textStyle,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int?>(
      valueListenable: selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        selectedIndex ??= 1;
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
                value: selectedIndex == index,
                onChanged: (value) {
                  if (value == true) {
                    selectedIndexNotifier.value = index;
                  }
                },
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              title,
              style: textStyle ?? AutilabTextStyle.small14_400,
            ),
          ],
        );
      },
    );
  }
}
