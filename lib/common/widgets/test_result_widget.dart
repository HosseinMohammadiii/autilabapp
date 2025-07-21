import 'package:flutter/material.dart';

import '../../core/constants/color_constant.dart';
import '../../core/constants/theme_constant.dart';
import '../../features/data/home/widgets/talent_result_widget.dart';

class IntelligenceData {
  final String title;
  final int score; // امتیاز از 10
  final Color gradient1;
  final Color gradient2;

  IntelligenceData({
    required this.title,
    required this.score,
    required this.gradient1,
    required this.gradient2,
  });
}

class TestResultWidget extends StatefulWidget {
  const TestResultWidget({
    super.key,
    this.isShowTitle,
  });
  final bool? isShowTitle;

  @override
  State<TestResultWidget> createState() => _TestResultWidgetState();
}

class _TestResultWidgetState extends State<TestResultWidget> {
  final List<IntelligenceData> intelligenceList = [
    IntelligenceData(
      title: 'Linguistic Intelligence',
      score: 6,
      gradient1: const Color(0xff5b9fc8),
      gradient2: const Color(0xff5b9fc8),
    ),
    IntelligenceData(
      title: 'Logical-Mathematical Intelligence',
      score: 8,
      gradient1: const Color(0xffFF9364),
      gradient2: const Color(0xffF25F33),
    ),
    IntelligenceData(
      title: 'Visual-Spatial Intelligence',
      score: 5,
      gradient1: const Color(0xffB09FFF),
      gradient2: const Color(0xff8D79F6),
    ),
    IntelligenceData(
      title: 'Musical Intelligence',
      score: 7,
      gradient1: const Color(0xffB09FFF),
      gradient2: const Color(0xff8D79F6),
    ),
    IntelligenceData(
      title: 'Bodily-Kinesthetic Intelligence',
      score: 4,
      gradient1: const Color(0xff99FFA3),
      gradient2: const Color(0xff68EE76),
    ),
    IntelligenceData(
      title: 'Interpersonal Intelligence',
      score: 8,
      gradient1: const Color(0xffFFD572),
      gradient2: const Color(0xffFEBD38),
    ),
    IntelligenceData(
      title: 'Naturalistic Intelligence',
      score: 7,
      gradient1: const Color(0xff72EAFF),
      gradient2: const Color(0xff23C1E4),
    ),
    IntelligenceData(
      title: 'Social Intelligence',
      score: 8,
      gradient1: const Color(0xffD796FF),
      gradient2: const Color(0xffB66DD8),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.isShowTitle ?? false) ...[
          const Text(
            'Aptitude Test Result',
            style: AutilabTextStyle.small18_400,
          ),
          const SizedBox(
            height: 8,
          ),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          decoration: BoxDecoration(
            color: AutilabColor.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: intelligenceList
                    .map((data) => TalentResultWidget(
                          title: data.title,
                          score: data.score,
                          gradient1: data.gradient1,
                          gradient2: data.gradient2,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
