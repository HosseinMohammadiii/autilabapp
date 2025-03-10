import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/theme_constant.dart';

class DisplayTitleSection extends StatelessWidget {
  const DisplayTitleSection({
    super.key,
    required this.icon,
    required this.title,
  });
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AutilabMargin.marginFullScreen,
      child: Row(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(
            width: 4,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
