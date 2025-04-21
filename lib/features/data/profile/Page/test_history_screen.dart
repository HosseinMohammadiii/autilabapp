import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/custom_tabbar_widget.dart';
import 'package:autilab_project/common/widgets/test_result_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';

import '../../../../utils/functions/animation_control.dart';

class TalentTest {
  Color color;
  String title;
  TalentTest(this.color, this.title);
}

class TestHistoryScreen extends StatefulWidget {
  const TestHistoryScreen({super.key});

  @override
  State<TestHistoryScreen> createState() => _TestHistoryScreenState();
}

class _TestHistoryScreenState extends State<TestHistoryScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

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
  void didUpdateWidget(covariant TestHistoryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  List<TalentTest> talentTestItem = [
    TalentTest(const Color(0xffDADB88), 'Full Screen'),
    TalentTest(const Color(0xffAFDB88), 'Manage File'),
    TalentTest(const Color(0xff88A4DB), 'Security'),
    TalentTest(const Color(0xff88DBD5), 'Record Screen'),
    TalentTest(const Color(0xffDB88D5), 'Help'),
    TalentTest(const Color(0xffE5898A), 'Screen Setting'),
  ];
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar:
            appBarWidget(context: context, title: 'Test History', isIcon: true),
        body: SafeArea(
          child: CustomTabBarWidget(
            tabLength: 2,
            tabBar: const [
              Text(
                'Personality Test',
                style: AutilabTextStyle.small16_400,
              ),
              Text(
                'Talent Test',
                style: AutilabTextStyle.small16_400,
              ),
            ],
            tabBarView: [
              SingleChildScrollView(
                child: Padding(
                  padding: AutilabMargin.marginFullScreen,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                        style: AutilabTextStyle.small16_400,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Text(
                        'Aptitude Test Result',
                        style: AutilabTextStyle.small18_400,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const TestResultWidget(),
                      CustomButtonWidget(
                        onTap: () {},
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 48, top: 48),
                        color: AutilabColor.bb,
                        text: 'Take Test Again',
                        textStyle: AutilabTextStyle.small18_400,
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: AutilabMargin.marginFullScreen,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                        style: AutilabTextStyle.small16_400,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        height: 457,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xffECF0FF),
                          border: Border.all(color: AutilabColor.bb),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: talentTestItem.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 8,
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: talentTestItem[index].color,
                                          ),
                                        ),
                                        Text(
                                          talentTestItem[index].title,
                                          style: AutilabTextStyle.small16_400,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ],
                                    ),
                                    if (index < talentTestItem.length - 1)
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: index ==
                                                    talentTestItem.length - 1
                                                ? 0
                                                : 16),
                                        child: const Divider(
                                          thickness: 0.5,
                                          color: AutilabColor.bb,
                                        ),
                                      ),
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      CustomButtonWidget(
                        onTap: () {},
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 48, top: 48),
                        color: AutilabColor.bb,
                        text: 'Take Test Again',
                        textStyle: AutilabTextStyle.small18_400,
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
  }
}
