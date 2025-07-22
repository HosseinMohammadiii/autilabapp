import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import '../page/quiz_multiselect_screen.dart';

class MultiSelectAnswerWidget extends StatefulWidget {
  const MultiSelectAnswerWidget({
    super.key,
    this.isMobile = true,
    required this.quizList,
  });
  final bool isMobile;
  final List<QuizClass> quizList;

  @override
  State<MultiSelectAnswerWidget> createState() =>
      _MultiSelectAnswerWidgetState();
}

class _MultiSelectAnswerWidgetState extends State<MultiSelectAnswerWidget> {
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
              widget.quizList[index].value = !widget.quizList[index].value;
            });
          },
          child: Container(
            height: widget.isMobile ? 50 : 72,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xffECF0FF),
              border: Border.all(
                  color: AutilabColor.bb, width: widget.isMobile ? 0.5 : 2),
              borderRadius: BorderRadius.circular(widget.isMobile ? 16 : 24),
            ),
            child: Row(
              spacing: 12,
              children: [
                SizedBox(
                  width: widget.isMobile ? 15 : 24,
                  height: widget.isMobile ? 15 : 24,
                  child: Checkbox(
                    value: widget.quizList[index].value,
                    activeColor: AutilabColor.blue,
                    checkColor: AutilabColor.white,
                    tristate: true,
                    side: const BorderSide(width: 1),
                    splashRadius: 0,
                    onChanged: (value) {},
                  ),
                ),
                Text(
                  widget.quizList[index].title,
                  style: AutilabTextStyle.small18_400.copyWith(
                    fontSize: widget.isMobile ? 18 : 24,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
