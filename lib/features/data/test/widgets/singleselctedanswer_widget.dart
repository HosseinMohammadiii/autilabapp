import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import '../page/quiz_multiselect_screen.dart';

class SingleSelctedAnswerWidget extends StatefulWidget {
  const SingleSelctedAnswerWidget({
    super.key,
    required this.quizList,
    required this.selectedItems,
  });
  final List<QuizClass> quizList;
  final List<bool> selectedItems;

  @override
  State<SingleSelctedAnswerWidget> createState() =>
      _SingleSelctedAnswerWidgetState();
}

class _SingleSelctedAnswerWidgetState extends State<SingleSelctedAnswerWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              for (int i = 0; i < widget.quizList.length; i++) {
                widget.selectedItems[i] = i == index;
              }
            });
          },
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.selectedItems[index]
                  ? AutilabColor.bb
                  : const Color(0xffECF0FF),
              border: Border.all(color: AutilabColor.bb, width: 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              widget.quizList[index].title,
              style: AutilabTextStyle.small18_400,
            ),
          ),
        );
      },
    );
  }
}
