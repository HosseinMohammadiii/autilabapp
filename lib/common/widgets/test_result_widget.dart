import 'package:autilab_project/features/data/home/data/model/intelligence_test_model.dart';
import 'package:flutter/material.dart';

import '../../core/constants/color_constant.dart';
import '../../core/constants/theme_constant.dart';
import '../../features/data/home/widgets/talent_result_widget.dart';

class IntelligenceData {
  final String title;
  final int score;
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
                children: widget.intelligenceData!
                    .map((data) => TalentResultWidget(
                          title: data.type.replaceAll('_', '-'),
                          score: data.percentage,
                          gradient1: const Color(0xff72EAFF),
                          gradient2: const Color(0xff23C1E4),
                          textStyle: widget.isMobile
                              ? AutilabTextStyle.small18_400
                              : AutilabTextStyle.small20_400,
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
