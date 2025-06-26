import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PalnItemWidget extends StatelessWidget {
  const PalnItemWidget({
    super.key,
    this.title,
  });
  final String? title;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          Container(
            width: 23,
            height: 23,
            margin: const EdgeInsets.only(right: 4),
            decoration: const BoxDecoration(
              color: AutilabColor.yellow,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/tick_icon.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
          Text(
            title ?? ' Initial Test To Determine How Much You Are',
            style: AutilabTextStyle.small14_400,
          ),
        ],
      ),
    );
  }
}
