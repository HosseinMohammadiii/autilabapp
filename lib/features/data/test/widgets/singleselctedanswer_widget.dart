// import 'package:autilab_project/features/data/test/data/model/intelligence_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import '../presentation/page/quiz_multiselect_screen.dart';

class SingleSelctedAnswerWidget extends StatefulWidget {
  const SingleSelctedAnswerWidget({
    super.key,
    this.isMobile = true,
    required this.quizList,
    required this.selectedItems,
    this.onTap,
  });
  final bool isMobile;

  final List<TestClass> quizList;
  final List<bool> selectedItems;
  final Function(int questionId, int awnserId)? onTap;

  @override
  State<SingleSelctedAnswerWidget> createState() =>
      _SingleSelctedAnswerWidgetState();
}

class _SingleSelctedAnswerWidgetState extends State<SingleSelctedAnswerWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.quizList.length,
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
            if (widget.onTap != null) {
              widget.onTap!(widget.quizList[index].questionId,
                  widget.quizList[index].awnserId);
            }
          },
          child: Container(
            height: widget.isMobile ? 50 : 72,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.selectedItems[index]
                  ? AutilabColor.bb
                  : const Color(0xffECF0FF),
              border: Border.all(
                  color: AutilabColor.bb, width: widget.isMobile ? 0.5 : 2),
              borderRadius: BorderRadius.circular(widget.isMobile ? 16 : 24),
            ),
            child: Text(
              widget.quizList[index].title,
              style: AutilabTextStyle.small18_400.copyWith(
                fontSize: widget.isMobile ? 18 : 24,
              ),
            ),
          ),
        );
      },
    );
  }
}
