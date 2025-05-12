import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/appbar_back_screen.dart';
import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/animation_control.dart';

class QuizSingleselectScreen extends StatefulWidget {
  const QuizSingleselectScreen({super.key});

  @override
  State<QuizSingleselectScreen> createState() => _QuizSingleselectScreenState();
}

class _QuizSingleselectScreenState extends State<QuizSingleselectScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  bool isSelected = false;
  List<bool> selectedItems = [];

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
  void didUpdateWidget(covariant QuizSingleselectScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

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
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              for (int i = 0; i < selectedItems.length; i++) {
                                selectedItems[i] = i == index;
                              }
                            });
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: selectedItems[index]
                                  ? AutilabColor.bb
                                  : const Color(0xffECF0FF),
                              border: Border.all(
                                  color: AutilabColor.bb, width: 0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              'Answer',
                              style: AutilabTextStyle.small18_400,
                            ),
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
                      onTap: () {
                        context.canPop() ? context.pop() : null;
                      },
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
