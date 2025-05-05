import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AutilabTextStyle.small14_400,
        ),
        const Expanded(
          child: Divider(
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: AutilabColor.gray,
          ),
        ),
        Text(
          subTitle,
          style: AutilabTextStyle.medium14_500,
        ),
      ],
    );
  }
}
