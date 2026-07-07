import 'package:autilab_project/features/data/home/data/model/intelligence_test_model.dart';
import 'package:flutter/material.dart';

import '../../core/constants/color_constant.dart';
import '../../core/constants/theme_constant.dart';
import '../../features/data/home/widgets/talent_result_widget.dart';

class IntelligenceData {
  // final String title;
  // final int score;
  final Color gradient1;
  final Color gradient2;

  IntelligenceData({
    // required this.title,
    // required this.score,
    required this.gradient1,
    required this.gradient2,
  });
}

class TestResultWidget extends StatefulWidget {
  const TestResultWidget({
    super.key,
    this.isShowTitle,
    this.isMobile = true,
    this.intelligenceData,
  });
  final bool? isShowTitle;
  final bool isMobile;
  final List<IntelligenceTestModel>? intelligenceData;

  @override
  State<TestResultWidget> createState() => _TestResultWidgetState();
}

class _TestResultWidgetState extends State<TestResultWidget> {
  @override
  Widget build(BuildContext context) {
    final List<IntelligenceData> intelligenceList = [
      IntelligenceData(
        // title: 'Linguistic Intelligence',
        // score: widget.intelligenceData![0].percentage.toInt(),
        gradient1: const Color(0xff5b9fc8),
        gradient2: const Color(0xff5b9fc8),
      ),
      IntelligenceData(
        // title: 'Logical-Mathematical Intelligence',
        // score: widget.intelligenceData![1].percentage.toInt(),
        gradient1: const Color(0xffFF9364),
        gradient2: const Color(0xffF25F33),
      ),
      IntelligenceData(
        // title: 'Visual-Spatial Intelligence',
        // score: widget.intelligenceData![2].percentage.toInt(),
        gradient1: const Color(0xffB09FFF),
        gradient2: const Color(0xff8D79F6),
      ),
      IntelligenceData(
        // title: 'Musical Intelligence',
        // score: widget.intelligenceData![3].percentage.toInt(),
        gradient1: const Color(0xffB09FFF),
        gradient2: const Color(0xff8D79F6),
      ),
      IntelligenceData(
        // title: 'Bodily-Kinesthetic Intelligence',
        // score: widget.intelligenceData![4].percentage.toInt(),
        gradient1: const Color(0xff99FFA3),
        gradient2: const Color(0xff68EE76),
      ),
      IntelligenceData(
        // title: 'Interpersonal Intelligence',
        // score: widget.intelligenceData![5].percentage.toInt(),
        gradient1: const Color(0xffFFD572),
        gradient2: const Color(0xffFEBD38),
      ),
      IntelligenceData(
        // title: 'Naturalistic Intelligence',
        // score: widget.intelligenceData![6].percentage.toInt(),
        gradient1: const Color(0xff72EAFF),
        gradient2: const Color(0xff23C1E4),
      ),
      IntelligenceData(
        // title: 'Social Intelligence',
        // score: widget.intelligenceData![7].percentage.toInt(),
        gradient1: const Color(0xffD796FF),
        gradient2: const Color(0xffB66DD8),
      ),
    ];
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
                children: widget.intelligenceData!.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  return TalentResultWidget(
                    title: data.type.replaceAll('_', '-'),
                    score: data.percentage,
                    gradient1: intelligenceList[index].gradient1,
                    gradient2: intelligenceList[index].gradient2,
                    textStyle: widget.isMobile
                        ? AutilabTextStyle.small18_400
                        : AutilabTextStyle.small20_400,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
