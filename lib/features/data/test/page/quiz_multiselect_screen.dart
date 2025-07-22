import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/custom_textfield.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/test/widgets/multiselectanswer_widget.dart';
import 'package:autilab_project/features/data/test/widgets/singleselctedanswer_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/functions/animation_control.dart';

class QuizClass {
  String title;
  bool value;
  QuizClass(this.title, this.value);
}

class QuizAndSelectAnswerScreen extends StatefulWidget {
  const QuizAndSelectAnswerScreen({super.key});

  @override
  State<QuizAndSelectAnswerScreen> createState() =>
      _QuizAndSelectAnswerScreenState();
}

class _QuizAndSelectAnswerScreenState extends State<QuizAndSelectAnswerScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  final pageController = PageController();

  final textEditingController = TextEditingController();
  final textFocusNode = FocusNode();
  List<bool> selectedItems = [];

  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
    selectedItems = List<bool>.filled(4, false);
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant QuizAndSelectAnswerScreen oldWidget) {
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
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile() {
          if (constraints.maxWidth < 600) {
            return true;
          } else {
            return false;
          }
        }

        return FadeTransition(
          opacity: animationHelper.fadeAnimation,
          child: Scaffold(
            appBar: appBarWidget(
              context: context,
              title: 'Quiz',
              isIcon: true,
              isMobile: isMobile(),
            ),
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: AutilabMargin.marginFullScreen,
                          child: Text(
                            'Which Of The Following Is Correct Regarding Your Child?',
                            style: AutilabTextStyle.small14_400.copyWith(
                              fontSize: isMobile() ? 14 : 24,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 400,
                          child: PageView.builder(
                            onPageChanged: (value) {
                              setState(() {
                                currentPage = value;
                              });
                            },
                            physics: const NeverScrollableScrollPhysics(),
                            controller: pageController,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return MultiSelectAnswerWidget(
                                  isMobile: isMobile(),
                                  quizList: quizList,
                                );
                              } else if (index == 1) {
                                return SingleSelctedAnswerWidget(
                                  isMobile: isMobile(),
                                  quizList: quizList,
                                  selectedItems: selectedItems,
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: CustomTextfield(
                                    label: 'Type Here',
                                    controller: textEditingController,
                                    focusNode: textFocusNode,
                                    maxLines: 12,
                                    borderWidth: isMobile() ? 0.5 : 2,
                                    borderRaduis: isMobile() ? 16 : 24,
                                    textStyle:
                                        AutilabTextStyle.small18_400.copyWith(
                                      fontSize: isMobile() ? 18 : 24,
                                    ),
                                    lblColor: AutilabColor.gray,
                                    backgroundColor: const Color(0xffECF0FF),
                                    borderColor: AutilabColor.bb,
                                    textInputAction: TextInputAction.done,
                                    textInputType: TextInputType.text,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: AutilabMargin.marginFullScreen,
                    sliver: SliverFillRemaining(
                      fillOverscroll: false,
                      hasScrollBody: false,
                      child: Row(
                        spacing: 18,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomButtonWidget(
                            onTap: () {
                              //Previous page
                              pageController.animateToPage(
                                pageController.page!.toInt() - 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            height: 50,
                            isMobile: isMobile(),
                            bordeColor: AutilabColor.bb,
                            margin: const EdgeInsets.only(bottom: 40),
                            color: const Color(0xffECF0FF),
                            text: 'Back',
                            textStyle: AutilabTextStyle.small18_400.copyWith(
                              fontSize: isMobile() ? 18 : 24,
                            ),
                          ),
                          CustomButtonWidget(
                            onTap: () {
                              //Next page
                              pageController.animateToPage(
                                pageController.page!.toInt() + 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                              if (currentPage == 2) {
                                context.pop();
                                context.pop();
                              }
                            },
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            height: 50,
                            isMobile: isMobile(),
                            margin: const EdgeInsets.only(bottom: 40),
                            color: AutilabColor.bb,
                            text: currentPage != 2 ? 'Next' : 'Submit',
                            textStyle: AutilabTextStyle.small18_400.copyWith(
                              fontSize: isMobile() ? 18 : 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
