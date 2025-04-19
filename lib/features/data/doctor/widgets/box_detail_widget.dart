import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class BoxDetailWidget extends StatelessWidget {
  const BoxDetailWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffECF0FF),
        border: Border.all(width: 0.5, color: AutilabColor.bb),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AutilabTextStyle.small14_400,
          ),
          Text(
            subtitle,
            style: AutilabTextStyle.medium16_500,
          ),
        ],
      ),
    );
  }
}
