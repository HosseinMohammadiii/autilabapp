import 'package:flutter/material.dart';

import '../../core/constants/color_constant.dart';
import '../../core/constants/theme_constant.dart';
import '../../features/data/home/widgets/talent_result_widget.dart';

class TestResultWidget extends StatelessWidget {
  const TestResultWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aptitude Test Result',
          style: AutilabTextStyle.small18_400,
        ),
        FittedBox(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            decoration: BoxDecoration(
              color: AutilabColor.primary,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                Text(
                  'Artistic',
                  style: AutilabTextStyle.small18_400,
                ),
                TalentResultLinerWidget(
                  gradient1: Color(0xff5b9fc8),
                  gradient2: Color(0xff5b9fc8),
                  activeLine: 13,
                ),
                Text(
                  'Enterprising',
                  style: AutilabTextStyle.small18_400,
                ),
                TalentResultLinerWidget(
                  gradient1: Color(0xffFF9364),
                  gradient2: Color(0xffF25F33),
                  activeLine: 16,
                ),
                Text(
                  'Investigator',
                  style: AutilabTextStyle.small18_400,
                ),
                TalentResultLinerWidget(
                  gradient1: Color(0xffB09FFF),
                  gradient2: Color(0xff8D79F6),
                  activeLine: 8,
                ),
                Text(
                  'Social',
                  style: AutilabTextStyle.small18_400,
                ),
                TalentResultLinerWidget(
                  gradient1: Color(0xffFE6C6C),
                  gradient2: Color(0xffFE464B),
                  activeLine: 11,
                ),
                Text(
                  'Realistic',
                  style: AutilabTextStyle.small18_400,
                ),
                TalentResultLinerWidget(
                  gradient1: Color(0xff99FFA3),
                  gradient2: Color(0xff68EE76),
                  activeLine: 5,
                ),
                Text(
                  'Conventional',
                  style: AutilabTextStyle.small18_400,
                ),
                TalentResultLinerWidget(
                  gradient1: Color(0xffFFD572),
                  gradient2: Color(0xffFEBD38),
                  activeLine: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
