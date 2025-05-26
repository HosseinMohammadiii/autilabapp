import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/theme_constant.dart';

class BoxWhiteBoardWidget extends StatelessWidget {
  const BoxWhiteBoardWidget({
    super.key,
    required this.onTapOne,
    required this.colorOne,
    required this.iconOne,
    required this.titleOne,
    required this.onTapSecond,
    required this.colorSecond,
    required this.iconSecond,
    required this.titleSecond,
  });
  final Function() onTapOne;
  final Color colorOne;
  final String iconOne;
  final String titleOne;
  final Function() onTapSecond;
  final Color colorSecond;
  final String iconSecond;
  final String titleSecond;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Container(
          width: 72,
          height: 56,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: colorOne,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2,
            children: [
              SvgPicture.asset('assets/icons/$iconOne'),
              Text(
                titleOne,
                style: AutilabTextStyle.small10_400,
              ),
            ],
          ),
        ),
        Container(
          width: 72,
          height: 56,
          decoration: BoxDecoration(
            color: colorSecond,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2,
            children: [
              SvgPicture.asset('assets/icons/$iconSecond'),
              Text(
                titleSecond,
                style: AutilabTextStyle.small10_400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
