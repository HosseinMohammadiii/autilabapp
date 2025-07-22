import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class BoxDetailWidget extends StatelessWidget {
  const BoxDetailWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.isMobile = true,
  });
  final String title;
  final String subtitle;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: isMobile ? 50 : 60,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffECF0FF),
        border: Border.all(width: 0.5, color: AutilabColor.bb),
        borderRadius: BorderRadius.circular(isMobile ? 16 : 32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AutilabTextStyle.small14_400
                .copyWith(fontSize: isMobile ? 14 : 20),
          ),
          Text(
            subtitle,
            style: AutilabTextStyle.medium16_500.copyWith(
              fontSize: isMobile ? 16 : 24,
            ),
          ),
        ],
      ),
    );
  }
}
