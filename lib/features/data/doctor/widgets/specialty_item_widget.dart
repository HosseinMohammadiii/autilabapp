import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/Lists/category_items.dart';

class SpecialtyItemWidget extends StatelessWidget {
  const SpecialtyItemWidget({
    super.key,
    required this.index,
    required this.onTap,
  });
  final int index;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: categoryItemsList[index].color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Image.asset(
              categoryItemsList[index].image,
              width: 32,
              height: 32,
            ),
            Text(
              categoryItemsList[index].title,
              style: AutilabTextStyle.small10_400,
            ),
          ],
        ),
      ),
    );
  }
}
