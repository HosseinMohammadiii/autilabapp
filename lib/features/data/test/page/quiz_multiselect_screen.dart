import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';

import '../../../../utils/functions/animation_control.dart';

class QuizClass {
  String title;
  bool value;
  QuizClass(this.title, this.value);
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  late AnimationHelper animationHelper;
  final ValueNotifier<int?> selectedIndexNotifier = ValueNotifier<int?>(null);

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant QuizScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  List<QuizClass> quizList = [
    QuizClass('Answer', false),
    QuizClass('Answer', false),
    QuizClass('Answer', false),
    QuizClass('Answer', false),
  ];
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(context: context, title: 'Quiz', isIcon: true),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const Padding(
                      padding: AutilabMargin.marginFullScreen,
                      child: Center(
                        child: Text(
                          'Which Of The Following Is Correct Regarding Your Child?',
                          style: AutilabTextStyle.small14_400,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xffECF0FF),
                            border:
                                Border.all(color: AutilabColor.bb, width: 0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 12,
                            children: [
                              SizedBox(
                                width: 15,
                                height: 15,
                                child: Checkbox(
                                  value: quizList[index].value,
                                  activeColor: AutilabColor.blue,
                                  checkColor: AutilabColor.white,
                                  side: const BorderSide(width: 1),
                                  splashRadius: 0,
                                  onChanged: (value) {
                                    setState(() {
                                      quizList[index].value =
                                          !quizList[index].value;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                quizList[index].title,
                                style: AutilabTextStyle.small18_400,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomButtonWidget(
                      onTap: () {},
                      width: 166,
                      height: 50,
                      bordeColor: AutilabColor.bb,
                      margin: const EdgeInsets.only(left: 20, bottom: 40),
                      color: const Color(0xffECF0FF),
                      text: 'Back',
                      textStyle: AutilabTextStyle.small18_400,
                    ),
                    CustomButtonWidget(
                      onTap: () {},
                      width: 166,
                      height: 50,
                      margin: const EdgeInsets.only(right: 20, bottom: 40),
                      color: AutilabColor.bb,
                      text: 'Next',
                      textStyle: AutilabTextStyle.small18_400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
