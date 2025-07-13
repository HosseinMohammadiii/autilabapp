import 'package:flutter/material.dart';

import '../../core/constants/color_constant.dart';
import '../../core/constants/theme_constant.dart';
import '../../features/data/home/widgets/talent_result_widget.dart';

class TestResultWidget extends StatelessWidget {
  const TestResultWidget({
    super.key,
    this.isShowTitle,
  });
  final bool? isShowTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowTitle ?? false) ...[
          const Text(
            'Aptitude Test Result',
            style: AutilabTextStyle.small18_400,
          ),
          const SizedBox(
            height: 8,
          ),
        ],
        FittedBox(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            decoration: BoxDecoration(
              color: AutilabColor.primary,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                Text(
                  'Linguistic Intelligence',
                  style: AutilabTextStyle.small20_400.copyWith(fontSize: 25),
                ),
                const TalentResultLinerWidget(
                  gradient1: Color(0xff5b9fc8),
                  gradient2: Color(0xff5b9fc8),
                  activeLine: 13,
                ),
                Text(
                  'Logical-Mathematical Intelligence',
                  style: AutilabTextStyle.small20_400.copyWith(fontSize: 25),
                ),
                const TalentResultLinerWidget(
                  gradient1: Color(0xffFF9364),
                  gradient2: Color(0xffF25F33),
                  activeLine: 16,
                ),
                Text(
                  'Visual-Spatial Intelligence',
                  style: AutilabTextStyle.small20_400.copyWith(fontSize: 25),
                ),
                const TalentResultLinerWidget(
                  gradient1: Color(0xffB09FFF),
                  gradient2: Color(0xff8D79F6),
                  activeLine: 8,
                ),
                Text(
                  'Musical Intelligence',
                  style: AutilabTextStyle.small20_400.copyWith(fontSize: 25),
                ),
                const TalentResultLinerWidget(
                  gradient1: Color(0xffFE6C6C),
                  gradient2: Color(0xffFE464B),
                  activeLine: 11,
                ),
                Text(
                  'Bodily-Kinesthetic Intelligence',
                  style: AutilabTextStyle.small20_400.copyWith(fontSize: 25),
                ),
                const TalentResultLinerWidget(
                  gradient1: Color(0xff99FFA3),
                  gradient2: Color(0xff68EE76),
                  activeLine: 5,
                ),
                Text(
                  'Interpersonal Intelligence',
                  style: AutilabTextStyle.small20_400.copyWith(fontSize: 25),
                ),
                const TalentResultLinerWidget(
                  gradient1: Color(0xffFFD572),
                  gradient2: Color(0xffFEBD38),
                  activeLine: 14,
                ),
                Text(
                  'Naturalistic Intelligence',
                  style: AutilabTextStyle.small20_400.copyWith(fontSize: 25),
                ),
                const TalentResultLinerWidget(
                  gradient1: Color(0xff72EAFF),
                  gradient2: Color(0xff23C1E4),
                  activeLine: 12,
                ),
                Text(
                  'Social Intelligence',
                  style: AutilabTextStyle.small20_400.copyWith(fontSize: 25),
                ),
                const TalentResultLinerWidget(
                  gradient1: Color(0xffD796FF),
                  gradient2: Color(0xffB66DD8),
                  activeLine: 25,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
