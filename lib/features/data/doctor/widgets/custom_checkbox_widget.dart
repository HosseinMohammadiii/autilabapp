import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';

class CustomCheckbox extends StatelessWidget {
  final String title;
  final int index;
  final ValueNotifier<int?> selectedIndexNotifier;

  const CustomCheckbox({
    super.key,
    required this.title,
    required this.index,
    required this.selectedIndexNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int?>(
      valueListenable: selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        return Row(
          children: [
            SizedBox(
              height: 35,
              width: 20,
              child: Checkbox(
                activeColor: AutilabColor.blue,
                checkColor: AutilabColor.white,
                side: const BorderSide(width: 0.5),
                splashRadius: 0,
                value: selectedIndex == index,
                onChanged: (value) {
                  if (value == true) {
                    selectedIndexNotifier.value = index;
                  }
                },
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: AutilabTextStyle.small14_400,
            ),
          ],
        );
      },
    );
  }
}
